import 'package:flutter/material.dart';
import 'api_service.dart'; // Ensure ApiService is imported
import 'register.dart'; // Import the RegisterPage

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true; // To toggle password visibility
  String? selectedRole; // Holds the selected role
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService apiService = ApiService(); // Initialize ApiService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
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
          constraints: const BoxConstraints(maxWidth: 400), // Set maximum width
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12), // Rounded corners
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, // Slightly darker shadow
                spreadRadius: 2,
                blurRadius: 6,
                offset: Offset(0, 3), // Shadow position
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Change to minimize height to fit content
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildRoleDropdown(), // Role Selection Dropdown
              const SizedBox(height: 20),
              _buildTextField('Email', _emailController), // Email TextField
              const SizedBox(height: 20),
              _buildPasswordField(), // Password TextField
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginUser, // Call login user method
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 50), // Button size
                  backgroundColor: Colors.blueAccent, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded button
                  ),
                ),
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()), // Navigate to Register Page
                  );
                },
                child: const Text(
                  'Sign up', // Changed to 'Register'
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Add functionality for "Forgot Password?"
                },
                child: const Text(
                  'Forgot Password?', // Forgot password text
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build role dropdown widget
  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedRole,
      hint: const Text('Select Role'), // Placeholder text
      items: <String>['Student', 'Parent', 'Teacher', 'Admin'] // Example roles
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectedRole = newValue; // Update the selected role
        });
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2), // Focused border color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1), // Default border color
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
      ),
    );
  }

  // Build text field widget
  Widget _buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0), // Add padding for better spacing
      child: SizedBox(
        width: double.infinity, // Ensures the TextField takes full width
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.grey), // Lighter label color
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2), // Focused border color
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1), // Default border color
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
          ),
          style: const TextStyle(fontSize: 16), // Input text size
        ),
      ),
    );
  }

  // Build password field widget
  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add padding for better spacing
      child: SizedBox(
        width: double.infinity, // Ensures the TextField takes full width
        child: TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: const TextStyle(color: Colors.grey), // Lighter label color
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2), // Focused border color
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 1), // Default border color
              borderRadius: BorderRadius.circular(8), // Rounded corners
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off, // Show or hide icon
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword; // Toggle password visibility
                });
              },
            ),
          ),
          style: const TextStyle(fontSize: 16), // Input text size
        ),
      ),
    );
  }

  // Login user method
  Future<void> _loginUser() async {
    if (_validateInput()) {
      try {
        await apiService.loginUser({
          'email': _emailController.text,
          'password': _passwordController.text,
          'role': selectedRole, // Include role in the login request
        });
        // Handle successful login (e.g., navigate to another page or show a success message)
      } catch (e) {
        _showErrorSnackbar("Login failed: $e"); // Display error message
      }
    }
  }

  // Validate input fields
  bool _validateInput() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty || selectedRole == null) {
      _showErrorSnackbar("Please fill in all fields."); // Notify user of incomplete fields
      return false;
    }
    return true; // Return true if input is valid
  }

  // Show error message using Snackbar
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)), // Show snackbar with error message
    );
  }
}
