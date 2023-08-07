import 'package:flutter/material.dart';

void main() {
  runApp(TipCalculatorApp());
}

class TipCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: TipCalculatorScreen(),
    );
  }
}

class TipCalculatorScreen extends StatefulWidget {
  @override
  _TipCalculatorScreenState createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _totalBillController = TextEditingController();
  final TextEditingController _tipPercentageController = TextEditingController();
  final TextEditingController _numberOfPeopleController = TextEditingController();

  double _totalBill = 0.0;
  double _tipPercentage = 0.0;
  int _numberOfPeople = 1;

  void _calculateTipAndAmountPerPerson() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _totalBill = double.parse(_totalBillController.text);
        _tipPercentage = double.parse(_tipPercentageController.text);
        _numberOfPeople = int.parse(_numberOfPeopleController.text);
      });
    }
  }

  void _clearInputs() {
    setState(() {
      _totalBillController.text = '';
      _tipPercentageController.text = '';
      _numberOfPeopleController.text = '';
      _totalBill = 0.0;
      _tipPercentage = 0.0;
      _numberOfPeople = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    double tipAmount = (_totalBill * _tipPercentage) / 100;
    double totalAmount = _totalBill + tipAmount;
    double amountPerPerson = totalAmount / _numberOfPeople;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Tip Calculator', style: TextStyle(color: Colors.black))),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Total Bill',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      '\$${_totalBill.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Person',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Center(
                            child: Text(
                              '$_numberOfPeople',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Tip Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Center(
                            child: Text(
                              '\$${tipAmount.toStringAsFixed(2)}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount per person',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${amountPerPerson.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 160), //spacing between top and bottom sections
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextFormField(
                      controller: _totalBillController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Total Bill',
                        hintText: 'Please enter total bill',
                        suffixIcon: Icon(Icons.attach_money),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter total bill';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          _totalBillController.text = "0.00";
                        }
                        setState(() {});
                      },
                      onSaved: (value) {
                        _totalBillController.text = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextFormField(
                      controller: _tipPercentageController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: 'Tip Percentage',
                        hintText: 'Please enter tip percentage',
                        suffixIcon: Icon(Icons.percent_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter tip percentage';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          _tipPercentageController.text = "0.00";
                        }
                        setState(() {});
                      },
                      onSaved: (value) {
                        _tipPercentageController.text = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextFormField(
                      controller: _numberOfPeopleController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Number of People',
                        hintText: 'Please enter number of people',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter number of people';
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          _numberOfPeopleController.text = "1";
                        }
                        setState(() {});
                      },
                      onSaved: (value) {
                        _numberOfPeopleController.text = value.toString();
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _formKey.currentState!.validate();
                              _calculateTipAndAmountPerPerson();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text("Calculate", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: GestureDetector(
                          onTap: _clearInputs,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: const Text("Clear", style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
