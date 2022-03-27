
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:motivational_quote_app/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentIndexNumber = 0;

  List<String> images = [
    "https://scontent.fsgn5-11.fna.fbcdn.net/v/t39.30808-6/276122836_2373362329470352_1721491722718376125_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=5cd70e&_nc_ohc=l0SMS_pjJMwAX_znOBE&tn=8uZp4phaOYk1RZ9z&_nc_ht=scontent.fsgn5-11.fna&oh=00_AT8mZDSSb23g24XQiWZP80U4vKYwC4i2Wi2PE3tRBN84KQ&oe=6243BF76",
    "https://scontent.fsgn5-8.fna.fbcdn.net/v/t1.6435-9/191712776_1132407380588345_3179710775824733340_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=825194&_nc_ohc=nvpnIFHTlI4AX-eSd0Y&_nc_ht=scontent.fsgn5-8.fna&oh=00_AT9pO022M9bhBBEebmkpk_4QF4H0sWoLCSUWNwr3FExEaA&oe=62643DD9",
    "https://images.unsplash.com/photo-1528716321680-815a8cdb8cbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=776&q=80",
    "https://images.unsplash.com/photo-1537444399873-da0fea0cf4b3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80",
  ];

  List<String> quotes = [
    "Do it for the people who want to see you fail.",
    "The way to get started is to quit talking and begin doing.",
    "The purpose of our lives is to be happy.",
    "You only live once, but if you do it right, once is enough."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 10),
          child: Column(children: [
            Swiper(
              outer: true,
              onIndexChanged: (value) {
                setState(() {
                  currentIndexNumber = value;
                });
              },
              curve: Curves.linear,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kImageBorder),
                    image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                );
              },
              itemCount: images.length,
              itemWidth: kImageWidth,
              itemHeight: kImageHeight,
              layout: SwiperLayout.STACK,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quote of the Day',
                    style: kTitleTextStyle,
                  ),
                  Text(
                    quotes[currentIndexNumber],
                    textAlign: TextAlign.center,
                    style: kSubTitleTextStyle,
                  ),
                  SizedBox(
                    height: 55,
                    width: 120,
                    child: TextButton(
                      style: kButtonStyle,
                      onPressed: () {},
                      child: const Text('Like 👍',style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ))
          ]),
        ),
      ),
    );
  }
}
