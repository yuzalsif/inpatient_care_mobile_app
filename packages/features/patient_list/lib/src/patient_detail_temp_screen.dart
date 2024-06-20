import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:patient_list/src/nurse_treatment_sheet.dart';
import 'package:patient_list/src/obsrvation_chart.dart';

class InpatientDetailScreen extends StatelessWidget {
  final Inpatient inpatient;

  const InpatientDetailScreen({Key? key, required this.inpatient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F5F5),
          title: const Text('Round Form'),
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'sheets',
                  child: ListTile(
                    title: Text('Nurse treatment sheet'),
                    leading: Icon(Icons.description),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'charts',
                  child: ListTile(
                    title: Text('Observation chart'),
                    leading: Icon(Icons.insert_chart),
                  ),
                ),
              ],
              onSelected: (String value) {
                // Handle menu item selection
                switch (value) {
                  case 'sheets':
                    Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NurseTreatmentSheet(),
          ),
        
                    );
                    break;
                  case 'charts':
                    Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObservationChart(),
          ),
        
                    
                    );
                    break;
                }
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF5F5F5),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PatientDetailCard(
                name: inpatient.name,
                sex: inpatient.gender,
                age: '${inpatient.age}',
                phoneNumber: inpatient.phoneNumber,
              ),
              const SizedBox(
                height: 10,
              ),
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
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 8.0), // Adjust the padding
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://drive.google.com/uc?export=download&id=1kjZxZkd4TXjC-95KUNItuG_cSe5Vpnkb',
                            width: 140,
                            height: 200,
                          ),
                          const Text(
                              textAlign: TextAlign.center,
                              'Summary not available yet. Please add a summary to get started'),
                              SizedBox(height: 24,),
                          RoundFormButton(
                              text: 'Add', icon: Icons.add, onPressed: () {})
                        ],
                      ),
                    ),
                     Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://drive.google.com/uc?export=download&id=1kjZxZkd4TXjC-95KUNItuG_cSe5Vpnkb',
                            width: 140,
                            height: 200,
                          ),
                          const Text(
                              textAlign: TextAlign.center,
                              'Investigation not available yet. Please add investigation to get started'),
                              SizedBox(height: 24,),
                          RoundFormButton(
                              text: 'Add', icon: Icons.add, onPressed: () {})
                        ],
                      ),
                    ),
                     Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            'https://drive.google.com/uc?export=download&id=1kjZxZkd4TXjC-95KUNItuG_cSe5Vpnkb',
                            width: 140,
                            height: 200,
                          ),
                          const Text(
                              textAlign: TextAlign.center,
                              'Management not available yet. Please add management to get started'),
                              SizedBox(height: 24,),
                          RoundFormButton(
                              text: 'Add', icon: Icons.add, onPressed: () {})
                        ],
                      ),
                    ),
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
                const SizedBox(
                  height: 4,
                ),
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
  return Column(
    children: [Image.asset('assets/images/no_data.png'), Text('build data')],
  );
}

class RoundFormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  RoundFormButton(
      {super.key, required this.text, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(225, 45),
              backgroundColor: const Color(0xFF3579F8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 8.0), // Space between text and icon
                Icon(
                  icon,
                  color: Colors.white, // Predefined icon color
                  size: 28, // Predefined icon size
                ),
              ],
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(225, 45),
              backgroundColor:
                  const Color(0xFF3579F8), // Button expands to full width
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Border radius of 32
              ),
              elevation: 0, // Set button color to blue
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
  }
}
