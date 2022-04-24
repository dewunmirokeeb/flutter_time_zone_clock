import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_zone_clock/colors.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({Key? key}) : super(key: key);

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topheight = height * 0.58;
    double bottomheight = height * 0.36;
    double maincontainerpadding = height * 0.06;

    return Scaffold(
      backgroundColor: Appcolor.kscaffoldbackgroundcolor,
      body: Container(
        margin: EdgeInsets.only(
            top: maincontainerpadding * 0.74,
            bottom: maincontainerpadding * 0.26,
            right: 10,
            left: 10),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Appcolor.kmainappoagebackgroundcolor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: width,
                height: topheight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'World Clock',
                      style: TextStyle(
                        color: Appcolor.kappbuttoncolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    AnalogClock(
                      width: width * 0.6,
                      height: height * 0.3,
                      showNumbers: true,
                      isLive: true,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Appcolor.kclockbordercolor,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: const TextSpan(
                          text: '10:30',
                          style: TextStyle(
                            fontSize: 40,
                            color: Appcolor.ktextcolor2,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: 'pm\n  Wed, July 3',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Appcolor.ktextcolor2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: width,
                height: bottomheight,
                child: Stack(
                  children: [
                    Positioned(
                      top: 24,
                      child: Container(
                        width: width * 0.95,
                        height: bottomheight - 20,
                        decoration: const BoxDecoration(
                          color: Appcolor.klocationtimecolor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, i) {
                              return Container(
                                height: 100,
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10, top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              );
                            }),
                      ),
                    ),
                    Positioned(
                      left: width * 0.4,
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Appcolor.kappbuttoncolor,
                        child: Icon(
                          Icons.add,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
