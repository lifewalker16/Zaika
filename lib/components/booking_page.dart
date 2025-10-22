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

  // Temporary recent booking data
  Map<String, dynamic>? recentBooking;

  void _selectDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF625D9F),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Color(0xFF625D9F)),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _confirmBooking() {
    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a date first.")),
      );
      return;
    }

    final booking = {
      "members": members,
      "date":
          "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
      "time":
          "$hour:${minute.toString().padLeft(2, '0')} ${isAM ? "AM" : "PM"}",
      "status": "Pending",
    };

    setState(() {
      recentBooking = booking;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Booking confirmed for $members member(s) on ${booking['date']} at ${booking['time']}",
        ),
      ),
    );
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
            "Book Table",
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Number of members
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Number of members",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    const SizedBox(height: 12),
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
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Time",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 16)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildIconButton(Icons.remove, () {
                          setState(() {
                            hour = (hour == 1) ? 12 : hour - 1;
                          });
                        }),
                        Text("$hour",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        const Text(" : ", style: TextStyle(fontSize: 20)),
                        _buildIconButton(Icons.remove, () {
                          setState(() {
                            minute = (minute == 0) ? 59 : minute - 1;
                          });
                        }),
                        Text(
                          minute.toString().padLeft(2, '0'),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        _buildIconButton(Icons.add, () {
                          setState(() {
                            minute = (minute == 59) ? 0 : minute + 1;
                          });
                        }),
                        const SizedBox(width: 10),
                        ChoiceChip(
                          label: const Text("AM"),
                          selected: isAM,
                          selectedColor: Color(0xFF625D9F),
                          labelStyle: TextStyle(
                              color: isAM ? Colors.white : Colors.black87),
                          onSelected: (_) => setState(() => isAM = true),
                        ),
                        const SizedBox(width: 6),
                        ChoiceChip(
                          label: const Text("PM"),
                          selected: !isAM,
                          selectedColor: Color(0xFF625D9F),
                          labelStyle: TextStyle(
                              color: !isAM ? Colors.white : Colors.black87),
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
                child: _buildCard(
                  child: Text(
                    selectedDate == null
                        ? "Select Date"
                        : "Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedDate == null
                          ? Colors.black38
                          : Colors.black87,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Confirm booking button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _confirmBooking,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF625D9F)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    "Confirm Booking",
                    style: GoogleFonts.poppins(
                        color: const Color(0xFF625D9F),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Recent Booking Section
              recentBooking != null
                  ? _buildCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Recent Booking",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 18)),
                          const SizedBox(height: 12),
                          _buildBookingRow("Date:", recentBooking!['date']),
                          _buildBookingRow("Time:", recentBooking!['time']),
                          _buildBookingRow("Status:", recentBooking!['status'],
                              valueColor: Colors.orange[800]),
                        ],
                      ),
                    )
                  : _buildCard(
                      color: const Color(0xFFEBE6F6), // Light purple background
                      child: Text(
                        "No recent bookings yet.",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.black54),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF625D9F).withOpacity(0.2), // light purple
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: const Color(0xFF625D9F)),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildCard({required Widget child, Color? color}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFF625D9F).withOpacity(0.2), // light purple
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildBookingRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
          Text(value,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: valueColor ?? Colors.black87)),
        ],
      ),
    );
  }
}
