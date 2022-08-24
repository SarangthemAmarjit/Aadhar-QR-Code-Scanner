import 'package:qrcodescanner/imagepicker.dart';

import 'package:qrcodescanner/modal/xml_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:xml/xml.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BarcodeScannerApp(),
    );
  }
}

class BarcodeScannerApp extends StatefulWidget {
  const BarcodeScannerApp({Key? key}) : super(key: key);

  @override
  State<BarcodeScannerApp> createState() => _BarcodeScannerAppState();
}

class _BarcodeScannerAppState extends State<BarcodeScannerApp> {
  PrintLetterBarcodeData? AdhaarData;
  String fullname = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Barcode Scanner')),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      textAlign: TextAlign.center,
                      'WELCOME TO AADHAAR QR CODE SCANNER',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 223, 36, 105),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 200,
                    child: Image.asset('assets/images/scanner.jpg'),
                  ),
                  Container(
                    child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Form(
                          child: Column(
                            children: [
                              TextFormField(
                                  controller: TextEditingController(
                                      text: AdhaarData != null
                                          ? AdhaarData!.name
                                          : ''),
                                  decoration: const InputDecoration(
                                      label: Text("Name"), hintText: 'Name')),
                              TextFormField(
                                  controller: TextEditingController(
                                      text: AdhaarData != null
                                          ? AdhaarData!.uid
                                          : ''),
                                  decoration: const InputDecoration(
                                      label: Text("Aadhaar Number"),
                                      hintText: 'uid')),
                              TextFormField(
                                  controller: TextEditingController(
                                      text: AdhaarData != null
                                          ? AdhaarData!.gender
                                          : ''),
                                  decoration: InputDecoration(
                                      label: const Text("Gender"),
                                      hintText: AdhaarData != null
                                          ? AdhaarData!.gender
                                          : 'gender')),
                              TextFormField(
                                  controller: TextEditingController(
                                      text: AdhaarData != null
                                          ? AdhaarData!.dob
                                          : ''),
                                  decoration: InputDecoration(
                                      label: const Text("Date Of Birth"),
                                      hintText: AdhaarData != null
                                          ? AdhaarData!.dob
                                          : 'DOB')),
                              TextFormField(
                                  controller: TextEditingController(
                                      text: AdhaarData != null
                                          ? AdhaarData!.loc
                                          : ''),
                                  decoration: InputDecoration(
                                      label: const Text("Address"),
                                      hintText: AdhaarData != null
                                          ? AdhaarData!.loc
                                          : 'Address')),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                child: ElevatedButton(
                                    onPressed: () async {
                                      String barcodeScanRes;

                                      try {
                                        barcodeScanRes =
                                            await FlutterBarcodeScanner
                                                .scanBarcode(
                                                    '#ff6666',
                                                    'Cancel',
                                                    true,
                                                    ScanMode.QR);
                                      } on PlatformException {
                                        barcodeScanRes =
                                            'Failed to get platform version.';
                                      }
                                      if (!mounted) return;
                                      final document =
                                          XmlDocument.parse(barcodeScanRes);
                                      var data = document
                                          .getElement('PrintLetterBarcodeData');
                                      var uid = data!.getAttribute('uid');
                                      var name = data.getAttribute('name');
                                      var gender = data.getAttribute('gender');
                                      var yob = data.getAttribute('yob');
                                      var co = data.getAttribute('co');
                                      var loc = data.getAttribute('loc');
                                      var vtc = data.getAttribute('vtc');
                                      var po = data.getAttribute('po');
                                      var dist = data.getAttribute('dist');
                                      var subdist =
                                          data.getAttribute('subdist');
                                      var state = data.getAttribute('state');
                                      var pc = data.getAttribute('pc');
                                      var dob = data.getAttribute('dob');
                                      PrintLetterBarcodeData finaldata =
                                          PrintLetterBarcodeData(
                                              uid: uid,
                                              name: name,
                                              gender: gender,
                                              yob: yob,
                                              co: co,
                                              loc: loc,
                                              vtc: vtc,
                                              po: po,
                                              dist: dist,
                                              subdist: subdist,
                                              state: state,
                                              pc: pc,
                                              dob: dob);

                                      setState(() {
                                        AdhaarData = finaldata;
                                        fullname = name!;
                                      });
                                    },
                                    child: const Text('Start QR Scan')),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AadhaarImagePicker(
                        btn: 'Upload Front',
                        adharname: 'Front',
                        fullname: fullname,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      AadhaarImagePicker(
                        btn: 'Upload Back',
                        adharname: 'Back',
                        fullname: fullname,
                      ),
                    ],
                  ),
                ])));
  }
}
