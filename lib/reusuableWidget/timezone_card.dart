import 'package:flutter/material.dart';
import 'package:flutter_time_zone_clock/colors.dart';
import 'package:intl/intl.dart';
import 'package:timezone/standalone.dart' as tz;

class TimeZoneCard extends StatelessWidget {
  const TimeZoneCard({
    Key? key,
    required this.width,
    required this.cardkey,
    this.textcolor,
    this.containercolor,
  }) : super(key: key);

  final double width;
  final String cardkey;
  final Color? textcolor;
  final Color? containercolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: width * 0.5,
              child: RichText(
                text: TextSpan(
                    text: cardkey + '\n',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: textcolor ?? Appcolor.klocationtimecolor),
                    children: [
                      TextSpan(
                        text: DateFormat('EEEE, d MMM, yyyy')
                            .format(tz.TZDateTime.now(tz.getLocation(cardkey))),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ]),
              ),
            ),
            Text(
              DateFormat.jm()
                  .format(tz.TZDateTime.now(tz.getLocation(cardkey))),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textcolor ?? Appcolor.klocationtimecolor,
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: containercolor ?? Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
