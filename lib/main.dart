import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:motivational_quote_app/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:motivational_quote_app/get_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDzb7PDPmw54KdsYhT15sVHiBqGVoNBjE0",
      projectId: 'motivational-quote-app',
      messagingSenderId: '377603465409',
      appId: '1:377603465409:android:1800504cc8c11e23373440', // Your apiKey
    ),
  );
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
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> images = [
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
        child: StreamBuilder(
          stream: firestore.collection('maindata').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return const Text('Loading...');

            return Container(
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
                          image: NetworkImage(
                              snapshot.data!.docs[index]["imageUrl"]),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
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
                        snapshot.data!.docs[currentIndexNumber]["quote"],
                        style: kSubTitleTextStyle,
                      ),
                      SizedBox(
                        height: 55,
                        width: 120,
                        child: TextButton(
                          style: kButtonStyle,
                          //TODO: Add Like button logic
                          onPressed: () {},
                          child: const Text(
                            'Like 👍',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
              ]),
            );
          },
        ),
      ),
    );
  }
}
