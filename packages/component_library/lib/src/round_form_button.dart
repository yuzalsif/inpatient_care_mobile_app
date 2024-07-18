import 'package:flutter/material.dart';

class RoundFormButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;

  const RoundFormButton(
      {super.key, required this.label, this.onPressed, this.icon});

  RoundFormButton.inProgress({
    required String label,
    Key? key,
  }) : this(
          label: label,
          icon: Transform.scale(
            scale: 0.5,
            child: const CircularProgressIndicator(),
          ),
          key: key,
        );

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
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(width: 8.0), // Space between text and icon
                icon!,
              ],
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(225, 45),
              backgroundColor: const Color(0xFF3579F8),
              // Button expands to full width
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Border radius of 32
              ),
              elevation: 0, // Set button color to blue
            ),
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          );
  }
}

// import 'package:flutter/material.dart';

// class RoundFormButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final IconData? icon;

//   RoundFormButton({required this.text, required this.onPressed, this.icon});

//   @override
//   Widget build(BuildContext context) {
//     return icon != null ? ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//        // minimumSize: const Size(0,58),
//        padding: const EdgeInsets.symmetric(horizontal: 32),
//         backgroundColor: const Color(0xFF3579F8),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         elevation: 0,
//         fixedSize: const Size.fromHeight(58), // Set a fixed height
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             text,
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 28,
//             ),
//           ),
//           const SizedBox(width: 8.0), // Space between text and icon
//           Icon(
//             icon!,
//             color: Colors.white, // Predefined icon color
//             size: 28, // Predefined icon size
//           ),
//         ],
//       ),
//     )
//     :ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 40),
//        // minimumSize: const Size(225, 58),
//         backgroundColor: const Color(0xFF3579F8), // Button expands to full width
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0), // Border radius of 32
//         ),
//         elevation: 0, // Set button color to blue
//         fixedSize: const Size.fromHeight(58), // Set a fixed height
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(color: Colors.white, fontSize: 28),
//       ),
//     );
//   }
// }
