// lib/screens/join_uda_form_screen.dart
import 'package:flutter/material.dart';

class JoinUDAFormScreen extends StatefulWidget {
  const JoinUDAFormScreen({super.key});

  @override
  State<JoinUDAFormScreen> createState() => _JoinUDAFormScreenState();
}

class _JoinUDAFormScreenState extends State<JoinUDAFormScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Text editing controllers
  final _surnameController = TextEditingController();
  final _otherNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ninController = TextEditingController();
  final _districtController = TextEditingController();
  final _villageController = TextEditingController();
  final _subCountyController = TextEditingController();
  final _parishController = TextEditingController();
  final _fromController = TextEditingController();
  final _toController = TextEditingController();
  
  // Dropdown values
  String? _selectedGender;
  String? _selectedParty;
  String? _previousParty;
  
  // Checkbox states
  bool _wasInUDA = false;
  bool _wasInOtherParty = false;
  
  // Party options
  final List<String> _partyOptions = [
    'Select Political Party',
    'ODM',
    'Wiper',
    'ANC',
    'KANU',
    'Ford Kenya',
    'Other',
  ];

  final List<String> _genderOptions = [
    'Select Gender',
    'Male',
    'Female',
    'Other',
  ];

  @override
  void dispose() {
    _surnameController.dispose();
    _otherNameController.dispose();
    _phoneController.dispose();
    _ninController.dispose();
    _districtController.dispose();
    _villageController.dispose();
    _subCountyController.dispose();
    _parishController.dispose();
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'JOIN UDA',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Submit Button in AppBar
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                _submitForm(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A5C2A),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'SUBMIT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A5C2A), Color(0xFF2E7D32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      'Welcome to UDA Registry',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please fill in your personal details below to continue',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Personal Details Section
              _buildSectionHeader('Personal Details'),
              const SizedBox(height: 16),

              // Surname
              _buildTextField(
                controller: _surnameController,
                label: 'Surname',
                icon: Icons.person,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your surname';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Other Name
              _buildTextField(
                controller: _otherNameController,
                label: 'Other Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your other name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Phone Number
              _buildTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // National ID (NIN)
              _buildTextField(
                controller: _ninController,
                label: 'National ID (NIN)',
                icon: Icons.credit_card,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your National ID';
                  }
                  if (value.length < 8) {
                    return 'Please enter a valid National ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Gender Dropdown
              _buildDropdown(
                value: _selectedGender,
                items: _genderOptions,
                label: 'Gender',
                icon: Icons.person,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value == 'Select Gender') {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Location Section
              _buildSectionHeader('Location Details'),
              const SizedBox(height: 16),

              // District
              _buildTextField(
                controller: _districtController,
                label: 'District',
                icon: Icons.location_city,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your district';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Village
              _buildTextField(
                controller: _villageController,
                label: 'Village',
                icon: Icons.location_on,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your village';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Sub County
              _buildTextField(
                controller: _subCountyController,
                label: 'Sub County',
                icon: Icons.map,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your sub county';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Parish
              _buildTextField(
                controller: _parishController,
                label: 'Parish',
                icon: Icons.place,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your parish';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Previous Party Membership Section
              _buildSectionHeader('Previous Party Membership'),
              const SizedBox(height: 16),

              // Have you ever been in UDA Party before?
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _wasInUDA,
                          onChanged: (value) {
                            setState(() {
                              _wasInUDA = value ?? false;
                              if (!_wasInUDA) {
                                _fromController.clear();
                                _toController.clear();
                              }
                            });
                          },
                          activeColor: const Color(0xFF1A5C2A),
                        ),
                        const Expanded(
                          child: Text(
                            'Have you ever been in UDA Party before?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_wasInUDA) ...[
                      const SizedBox(height: 12),
                      const Text(
                        'If YES, specify the Time period below:',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSmallTextField(
                              controller: _fromController,
                              label: 'From',
                              hint: 'YYYY-MM-DD',
                              icon: Icons.calendar_today,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSmallTextField(
                              controller: _toController,
                              label: 'To',
                              hint: 'YYYY-MM-DD',
                              icon: Icons.calendar_today,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Have you ever been in Any other Party before?
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _wasInOtherParty,
                          onChanged: (value) {
                            setState(() {
                              _wasInOtherParty = value ?? false;
                              if (!_wasInOtherParty) {
                                _selectedParty = null;
                              }
                            });
                          },
                          activeColor: const Color(0xFF1A5C2A),
                        ),
                        const Expanded(
                          child: Text(
                            'Have you ever been in Any other Party before?',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_wasInOtherParty) ...[
                      const SizedBox(height: 12),
                      const Text(
                        'If YES, specify the party below:',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: _selectedParty,
                        items: _partyOptions,
                        label: 'Select Political Party',
                        icon: Icons.party_mode,
                        onChanged: (value) {
                          setState(() {
                            _selectedParty = value;
                          });
                        },
                        validator: (value) {
                          if (_wasInOtherParty && (value == null || value == 'Select Political Party')) {
                            return 'Please select a political party';
                          }
                          return null;
                        },
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _submitForm(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCC00),
                    foregroundColor: const Color(0xFF1A5C2A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: const Text(
                    'SUBMIT APPLICATION',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for section headers
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          color: const Color(0xFFFFCC00),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A5C2A),
          ),
        ),
      ],
    );
  }

  // Helper method for text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1A5C2A)),
          prefixIcon: Icon(icon, color: const Color(0xFF1A5C2A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1A5C2A), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Helper method for small text fields (From/To)
  Widget _buildSmallTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          labelStyle: const TextStyle(color: Color(0xFF1A5C2A), fontSize: 12),
          prefixIcon: Icon(icon, color: const Color(0xFF1A5C2A), size: 18),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }

  // Helper method for dropdowns
  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1A5C2A)),
          prefixIcon: Icon(icon, color: const Color(0xFF1A5C2A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF1A5C2A), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Submit form
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Form is valid, show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Row(
            children: const [
              Icon(Icons.check_circle, color: Color(0xFF1A5C2A), size: 32),
              SizedBox(width: 12),
              Text(
                'Success!',
                style: TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Text(
            'Your UDA membership application has been submitted successfully. You will receive a confirmation message shortly.',
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCC00),
                foregroundColor: const Color(0xFF1A5C2A),
              ),
              child: const Text(
                'DONE',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
      
      // Print form data for debugging
      print('=== UDA Membership Application ===');
      print('Surname: ${_surnameController.text}');
      print('Other Name: ${_otherNameController.text}');
      print('Phone: ${_phoneController.text}');
      print('NIN: ${_ninController.text}');
      print('Gender: $_selectedGender');
      print('District: ${_districtController.text}');
      print('Village: ${_villageController.text}');
      print('Sub County: ${_subCountyController.text}');
      print('Parish: ${_parishController.text}');
      print('Was in UDA: $_wasInUDA');
      if (_wasInUDA) {
        print('From: ${_fromController.text}');
        print('To: ${_toController.text}');
      }
      print('Was in Other Party: $_wasInOtherParty');
      if (_wasInOtherParty) {
        print('Previous Party: $_selectedParty');
      }
      print('=== End ===');
    } else {
      // Form is invalid, show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
