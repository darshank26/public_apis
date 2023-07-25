import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:launch_review/launch_review.dart';
import 'package:page_transition/page_transition.dart';
import 'package:public_apis/Screens/Listscreen.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AdHelper/adshelper.dart';
import '../utils/GridItem.dart';
import '../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  bool isLanguageSelected = false;


  final List<GridItem> items = [
    GridItem(title: 'Animals', imagePath: 'assets/images/1.jpg'),
    GridItem(title: 'Anime', imagePath: 'assets/images/2.jpg'),
    GridItem(title: 'Anti-Malware', imagePath: 'assets/images/3.jpg'),
    GridItem(title: 'Art & Design', imagePath: 'assets/images/4.jpg'),
    GridItem(title: 'Authentication', imagePath: 'assets/images/5.jpg'),
    GridItem(title: 'Blockchain', imagePath: 'assets/images/6.jpg'),
    GridItem(title: 'Books', imagePath: 'assets/images/7.jpg'),
    GridItem(title: 'Business', imagePath: 'assets/images/8.jpg'),
    GridItem(title: 'Calendar', imagePath: 'assets/images/9.jpg'),
    GridItem(title: 'Cloud Storage', imagePath: 'assets/images/10.jpg'),
    GridItem(title: 'Continuous Integration', imagePath: 'assets/images/11.jpg'),
    GridItem(title: 'Currency Exchange', imagePath: 'assets/images/12.jpg'),
    GridItem(title: 'Data Validation', imagePath: 'assets/images/13.jpg'),
    GridItem(title: 'Development', imagePath: 'assets/images/14.jpg'),
    GridItem(title: 'Dictionaries', imagePath: 'assets/images/15.jpg'),
    GridItem(title: 'Documents', imagePath: 'assets/images/16.jpg'),
    GridItem(title: 'Email', imagePath: 'assets/images/17.jpg'),
    GridItem(title: 'Entertainment', imagePath: 'assets/images/18.jpg'),
    GridItem(title: 'Environment', imagePath: 'assets/images/19.jpg'),
    GridItem(title: 'Events', imagePath: 'assets/images/20.jpg'),
    GridItem(title: 'Finance', imagePath: 'assets/images/21.jpg'),
    GridItem(title: 'Food & Drink', imagePath: 'assets/images/22.jpg'),
    GridItem(title: 'Games & Comics', imagePath: 'assets/images/23.jpg'),
    GridItem(title: 'Geocoding', imagePath: 'assets/images/24.jpg'),
    GridItem(title: 'Government', imagePath: 'assets/images/25.jpg'),
    GridItem(title: 'Health', imagePath: 'assets/images/26.jpg'),
    GridItem(title: 'Jobs', imagePath: 'assets/images/27.jpg'),
    GridItem(title: 'Machine Learning', imagePath: 'assets/images/28.jpg'),
    GridItem(title: 'Music', imagePath: 'assets/images/29.jpg'),
    GridItem(title: 'News', imagePath: 'assets/images/30.jpg'),
    GridItem(title: 'Open Data', imagePath: 'assets/images/31.jpg'),
    GridItem(title: 'Open Source', imagePath: 'assets/images/32.jpg'),
    GridItem(title: 'Patent', imagePath: 'assets/images/33.jpg'),
    GridItem(title: 'Personality', imagePath: 'assets/images/34.jpg'),
    GridItem(title: 'Phone', imagePath: 'assets/images/35.jpg'),
    GridItem(title: 'Photography', imagePath: 'assets/images/36.jpg'),
    GridItem(title: 'Programming', imagePath: 'assets/images/37.jpg'),
    GridItem(title: 'Science & Math', imagePath: 'assets/images/38.jpg'),
    GridItem(title: 'Security', imagePath: 'assets/images/39.jpg'),
    GridItem(title: 'Shopping', imagePath: 'assets/images/40.jpg'),
    GridItem(title: 'Social', imagePath: 'assets/images/41.jpg'),
    GridItem(title: 'Sports & Fitness', imagePath: 'assets/images/42.jpg'),
    GridItem(title: 'Test Data', imagePath: 'assets/images/43.jpg'),
    GridItem(title: 'Text Analysis', imagePath: 'assets/images/44.jpg'),
    GridItem(title: 'Tracking', imagePath: 'assets/images/45.jpg'),
    GridItem(title: 'Transportation', imagePath: 'assets/images/46.jpg'),
    GridItem(title: 'URL Shorteners', imagePath: 'assets/images/47.jpg'),
    GridItem(title: 'Vehicle', imagePath: 'assets/images/48.jpg'),
    GridItem(title: 'Video', imagePath: 'assets/images/49.jpg'),
    GridItem(title: 'Weather', imagePath: 'assets/images/50.jpg'),

  ];

  Future<void>? _launched;

  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitIdOfHomeScreen,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();

  }


  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String toLaunch = 'http://darshankomu.com/apps/Marathi%20Aarti%20Sangrah/privacypolicy.html';

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 10,
        title: Align(
          alignment: Alignment.center,
          child: Text("Public API",
              style: GoogleFonts.openSans(
                  letterSpacing: 0.8,
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all( 4.0),
        child: GridView.builder(
        itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,

              ),
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                      child: GestureDetector(
                          onTap: () {
                            if(index == 0)
                            {
                              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ListScreen(listIndex : index+1)));

                            }
                          },
                          child: Image.asset(items[index].imagePath,width: double.infinity, height: 100, fit: BoxFit.cover,)))
                ),
                const SizedBox(height: 0.3),
            Text(
                 items[index].title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        );
          },
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isBannerAdReady)
            Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
        ],
      ),

    );
  }


  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
  }


}


