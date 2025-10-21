import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int members = 2;
  int hour = 2;
  int minute = 30;
  bool isAM = true;
  DateTime? selectedDate;

  void _selectDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF625D9F),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Book a Table",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Number of members
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Number of members",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIconButton(Icons.remove, () {
                        if (members > 1) setState(() => members--);
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "$members",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      _buildIconButton(Icons.add, () {
                        setState(() => members++);
                      }),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Time selector
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Time",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIconButton(Icons.remove, () {
                        setState(() {
                          hour = (hour == 1) ? 12 : hour - 1;
                        });
                      }),
                      Text("$hour", style: const TextStyle(fontSize: 20)),
                      const Text(" : ", style: TextStyle(fontSize: 20)),
                      _buildIconButton(Icons.remove, () {
                        setState(() {
                          minute = (minute == 0) ? 59 : minute - 1;
                        });
                      }),
                      Text(
                        minute.toString().padLeft(2, '0'),
                        style: const TextStyle(fontSize: 20),
                      ),
                      _buildIconButton(Icons.add, () {
                        setState(() {
                          minute = (minute == 59) ? 0 : minute + 1;
                        });
                      }),
                      const SizedBox(width: 10),
                      ChoiceChip(
                        label: const Text("am"),
                        selected: isAM,
                        onSelected: (_) => setState(() => isAM = true),
                      ),
                      const SizedBox(width: 6),
                      ChoiceChip(
                        label: const Text("pm"),
                        selected: !isAM,
                        onSelected: (_) => setState(() => isAM = false),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Date picker
            InkWell(
              onTap: _selectDate,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Text(
                  selectedDate == null
                      ? "Date"
                      : "Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Confirm booking
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  final snackBar = SnackBar(
                    content: Text(
                      "Booking confirmed for $members member(s) on ${selectedDate != null ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}" : "selected date"} at $hour:${minute.toString().padLeft(2, '0')} ${isAM ? "AM" : "PM"}",
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF625D9F)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  "Confirm booking",
                  style: GoogleFonts.poppins(
                      color: const Color(0xFF625D9F),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}