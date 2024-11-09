import 'package:flutter/material.dart';

void main() {
  runApp(AirlineTicketApp());
}

class AirlineTicketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlightBookingHome(),
    );
  }
}

// Halaman Utama untuk Input Penerbangan
class FlightBookingHome extends StatelessWidget {
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airline Ticket Booking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Search Flights',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: fromController,
              decoration: InputDecoration(
                labelText: 'From',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: toController,
              decoration: InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlightSelectionPage(
                      from: fromController.text,
                      to: toController.text,
                    ),
                  ),
                );
              },
              child: Text('Search Flights'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Pemilihan Penerbangan
class FlightSelectionPage extends StatelessWidget {
  final String from;
  final String to;
  final List<String> flights = [
    "Flight 1 - 08:00 AM",
    "Flight 2 - 10:00 AM",
    "Flight 3 - 01:00 PM",
    "Flight 4 - 03:00 PM",
  ];

  final List<String> prices = [
    "\$200",
    "\$250",
    "\$220",
    "\$230",
  ];

  FlightSelectionPage({required this.from, required this.to});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Flight'),
      ),
      body: ListView.builder(
        itemCount: flights.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${flights[index]} - ${prices[index]}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingDetailsPage(
                    flight: flights[index],
                    price: prices[index],
                    from: from,
                    to: to,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Halaman Detail Pemesanan
class BookingDetailsPage extends StatelessWidget {
  final String flight;
  final String price;
  final String from;
  final String to;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passportController = TextEditingController();

  BookingDetailsPage({
    required this.flight,
    required this.price,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Flight: $flight',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Price: $price',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'From: $from',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'To: $to',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passportController,
              decoration: InputDecoration(
                labelText: 'Passport Number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(
                      flight: flight,
                      price: price,
                      from: from,
                      to: to,
                      name: nameController.text,
                      passport: passportController.text,
                    ),
                  ),
                );
              },
              child: Text('Confirm Booking'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Konfirmasi Pemesanan
class ConfirmationPage extends StatelessWidget {
  final String flight;
  final String price;
  final String from;
  final String to;
  final String name;
  final String passport;

  ConfirmationPage({
    required this.flight,
    required this.price,
    required this.from,
    required this.to,
    required this.name,
    required this.passport,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Thank you for your booking!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text('Flight: $flight', style: TextStyle(fontSize: 18)),
            Text('Price: $price', style: TextStyle(fontSize: 18)),
            Text('From: $from', style: TextStyle(fontSize: 18)),
            Text('To: $to', style: TextStyle(fontSize: 18)),
            Text('Name: $name', style: TextStyle(fontSize: 18)),
            Text('Passport Number: $passport', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
