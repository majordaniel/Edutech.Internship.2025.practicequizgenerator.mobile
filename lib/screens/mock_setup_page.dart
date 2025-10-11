import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart';
import 'package:quiz_generator/helper/helper.dart';
import 'package:quiz_generator/widgets/custom_button.dart';
import 'package:quiz_generator/widgets/custom_text.dart';

class MockSetupPage extends StatefulWidget {
  const MockSetupPage({super.key});

  @override
  State<MockSetupPage> createState() => _MockSetupPageState();
}

class _MockSetupPageState extends State<MockSetupPage> {
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Back Arrow Button
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primaryDeepBlack,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                        ); // Go back to the previous screen
                      },
                    ),
                    const SizedBox(width: 5),

                    const Spacer(),
                    Icon(
                      Icons.notifications_none,
                      color: AppColors.primaryBlack,
                      size: 24.0,
                    ),
                  ],
                ),
                CustomText(
                  title: "Set up Mock Exam",
                  size: 20,
                  color: AppColors.primaryDeepBlack,
                  fontWeight: FontWeight.w700,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CustomButton(
                      buttonTitle: "Program",
                      textColor: AppColors.primaryWhite,
                      textWeight: FontWeight.w500,
                      textSize: 12.6,
                      buttonHeight: 21.3,
                      buttonWidth: 73.9,
                      borderRadius: 12.06,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                      'Success!',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'Your mock exam setup was successful.',
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(width: 8),
                    CustomText(
                      title: "Computer Science",
                      size: 14,
                      color: AppColors.primaryLightBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                CustomText(
                  title: "Select Course",
                  size: 14,
                  color: AppColors.primaryDeepBlack,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10),

                // Container(
                //   padding: EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     border: Border.all(color: AppColors.primaryGrey),
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text(
                //         "Choose a course from your program",
                //         style: TextStyle(
                //           fontFamily: 'PlusJakartaSans',
                //           fontSize: 12,
                //           color: AppColors.primaryGrey,
                //           fontWeight: FontWeight.w400,
                //         ),
                //       ),
                //       Icon(
                //         Icons.keyboard_arrow_down,
                //         color: AppColors.primaryLightBlack,
                //       ),
                //     ],
                //   ),
                // ),
                DropdownButtonFormField(
                  dropdownColor: AppColors.primaryWhite,
                  value: selectedValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: items
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: CustomText(
                            title: method,
                            size: 16,
                            color: AppColors.primaryDeepBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'select',
                    hintStyle: Helper.hintStyle,
                    border: Helper.decoration,
                    focusedBorder: Helper.decoration,
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
