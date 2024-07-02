import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpatient_api/inpatient_api.dart';
import 'package:inpatient_repository/inpatient_repository.dart';
import 'package:patient_list/src/inpatient_list_cubit.dart';
import './patient_detail_temp_screen.dart';

//TODO: code formatting
class InpatientListScreen extends StatelessWidget {
  final InpatientRepository inpatientRepository;

  const InpatientListScreen({super.key, required this.inpatientRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InpatientCubit(inpatientRepository),
      child: InpatientList(
        inpatientRepository: inpatientRepository,
      ),
    );
  }
}

class InpatientList extends StatelessWidget {
  final InpatientRepository inpatientRepository;

  const InpatientList({super.key, required this.inpatientRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Spacing.mediumLarge),
            child: CustomSearchBar(
              onChanged: (searchTerm) {
                context.read<InpatientCubit>().searchInpatients(searchTerm);
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Patients',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: BlocBuilder<InpatientCubit, InpatientState>(
              builder: (context, state) {
                if (state is InpatientLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InpatientLoaded) {
                  return InpatientListView(
                    inpatients: state.inpatients,
                    hasReachedMax: state.hasReachedMax,
                    inpatientRepository: inpatientRepository,
                    onScrollEnd: () {
                      context.read<InpatientCubit>().loadMoreInpatients();
                    },
                  );
                }
                if (state is InpatientSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InpatientSearchLoaded) {
                  return InpatientListView(
                    inpatients: state.inpatients,
                    inpatientRepository: inpatientRepository,
                    hasReachedMax: true,
                    onScrollEnd: () {}, // No pagination for search results
                  );
                } else if (state is InpatientError) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is InpatientSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('Unknown state.'));
                }
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Trigger the fetchInpatients method from InpatientCubit
      //     context.read<InpatientCubit>().fetchInpatients();
      //   },
      //   child: Icon(Icons.refresh),
      // ),
    );
  }
}

class InpatientListView extends StatelessWidget {
  final List<Inpatient> inpatients;
  final bool hasReachedMax;
  final VoidCallback onScrollEnd;
  final InpatientRepository inpatientRepository;

  const InpatientListView({
    super.key,
    required this.inpatients,
    required this.hasReachedMax,
    required this.onScrollEnd,
    required this.inpatientRepository,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification is ScrollEndNotification &&
            scrollNotification.metrics.extentAfter == 0) {
          onScrollEnd();
        }
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
          itemCount: inpatients.length + (hasReachedMax ? 0 : 1),
          itemBuilder: (context, index) {
            if (index >= inpatients.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final inpatient = inpatients[index];
            return Column(
              children: [
                PatientCard(
                  name: inpatient.name,
                  sex: inpatient.gender,
                  age: inpatient.age,
                  inpatient: inpatient,
                  onSelected: () {
                    inpatientRepository.selectInpatient(inpatient);
                  },
                ),
                const SizedBox(
                  height: 12,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

//TODO: to be removed
class PatientCard extends StatefulWidget {
  final String name;
  final String sex;
  final int age;
  final VoidCallback onSelected;
  final Inpatient inpatient;

  PatientCard(
      {required this.name,
      required this.sex,
      required this.age,
      required this.onSelected,
      required this.inpatient});

  @override
  _PatientCardState createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         InpatientDetailScreen(inpatient: widget.inpatient),
        //   ),
        // );
        widget.onSelected();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF3579F8) : Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: Color(0xFFF2F2F2),
                child: Icon(Icons.person, size: 60, color: Colors.grey[350]),
              ),
              SizedBox(width: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Sex: ${widget.sex}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white70 : Colors.grey,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Age: ${widget.age}',
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected ? Colors.white70 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: to be removed
class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search for a patient',
          icon: Icon(Icons.search),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
