import 'package:flutter/material.dart';
import 'package:sitcom_joke/models/comment.dart';
import 'package:sitcom_joke/ui/widgets/user/user_profile_icon.dart';
import 'package:sitcom_joke/utils/date_formater.dart';

class JokeCommentCard extends StatelessWidget {
  final Comment comment;

  JokeCommentCard(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          UserProfileIcon(
            user: comment.owner,
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(comment.owner.username, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    Text(DateFormatter.dateToString(
                        comment.dateAdded, DateFormatPattern.timeAgo), style: TextStyle(color: Colors.grey[500]),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(comment.content, textAlign: TextAlign.justify,),
                ),
                Divider()
              ],
            ),
          )
        ],
      ),
    );
  }
}
