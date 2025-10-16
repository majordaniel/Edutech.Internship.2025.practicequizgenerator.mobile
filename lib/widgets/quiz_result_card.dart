import 'package:flutter/material.dart';
import '../constant/color.dart';
import 'custom_text.dart';

class QuizResultCard extends StatefulWidget {
  final String quizTitle;
  final String subject;
  final String quizDetails;
  final double? progress;
  final String date;
  final Function(String) onSelectAction;

  const QuizResultCard({
    super.key,
    required this.quizTitle,
    required this.subject,
    required this.quizDetails,
    this.progress,
    required this.date,
    required this.onSelectAction,
  });

  @override
  State<QuizResultCard> createState() => _QuizResultCardState();
}

class _QuizResultCardState extends State<QuizResultCard>
    with SingleTickerProviderStateMixin {
  bool showMenu = false;
  String? selectedItem;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<String> menuItems = [
    "Analytics",
    "View Result",
    "Retake Quiz",
    "Share Result",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void toggleMenu() {
    setState(() {
      showMenu = !showMenu;
      if (showMenu) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void selectItem(String item) {
    setState(() {
      selectedItem = item;
      showMenu = false;
    });
    _controller.reverse();
    widget.onSelectAction(item);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double safeProgress =
        (widget.progress != null &&
            widget.progress! >= 0 &&
            widget.progress! <= 1)
        ? widget.progress!
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Card
        Card(
          elevation: 1.5,
          color: AppColors.primaryWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Title + Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        title: widget.quizTitle,
                        size: 14,
                        color: AppColors.primaryBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    CustomText(
                      title: widget.date,
                      size: 12,
                      color: AppColors.primaryLightBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Subject
                CustomText(
                  title: widget.subject,
                  size: 12,
                  color: AppColors.primaryLightBlack,
                  fontWeight: FontWeight.w400,
                ),
                const SizedBox(height: 8),

                // Quiz Details
                CustomText(
                  title: widget.quizDetails,
                  size: 12,
                  color: AppColors.primaryLightBlack,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 10),

                // Progress + Button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Progress bar
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: LinearProgressIndicator(
                              value: safeProgress,
                              minHeight: 6,
                              backgroundColor: Colors.grey.shade200,
                              color: AppColors.primaryGreen,
                            ),
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            title: "${(safeProgress * 100).toInt()}%",
                            size: 12,
                            color: AppColors.primaryLightBlack,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Dropdown toggle button
                    GestureDetector(
                      onTap: toggleMenu,
                      child: Container(
                        height: 32,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryOrange,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Text(
                              selectedItem ?? "View More",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              showMenu
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Animated Dropdown Section
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: showMenu
              ? FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 4, bottom: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: menuItems.length,
                        separatorBuilder: (_, __) => Divider(
                          height: 1,
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          final isSelected = item == selectedItem;
                          return InkWell(
                            onTap: () => selectItem(item),
                            child: Container(
                              color: isSelected
                                  ? AppColors.primaryOrange.withOpacity(0.05)
                                  : Colors.transparent,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: isSelected
                                      ? AppColors.primaryOrange
                                      : Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
