import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String gender;
  final String profileImage;

  final Function(
      String firstName,
      String lastName,
      String phone,
      String email,
      String gender,
      String profileImage,
      ) onSave;

  const ProfileScreen({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.gender,
    required this.profileImage,
    required this.onSave,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const Color primaryColor = Color(0xFFE91E63);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

  late String selectedGender;
  late String selectedProfileImage;

  final List<String> genderList = [
    'Male',
    'Female',
    'Other',
  ];

  final List<String> profileImages = [
    'assets/profile/p1.jpg',
    'assets/profile/p2.jpg',
    'assets/profile/p3.jpg',
  ];

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(
      text: widget.firstName,
    );

    lastNameController = TextEditingController(
      text: widget.lastName,
    );

    phoneController = TextEditingController(
      text: widget.phone,
    );

    emailController = TextEditingController(
      text: widget.email,
    );

    selectedGender = widget.gender.isEmpty
        ? 'Male'
        : widget.gender;

    selectedProfileImage = widget.profileImage.isEmpty
        ? 'assets/profile/p1.jpg'
        : widget.profileImage;
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }

  void _showProfileImagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose Profile Photo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Select a dummy profile photo',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceEvenly,
                  children: profileImages.map((image) {
                    final bool selected =
                        selectedProfileImage == image;

                    return InkWell(
                      borderRadius:
                      BorderRadius.circular(50),
                      onTap: () {
                        setState(() {
                          selectedProfileImage = image;
                        });

                        Navigator.pop(sheetContext);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selected
                                ? primaryColor
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 38,
                          backgroundColor:
                          Colors.grey.shade200,
                          backgroundImage:
                          AssetImage(image),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding:
                          const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: primaryColor,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundColor:
                            Colors.grey.shade200,
                            backgroundImage: AssetImage(
                              selectedProfileImage,
                            ),
                          ),
                        ),

                        Positioned(
                          right: -2,
                          bottom: 2,
                          child: InkWell(
                            onTap:
                            _showProfileImagePicker,
                            borderRadius:
                            BorderRadius.circular(
                              30,
                            ),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration:
                              const BoxDecoration(
                                color: primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    TextButton.icon(
                      onPressed:
                      _showProfileImagePicker,
                      icon: const Icon(
                        Icons.photo_library_outlined,
                        size: 17,
                        color: primaryColor,
                      ),
                      label: const Text(
                        'Change Dummy Photo',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: firstNameController,
                textCapitalization:
                TextCapitalization.words,
                decoration: _inputDecoration(
                  label: 'First Name',
                  icon: Icons.person_outline,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter first name';
                  }

                  if (!RegExp(
                    r'^[a-zA-Z ]+$',
                  ).hasMatch(value.trim())) {
                    return 'First name should contain letters only';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: lastNameController,
                textCapitalization:
                TextCapitalization.words,
                decoration: _inputDecoration(
                  label: 'Last Name',
                  icon: Icons.person_outline,
                ),
                validator: (value) {
                  if (value != null &&
                      value.trim().isNotEmpty &&
                      !RegExp(
                        r'^[a-zA-Z ]+$',
                      ).hasMatch(value.trim())) {
                    return 'Last name should contain letters only';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: _inputDecoration(
                  label: 'Gender',
                  icon: Icons.wc_outlined,
                ),
                items: genderList.map((gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    selectedGender = value;
                  });
                },
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 10,
                decoration: _inputDecoration(
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                ).copyWith(
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter phone number';
                  }

                  if (!RegExp(
                    r'^[0-9]{10}$',
                  ).hasMatch(value.trim())) {
                    return 'Enter valid 10 digit phone number';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: emailController,
                keyboardType:
                TextInputType.emailAddress,
                decoration: _inputDecoration(
                  label: 'Email ID',
                  icon: Icons.email_outlined,
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter email address';
                  }

                  if (!isValidEmail(
                    value.trim(),
                  )) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (formKey.currentState
                        ?.validate() ??
                        false) {
                      widget.onSave(
                        firstNameController.text
                            .trim(),
                        lastNameController.text
                            .trim(),
                        phoneController.text.trim(),
                        emailController.text.trim(),
                        selectedGender,
                        selectedProfileImage,
                      );

                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Profile saved successfully',
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.save_outlined,
                  ),
                  label: const Text(
                    'Save Profile',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    primaryColor,
                    foregroundColor:
                    Colors.white,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(
        icon,
        color: primaryColor,
      ),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: primaryColor,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder:
      OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();

    super.dispose();
  }
}