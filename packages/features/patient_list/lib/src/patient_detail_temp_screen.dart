import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class InpatientDetailScreen extends StatelessWidget {
  final Inpatient inpatient;

  const InpatientDetailScreen({Key? key, required this.inpatient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PatientDetailCard(
                name: inpatient.name,
                sex: inpatient.gender,
                age: '${inpatient.age}',
                phoneNumber: inpatient.phoneNumber,
              ),
            const SizedBox(height: 10,),
              const TabBar(
                labelColor: Colors.black,
                indicatorColor: Colors.blue,
                //isScrollable: true,
                indicatorWeight: 2.0,
                //labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
                tabs: [
                  Tab(text: 'Summary'),
                  Tab(text: 'Investigation'),
                  Tab(text: 'Management'),
                ],
               labelPadding: EdgeInsets.symmetric(horizontal: 8.0), // Adjust the padding
              ),
               Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Column(children: [
    Image.network('https://drive.google.com/uc?export=download&id=1kjZxZkd4TXjC-95KUNItuG_cSe5Vpnkb',),
    Text('build data')
  ],)),
                    Center(child: Text('Investigation Content')),
                    Center(child: Text('Management Content')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PatientDetailCard extends StatelessWidget {
  final String name;
  final String sex;
  final String age;
  final String phoneNumber;

  const PatientDetailCard(
      {required this.name,
      required this.sex,
      required this.age,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 42,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, size: 70, color: Colors.grey),
            ),
            const SizedBox(width: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
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
                const SizedBox(height: 4,),
                Text(
                  'Contacts: $phoneNumber',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSummaryData() {
  return Column(children: [
    Image.asset('assets/images/no_data.png'),
    Text('build data')
  ],);
}