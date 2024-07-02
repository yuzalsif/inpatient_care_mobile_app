import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inpatient_repository/inpatient_repository.dart';
import 'package:patient_list/src/inpatient_list_cubit.dart';

//TODO: code formatting
class InpatientListScreen extends StatelessWidget {
  final InpatientRepository inpatientRepository;

  const InpatientListScreen({super.key, required this.inpatientRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InpatientCubit(inpatientRepository),
      child: const InpatientList(
      ),
    );
  }
}

class InpatientList extends StatelessWidget {
  const InpatientList({super.key,});

  @override
  Widget build(BuildContext context) {
    final inpatientCubit = context.read<InpatientCubit>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(Spacing.mediumLarge),
            child: CustomSearchBar(
              onChanged: (searchTerm) {
                inpatientCubit.searchInpatients(searchTerm);
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
                    inpatientCubit: inpatientCubit,
                    onScrollEnd: () {
                      inpatientCubit.loadMoreInpatients();
                    },
                  );
                }
                if (state is InpatientSearching) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InpatientSearchLoaded) {
                  return InpatientListView(
                    inpatients: state.inpatients,
                    inpatientCubit: inpatientCubit,
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
  final InpatientCubit inpatientCubit;

  const InpatientListView({
    super.key,
    required this.inpatients,
    required this.hasReachedMax,
    required this.onScrollEnd,
    required this.inpatientCubit,
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
            final bool isSelected = inpatientCubit.state is InpatientLoaded &&
                (inpatientCubit.state as InpatientLoaded)
                        .selectedInpatient
                        ?.id ==
                    inpatient.id;
            return Column(
              children: [
                PatientCard(
                  name: inpatient.name,
                  sex: inpatient.gender,
                  age: inpatient.age,
                  inpatient: inpatient,
                  isSelected: isSelected,
                  onSelected: () {
                    inpatientCubit.selectInpatient(inpatient);
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
class PatientCard extends StatelessWidget {
  final String name;
  final String sex;
  final int age;
  final VoidCallback onSelected;
  final Inpatient inpatient;
  final bool isSelected;

  const PatientCard({
    super.key,
    required this.name,
    required this.sex,
    required this.age,
    required this.onSelected,
    required this.inpatient,
    this.isSelected = false,
  });

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
        onSelected();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3579F8).withOpacity(0.1) : Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: const Color(0xFFF2F2F2),
                child: Icon(Icons.person, size: 60, color: Colors.grey[350]),
              ),
              const SizedBox(width: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sex: $sex',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Age: $age',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
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
