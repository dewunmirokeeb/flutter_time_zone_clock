import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_time_zone_clock/reusuableWidget/timezone_card.dart';
import 'package:flutter_time_zone_clock/colors.dart';
import 'package:flutter_time_zone_clock/time_manager.dart';
import 'package:provider/provider.dart' as selector;

class MainAppPage extends StatefulWidget {
  const MainAppPage({Key? key}) : super(key: key);

  @override
  State<MainAppPage> createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  @override
  void initState() {
    super.initState();
    context.read<TimeManager>().changetime();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topheight = height * 0.58;
    double bottomheight = height * 0.42;
    final ScrollController _controller = ScrollController();
    void _scrollup() {
      _controller.animateTo(
        _controller.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }

    return Scaffold(
      backgroundColor: Appcolor.kmainappoagebackgroundcolor,
      body: SafeArea(
        child: selector.Consumer<TimeManager>(
          builder: (context, value, child) {
            return Container(
              margin: EdgeInsets.only(
                top: height * 0.01,
              ),
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
                          Stack(
                            children: [
                              Positioned(
                                child: AnalogClock(
                                  width: width * 0.6,
                                  height: height * 0.3,
                                  digitalClockColor: Appcolor.kappbuttoncolor,
                                  textScaleFactor: 1.5,
                                  showDigitalClock: true,
                                  showAllNumbers: true,
                                  datetime: value.currentlocationtime,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Appcolor.kclockbordercolor,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: height * 0.21,
                                left: 0,
                                right: 0,
                                child: const Center(
                                  child: Text(
                                    'current location',
                                    style: TextStyle(
                                      color: Appcolor.kappbuttoncolor,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: value.time,
                                style: const TextStyle(
                                  fontSize: 40,
                                  color: Appcolor.ktextcolor2,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\n' + value.date + '  ',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Appcolor.ktextcolor2,
                                    ),
                                  ),
                                  TextSpan(
                                    text: value.getzone,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: Appcolor.kappbuttoncolor,
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
                              padding:
                                  const EdgeInsets.only(top: 30, bottom: 57),
                              width: width,
                              height: bottomheight,
                              decoration: BoxDecoration(
                                color: Appcolor.klocationtimecolor,
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  controller: _controller,
                                  itemCount: value.selectedlocation.length,
                                  itemBuilder: (context, i) {
                                    String cardkey = value.selectedlocation[i];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: value.selectedlocation.length == 1
                                          ? TimeZoneCard(
                                              width: width,
                                              cardkey: cardkey,
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                context
                                                    .read<TimeManager>()
                                                    .setnewzone(cardkey);
                                                context
                                                    .read<TimeManager>()
                                                    .removefromselectedlocation(
                                                        cardkey);
                                                context
                                                    .read<TimeManager>()
                                                    .addtoselectedlocation(
                                                        cardkey);
                                                _scrollup();
                                              },
                                              child: Slidable(
                                                endActionPane: ActionPane(
                                                  motion: const ScrollMotion(),
                                                  children: [
                                                    Column(
                                                      children: [
                                                        const Spacer(),
                                                        IconButton(
                                                          onPressed: () {
                                                            if (i == 0) {
                                                              context
                                                                  .read<
                                                                      TimeManager>()
                                                                  .setnewzone(
                                                                      value.selectedlocation[
                                                                          i + 1]);
                                                              context
                                                                  .read<
                                                                      TimeManager>()
                                                                  .removefromselectedlocation(
                                                                      cardkey);

                                                              _scrollup();
                                                            } else {
                                                              context
                                                                  .read<
                                                                      TimeManager>()
                                                                  .removefromselectedlocation(
                                                                      cardkey);

                                                              _scrollup();
                                                            }
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            size: 50,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        const Text(
                                                          '    Delete',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                child: TimeZoneCard(
                                                  containercolor: i == 0
                                                      ? Colors.white
                                                      : Appcolor
                                                          .klocationtimecolor,
                                                  textcolor: i == 0
                                                      ? Appcolor
                                                          .klocationtimecolor
                                                      : Colors.white,
                                                  width: width,
                                                  cardkey: cardkey,
                                                ),
                                              ),
                                            ),
                                    );
                                  }),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Appcolor.kappbuttoncolor,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                onPressed: () {
                                  alllocationcard(context, width, height);
                                  _scrollup();
                                },
                                child: const Icon(
                                  Icons.arrow_upward,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> alllocationcard(
    BuildContext context,
    double width,
    double height,
  ) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isDismissible: false,
      context: context,
      builder: (BuildContext bc) {
        return SizedBox(
          width: width,
          height: height * 0.7,
          child: Stack(
            children: [
              Positioned(
                top: height * 0.05,
                child: Container(
                  width: width,
                  height: height * 0.65,
                  decoration: const BoxDecoration(
                    color: Appcolor.klocationtimecolor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            right: 20,
                            left: 20,
                          ),
                          width: width * 0.9,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            onChanged: (search) {
                              context
                                  .read<TimeManager>()
                                  .updatesearchlocation(search);
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Enter city name',
                              // suffixIcon: GestureDetector(
                              //   onTap: () {
                              //     FocusManager.instance.primaryFocus?.unfocus();
                              //   },
                              //   child: Container(
                              //     margin:
                              //         const EdgeInsets.only(top: 5, bottom: 5),
                              //     width: 40,
                              //     height: 20,
                              //     decoration: BoxDecoration(
                              //       color: Appcolor.kappbuttoncolor,
                              //       borderRadius: BorderRadius.circular(10),
                              //     ),
                              //     child: const Center(
                              //         child: Text(
                              //       'Search',
                              //       style: TextStyle(
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 15),
                              //     )),
                              //   ),
                              // ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: selector.Consumer<TimeManager>(
                              builder: (context, value, child) {
                            return Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: value.searchresult.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: value.searchresult.length,
                                      itemBuilder: (context, i) {
                                        String key = value.searchresult[i];
                                        return RawMaterialButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                20,
                                              ),
                                            ),
                                            splashColor: Colors.purple,
                                            onPressed: () {
                                              value.setnewzone(key);
                                              context
                                                  .read<TimeManager>()
                                                  .updatesearchlocation('');
                                              if (value.selectedlocation
                                                  .contains(key)) {
                                                value
                                                    .removefromselectedlocation(
                                                        key);
                                                value
                                                    .addtoselectedlocation(key);
                                              } else {
                                                value
                                                    .addtoselectedlocation(key);
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: TimeZoneCard(
                                              cardkey: key,
                                              width: width,
                                            ));
                                      })
                                  : const Text(
                                      'No result found',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: height * 0.02,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Appcolor.kappbuttoncolor,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<TimeManager>().updatesearchlocation('');
                    },
                    child: const Icon(
                      Icons.arrow_downward,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
