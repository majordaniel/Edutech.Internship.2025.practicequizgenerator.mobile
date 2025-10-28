import 'package:flutter/material.dart';
import 'package:quiz_generator/constant/color.dart' show AppColors;
import 'package:quiz_generator/models/user.dart' show User;
import 'package:quiz_generator/widgets/custom_text.dart';

class GreetingCard extends StatelessWidget {
  final User user;
  final String prefix;

  const GreetingCard({
    super.key,
    required this.user,
    this.prefix = 'Welcome back',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$prefix, ',
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 14,
                color: AppColors.primaryOrange,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(width: 2.0),
            Text(
              user.name,
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 14,
                color: AppColors.primaryDeepBlack,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 2.0),
        CustomText(
          // TODO: confirm that this makes sense, because right now User.id is tied to the users
          // internal ID whatever that means. Maybe it's fine
          title: user.id,
          size: 10,
          color: AppColors.primaryLightBlack,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
