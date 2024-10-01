import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterFormState createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _yearLevelController = TextEditingController();
  final TextEditingController _coursesController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();

  String? _qrData;
  Uint8List? _qrImage;
  String _role = 'Student';
  bool _obscurePassword = true; // Track password visibility

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Sign Up', style: TextStyle(color: Colors.white)), // Set the text color to white
      backgroundColor: Colors.black, // Set the AppBar background color to black
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white), // Set the icon color to white
        onPressed: () {
          Navigator.pop(context); // Navigate back
        },
      ),
    ),
    backgroundColor: Colors.blueGrey, // Set blue-grey background for the entire page
    body: Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 400, // Set maximum width to 400
          maxHeight: 600, // Set maximum height to 600 or any value that fits your form
        ),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildRoleDropdown(),
              const SizedBox(height: 20),
              _buildTextField('Full Name', _fullNameController),
              const SizedBox(height: 10),
              _buildTextField('Email', _emailController, TextInputType.emailAddress),
              const SizedBox(height: 10),
              _buildPasswordField(),
              const SizedBox(height: 10),
              ..._buildRoleSpecificFields(),
              const SizedBox(height: 20),
              if (_role == 'Student') ...[
                _generateQRCodeButton(),
                const SizedBox(height: 10),
                if (_qrImage != null) ...[
                  _buildQRCodeDisplay(),
                  const SizedBox(height: 10),
                  _savePDFButton(),
                ],
              ],
              const SizedBox(height: 20),
              _registerButton(),
            ],
          ),
        ),
      ),
    ),
  );
}


  Widget _buildRoleDropdown() {
    return DropdownButton<String>(
      value: _role,
      onChanged: (String? newValue) {
        setState(() {
          _role = newValue!;
          _resetFields();
        });
      },
      items: <String>['Student', 'Parent']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  List<Widget> _buildRoleSpecificFields() {
    if (_role == 'Student') {
      return [
        _buildTextField('Student ID', _studentIdController),
        const SizedBox(height: 10),
        _buildTextField('Year Level', _yearLevelController),
        const SizedBox(height: 10),
        _buildTextField('Courses', _coursesController),
      ];
    } else if (_role == 'Parent') {
      return [
        _buildTextField('Contact Number', _contactNumberController, TextInputType.phone),
      ];
    }
    return [];
  }

  void _resetFields() {
    _studentIdController.clear();
    _yearLevelController.clear();
    _coursesController.clear();
    _contactNumberController.clear();
  }

  Widget _buildTextField(String labelText, TextEditingController controller, [TextInputType keyboardType = TextInputType.text]) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        labelStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword; // Toggle password visibility
            });
          },
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }

Widget _registerButton() {
  return SizedBox(
    width: 80, // Set the width to 80
    height: 40,
    child: ElevatedButton(
      onPressed: () {
        // Handle registration logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Button color
        padding: const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding for size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
      child: const Text(
        'Sign up',
        style: TextStyle(
          fontSize: 16, // Button text size
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color
        ),
      ),
    ),
  );
}

Widget _generateQRCodeButton() {
  return SizedBox(
    width: 80, // Set the width to 80
    height: 40,
    child: ElevatedButton(
      onPressed: _generateQRCode,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue, // Button color
        padding: const EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding for size
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
      child: const Text(
        'Generate QR Code',
        style: TextStyle(
          color: Colors.white, // Set text color to white
        ),
      ),
    ),
  );
}

Widget _savePDFButton() {
  return SizedBox(
    width: 80, // Set the width to 80
    height: 40,
    child: ElevatedButton(
      onPressed: _qrImage != null ? saveQRCodeToPDF : () => _showMessage('Please generate the QR code first.'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 10), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Save QR Code to PDF',
        style: TextStyle(
          color: Colors.white, // Set text color to white
        ),
      ),
    ),
  );
}

  Widget _buildQRCodeDisplay() {
    return Column(
      children: [
        const Text('Generated QR Code:', style: TextStyle(fontSize: 20, color: Colors.blue)),
        QrImageView(
          data: _qrData ?? '',
          version: QrVersions.auto,
          size: 100.0,
          gapless: false,
        ),
      ],
    );
  }

  Widget registerButton() {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          if (_validateFields()) {
            _generateQRCode();
          } else {
            _showMessage('Please fill in all required fields.');
          }
        },
        child: const Text('Sign up'),
      ),
    );
  }

  Future<void> _generateQRCode() async {
    if (_fullNameController.text.isEmpty || _emailController.text.isEmpty) {
      _showMessage('Please fill in all required fields.');
      return;
    }

    final data = 'User: $_role\nName: ${_fullNameController.text}\nEmail: ${_emailController.text}';
    final generatedImage = await _generateQrImage(data);

    if (generatedImage != null) {
      setState(() {
        _qrData = data;
        _qrImage = generatedImage;
      });
    } else {
      _showMessage('Failed to generate QR code.');
    }
  }

  Future<Uint8List?> _generateQrImage(String data) async {
    try {
      const size = 150.0;
      final qrPainter = QrPainter(
        data: data,
        version: QrVersions.auto,
        // ignore: deprecated_member_use
        color: Colors.black,
        gapless: true,
      );
      final picRecorder = ui.PictureRecorder();
      final canvas = Canvas(picRecorder, const Rect.fromLTWH(0, 0, size, size));
      qrPainter.paint(canvas, const Size(size, size));
      final img = await picRecorder.endRecording().toImage(size.toInt(), size.toInt());
      final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    } catch (e) {
      _showMessage('Error generating QR image: $e');
      return null;
    }
  }

  Future<void> saveQRCodeToPDF() async {
    try {
      if (_qrImage == null) {
        _showMessage('QR image is null. Please generate it first.');
        return;
      }

      final pdf = pw.Document();
      final image = pw.MemoryImage(_qrImage!);
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('Name: ${_fullNameController.text}', style: const pw.TextStyle(fontSize: 12)),
                  pw.SizedBox(height: 20),
                  pw.Image(image, width: 100, height: 100),
                ],
              ),
            );
          },
        ),
      );

      String filename = '${_fullNameController.text.replaceAll(' ', '_')}.pdf';
      await Printing.sharePdf(bytes: await pdf.save(), filename: filename);
    } catch (e) {
      _showMessage('Error saving PDF: $e');
    }
  }

  bool _validateFields() {
    if (_fullNameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return false;
    }
    if (_role == 'Student' && (_studentIdController.text.isEmpty || _yearLevelController.text.isEmpty || _coursesController.text.isEmpty)) {
      return false;
    }
    if (_role == 'Parent' && _contactNumberController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
  