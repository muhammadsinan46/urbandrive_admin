

import 'package:flutter/material.dart';

class BookingDetailsTile extends StatelessWidget {
  const BookingDetailsTile({
    super.key,
    required this.bookingData,
    required this.title,
  });

  final String bookingData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 1000,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 244, 250, 255)), borderRadius: BorderRadius.circular(10)),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: title),
            TextSpan(text: bookingData),
          ],
        ),
      ),
    );
  }
}
