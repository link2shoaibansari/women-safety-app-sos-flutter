import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleMessage extends StatelessWidget {
  final String? message;
  final bool? isMe;
  final String? image;
  final String? type;
  final String? friendName;
  final String? myName;
  final DateTime? date;

  SingleMessage({
    Key? key,
    this.message,
    this.isMe,
    this.image,
    this.type,
    this.friendName,
    this.myName,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Use dummy time for UI
    String cdate = "12:00";
    if (date != null) {
      cdate = "${date!.hour}:${date!.minute.toString().padLeft(2, '0')}";
    }
    if (type == "text") {
      return Container(
        constraints: BoxConstraints(
          maxWidth: size.width / 2,
        ),
        alignment: isMe == true ? Alignment.centerRight : Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
              color: isMe == true ? Colors.pink : Colors.black,
              borderRadius: isMe == true
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
            ),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: size.width / 2,
            ),
            alignment:
                isMe == true ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      isMe == true
                          ? (myName ?? "Me")
                          : (friendName ?? "Friend"),
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    )),
                Divider(),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      message ?? "",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    )),
                Divider(),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$cdate",
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    )),
              ],
            )),
      );
    } else if (type == 'img') {
      return Container(
        height: size.height / 2.5,
        width: size.width,
        alignment: isMe == true ? Alignment.centerRight : Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Container(
            height: size.height / 2.5,
            width: size.width,
            decoration: BoxDecoration(
              color: isMe == true ? Colors.pink : Colors.black,
              borderRadius: isMe == true
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
            ),
            constraints: BoxConstraints(
              maxWidth: size.width / 2,
            ),
            alignment:
                isMe == true ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      isMe == true
                          ? (myName ?? "Me")
                          : (friendName ?? "Friend"),
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    )),
                Divider(),
                CachedNetworkImage(
                  imageUrl: message ?? '',
                  fit: BoxFit.cover,
                  height: size.height / 3.62,
                  width: size.width,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Divider(),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$cdate",
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    )),
              ],
            )),
      );
    } else if (type == 'link') {
      return Container(
        constraints: BoxConstraints(
          maxWidth: size.width / 2,
        ),
        alignment: isMe == true ? Alignment.centerRight : Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        child: Container(
            decoration: BoxDecoration(
              color: isMe == true ? Colors.pink : Colors.black,
              borderRadius: isMe == true
                  ? BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
            ),
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: size.width / 2,
            ),
            alignment:
                isMe == true ? Alignment.centerRight : Alignment.centerLeft,
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      isMe == true
                          ? (myName ?? "Me")
                          : (friendName ?? "Friend"),
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    )),
                Divider(),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () async {
                        if (message != null && message!.isNotEmpty) {
                          await launchUrl(Uri.parse(message!));
                        }
                      },
                      child: Text(
                        message ?? '',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    )),
                Divider(),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "$cdate",
                      style: TextStyle(fontSize: 15, color: Colors.white70),
                    )),
              ],
            )),
      );
    }
    // Default fallback
    return SizedBox.shrink();
  }
}
