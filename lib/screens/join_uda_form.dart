// lib/screens/join_uda_form_screen.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';
import '../theme/theme_ext.dart';

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

  // Checkbox states
  bool _wasInUDA = false;
  bool _wasInOtherParty = false;

  // Submission state
  bool _isSubmitting = false;

  // National ID Upload
  File? _nationalIdFrontImage;
  File? _nationalIdBackImage;
  bool _isIdUploaded = false;

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

  // Method to pick image from gallery or camera
  Future<void> _pickIdImage(bool isFront) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          if (isFront) {
            _nationalIdFrontImage = File(image.path);
          } else {
            _nationalIdBackImage = File(image.path);
          }
          _checkIfIdFullyUploaded();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Method to take photo with camera
  Future<void> _takeIdPhoto(bool isFront) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          if (isFront) {
            _nationalIdFrontImage = File(image.path);
          } else {
            _nationalIdBackImage = File(image.path);
          }
          _checkIfIdFullyUploaded();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Check if both sides of ID are uploaded
  void _checkIfIdFullyUploaded() {
    setState(() {
      _isIdUploaded =
          _nationalIdFrontImage != null && _nationalIdBackImage != null;
    });
  }

  // Show image picker options dialog
  void _showImagePickerDialog(bool isFront) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isFront ? 'Upload Front ID' : 'Upload Back ID'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: Color(0xFF1A5C2A),
              ),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickIdImage(isFront);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF1A5C2A)),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(context);
                _takeIdPhoto(isFront);
              },
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'JOIN UDA',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
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
              onTap: _isSubmitting ? null : _submitForm,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
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
                    Icon(Icons.check, color: Colors.white, size: 16),
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
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          16 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              // National ID Upload Section
              _buildSectionHeader('Upload National ID'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.hairline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Please upload both sides of your National ID',
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),

                    // Front ID Upload
                    _buildIdUploadCard(
                      title: 'Front Side',
                      imageFile: _nationalIdFrontImage,
                      onTap: () => _showImagePickerDialog(true),
                      isUploaded: _nationalIdFrontImage != null,
                    ),
                    const SizedBox(height: 12),

                    // Back ID Upload
                    _buildIdUploadCard(
                      title: 'Back Side',
                      imageFile: _nationalIdBackImage,
                      onTap: () => _showImagePickerDialog(false),
                      isUploaded: _nationalIdBackImage != null,
                    ),
                    const SizedBox(height: 8),

                    // Upload status indicator
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _isIdUploaded
                            ? Colors.green.shade50
                            : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _isIdUploaded
                              ? Colors.green.shade300
                              : Colors.orange.shade300,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _isIdUploaded ? Icons.check_circle : Icons.warning,
                            color: _isIdUploaded ? Colors.green : Colors.orange,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _isIdUploaded
                                  ? 'Both sides of your ID have been uploaded'
                                  : 'Please upload both sides of your National ID',
                              style: TextStyle(
                                fontSize: 12,
                                color: _isIdUploaded
                                    ? Colors.green.shade800
                                    : Colors.orange.shade800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
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
                  color: context.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.hairline),
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
                        style: TextStyle(fontSize: 13, color: Colors.grey),
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
                  color: context.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.hairline),
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
                        style: TextStyle(fontSize: 13, color: Colors.grey),
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
                          if (_wasInOtherParty &&
                              (value == null ||
                                  value == 'Select Political Party')) {
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
                  onPressed: _isSubmitting ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCC00),
                    foregroundColor: const Color(0xFF1A5C2A),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Color(0xFF1A5C2A),
                          ),
                        )
                      : const Text(
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

  // ID Upload Card Widget
  Widget _buildIdUploadCard({
    required String title,
    required File? imageFile,
    required VoidCallback onTap,
    required bool isUploaded,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.surfaceAlt,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isUploaded ? Colors.green.shade400 : context.hairline,
            width: isUploaded ? 2 : 1,
          ),
        ),
        child: imageFile != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.file(imageFile, fit: BoxFit.cover),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, color: Colors.white, size: 14),
                              SizedBox(width: 4),
                              Text(
                                'Uploaded',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file, color: context.textMuted, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      'Tap to upload $title',
                      style: TextStyle(color: context.textMuted, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'JPG, PNG or PDF',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                    ),
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
        Container(width: 4, height: 24, color: const Color(0xFFFFCC00)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A5C2A),
            ),
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
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
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
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: context.hairline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: context.hairline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
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
        color: context.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.hairline),
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
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
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
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
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Color(0xFF1A5C2A)),
          prefixIcon: Icon(icon, color: const Color(0xFF1A5C2A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: context.hairline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: context.hairline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1A5C2A), width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  // Submit form
  Future<void> _submitForm() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_isIdUploaded) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload both sides of your National ID'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await ApiService.instance.submitMembership(
        fields: {
          'surname': _surnameController.text.trim(),
          'other_name': _otherNameController.text.trim(),
          'phone': _phoneController.text.trim(),
          if (_ninController.text.trim().isNotEmpty)
            'national_id_number': _ninController.text.trim(),
          if (_selectedGender != null && _selectedGender != 'Select Gender')
            'gender': _selectedGender!,
          'district': _districtController.text.trim(),
          'village': _villageController.text.trim(),
          'sub_county': _subCountyController.text.trim(),
          'parish': _parishController.text.trim(),
          'was_in_uda': _wasInUDA ? '1' : '0',
          if (_wasInUDA) 'uda_from': _fromController.text.trim(),
          if (_wasInUDA) 'uda_to': _toController.text.trim(),
          'was_in_other_party': _wasInOtherParty ? '1' : '0',
          if (_wasInOtherParty &&
              _selectedParty != null &&
              _selectedParty != 'Select Political Party')
            'previous_party': _selectedParty!,
        },
        idFrontPath: _nationalIdFrontImage?.path,
        idBackPath: _nationalIdBackImage?.path,
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
      return;
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);

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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
  }
}
