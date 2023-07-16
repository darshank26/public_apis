import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:launch_review/launch_review.dart';
import 'package:page_transition/page_transition.dart';
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
    GridItem(title: 'Item 1', imagePath: 'assets/images/animal.jpg'),
    GridItem(title: 'Item 2', imagePath: 'assets/images/animal.jpg'),
    GridItem(title: 'Item 3', imagePath: 'assets/images/animal.jpg'),
    GridItem(title: 'Item 4', imagePath: 'assets/images/animal.jpg'),
    GridItem(title: 'Item 5', imagePath: 'assets/images/animal.jpg'),
    GridItem(title: 'Item 6', imagePath: 'assets/images/animal.jpg'),
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kprimarycolor,
        elevation: 10,
        title: Align(
          alignment: Alignment.center,
          child: Text("Public Api\'s",
              style: GoogleFonts.openSans(
                  letterSpacing: 0.8,
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      // Image.asset(items[index].imagePath,width: double.infinity, fit: BoxFit.fill,),

      body: Padding(
        padding: const EdgeInsets.all( 4.0),
        child: GridView.builder(
        itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        childAspectRatio: 0.9, // Width to height ratio of grid items
          ),
          itemBuilder: (context, index) {
        return GridTile(
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Image.asset(items[index].imagePath,width: double.infinity, height: 100, fit: BoxFit.fill,),

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


