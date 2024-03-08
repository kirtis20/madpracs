import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrencyList(),
    );
  }
}

class CurrencyList extends StatelessWidget {
  final List<String> currencies = ['USD', 'EUR', 'JPY', 'GBP', 'AUD'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency List'),
      ),
      body: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(currencies[index]),
            trailing: IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrencyDetails(currency: currencies[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CurrencyDetails extends StatefulWidget {
  final String currency;

  CurrencyDetails({required this.currency});

  @override
  _CurrencyDetailsState createState() => _CurrencyDetailsState();
}

class _CurrencyDetailsState extends State<CurrencyDetails> {
  late Future<double> futureRate;

  Future<double> fetchRate() async {
    final response = await http.get(Uri.parse('https://api.exchangerate-api.com/v4/latest/${widget.currency}'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['rates']['INR'];
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  @override
  void initState() {
    super.initState();
    futureRate = fetchRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.currency} Details'),
      ),
      body: Center(
        child: FutureBuilder<double>(
          future: futureRate,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('1 ${widget.currency} = ${snapshot.data} INR');
            }
          },
        ),
      ),
    );
  }
}
