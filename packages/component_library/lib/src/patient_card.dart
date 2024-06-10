import 'package:flutter/material.dart';


class PatientCard extends StatefulWidget {
  final String name;
  final String sex;
  final int age;
 final ValueChanged<bool> onSelected;

  PatientCard({
    required this.name,
    required this.sex,
    required this.age,
    required this.onSelected,
  });


  @override
  _PatientCardState createState() => _PatientCardState();
}
class _PatientCardState extends State<PatientCard> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
     onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelected(isSelected);  // Call the onSelected callback with the current state
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
       // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          
          color: isSelected ? Color(0xFF3579F8) : Colors.white,
          borderRadius: BorderRadius.circular(4),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 1,
          //     blurRadius: 5,
          //     offset: Offset(0, 3),
          //   ),
          // ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: Colors.grey[200],
              child: Icon(Icons.person, size: 60, color: Colors.grey),
            ),
            SizedBox(width: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 18,
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
    );
  }
}