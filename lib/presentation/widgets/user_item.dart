import 'package:flutter/material.dart';
import 'package:mobile_user_accurate/common/constants.dart';
import 'package:mobile_user_accurate/domain/entities/user.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: kSilverLight,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(user.name[0],
              style: kSubtitle.copyWith(
                  color: kWhite)), // Ambil huruf pertama dari nama
        ),
        title: Text(user.name, style: kHeading6.copyWith(color: kRichBlack)),
        horizontalTitleGap: 35.0,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_city),
                const SizedBox(width: 5),
                Text(
                  user.city,
                  style: kBodyText.copyWith(
                    color: kGrey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 5),
                Text(
                  user.email,
                  style: kBodyText.copyWith(
                    color: kGrey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 5),
                Text(
                  user.phoneNumber,
                  style: kBodyText.copyWith(
                    color: kGrey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.home),
                const SizedBox(width: 5),
                Text(
                  user.address,
                  style: kBodyText.copyWith(
                    color: kGrey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
