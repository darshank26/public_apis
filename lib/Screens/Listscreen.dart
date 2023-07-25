import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AdHelper/adshelper.dart';
import '../utils/WishItem.dart';
import '../utils/constants.dart';

class ListScreen extends StatefulWidget {

  final int listIndex;

  const ListScreen({Key? key,required this.listIndex}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState(listIndex);


}

class _ListScreenState extends State<ListScreen> {

  late BannerAd _bannerAd;

  bool _isBannerAdReady = false;

  final int listIndex;

  _ListScreenState(this.listIndex);

  List<SaveItem> wishListItems = [];


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

  final List<List<String>> data_2 = [
    ["AdoptAPet", "Resource to help get pets adopted","https://www.adoptapet.com/public/apis/pet_list.html","apikey","HTTPS","CORS"],
    ["Axolotl", "Collection of axolotl pictures and facts","https://theaxolotlapi.netlify.app/","","HTTPS",""],
    ["Cat Facts", "Daily cat facts","https://alexwohlbruck.github.io/cat-facts/","","HTTPS",""],
    ["Cataas", "Cat as a service (cats pictures and gifs)","https://cataas.com/","","HTTPS",""],
    ["Cats", "Pictures of cats from Tumblr","https://developers.thecatapi.com/view-account/ylX4blBYT9FaoVd6OhvR?report=bOoHBz-8t","apikey","HTTPS",""],
    ["Dog Facts", "Random dog facts","https://dukengn.github.io/Dog-facts-API/","","HTTPS","CORS"],
    ["Dog Facts", "Random facts of Dogs","https://kinduff.github.io/dog-api/","","HTTPS","CORS"],
    ["Dogs", "Based on the Stanford Dogs Dataset","https://dog.ceo/dog-api/","","HTTPS","CORS"],
    ["eBird", "Retrieve recent or notable birding observations within a region", "https://documenter.getpostman.com/view/664302/S1ENwy59","apikey","HTTPS",""],
    ["FishWatch", "Information and pictures about individual fish species","https://github.com/public-apis/public-apis#animals","","HTTPS","CORS"],
    ["HTTP Cat", "Cat for every HTTP Status","https://http.cat/","","HTTPS","CORS"],
    ["HTTP Dog", "Dogs for every HTTP response status code","https://http.dog/","","HTTPS","CORS"],
    ["IUCN", "IUCN Red List of Threatened Species", "http://apiv3.iucnredlist.org/api/v3/docs","apikey","",""],
    ["MeowFacts", "Get random cat facts","https://github.com/wh-iterabb-it/meowfacts","","HTTPS",""],
    ["Movebank", "Movement and Migration data of animals","https://github.com/movebank/movebank-api-doc","","HTTPS","CORS"],
    ["Petfinder", "Petfinder is dedicated to helping pets find homes, another resource to get pets adopted","https://www.petfinder.com/developers/","apikey","HTTPS","CORS"],
    ["PlaceBear", "Placeholder bear pictures","https://placebear.com/","","HTTPS","CORS"],
    ["PlaceDog", "Placeholder Dog pictures","https://place.dog/","","HTTPS","CORS"],
    ["PlaceKitten", "Placeholder Kitten pictures","https://placekitten.com/","","HTTPS","CORS"],
    ["RandomDog", "Random pictures of dogs","https://random.dog/woof.json","","HTTPS","CORS"],
    ["RandomDuck", "Random pictures of ducks","https://random-d.uk/api","","HTTPS",""],
    ["RandomFox", "Random pictures of foxes","https://randomfox.ca/floof/","","HTTPS",""],
    ["RescueGroups", "Adoption","https://userguide.rescuegroups.org/display/APIDG/API+Developers+Guide+Home","","HTTPS","unknown"],
    ["Shibe.Online", "Random pictures of Shiba Inu, cats or birds","https://shibe.online/","","HTTPS","CORS"],
    ["The Dog", "A public service all about Dogs, free to use when making your fancy new App, Website or Service", "https://thedogapi.com/","apikey","HTTPS",""],
    ["xeno-canto", "Bird recordings","https://xeno-canto.org/explore/api","","HTTPS","unknown"],
    ["Zoo Animals", "Facts and pictures of zoo animals","https://zoo-animal-api.herokuapp.com/","","HTTPS","CORS"]
  ];

  final List<List<String>> data_3 = [
    ["AniAPI", "Anime discovery, streaming & syncing with trackers","https://aniapi.com/docs/", "OAuth","HTTPS","CORS"],
    ["AniDB", "Anime Database","https://wiki.anidb.net/HTTP_API_Definition", "apiKey","","unknown"],
    ["AniList", "Anime discovery & tracking", "https://github.com/AniList/ApiV2-GraphQL-Docs","OAuth","HTTPS","unknown"],
    ["AnimeChan", "Anime quotes (over 10k+)","https://github.com/RocktimSaikia/anime-chan","","HTTPS",""],
    ["AnimeFacts", "Anime Facts (over 100+)","https://chandan-02.github.io/anime-facts-rest-api/","","HTTPS","CORS"],
    ["AnimeNewsNetwork", "Anime industry news","https://www.animenewsnetwork.com/encyclopedia/api.php","","HTTPS","CORS"],
    ["Catboy", "Neko images, funny GIFs & more","https://catboys.com/api","","HTTPS","CORS"],
    ["Danbooru Anime", "Thousands of anime artist database to find good anime art","https://danbooru.donmai.us/wiki_pages/help:api","apiKey","HTTPS","CORS"],
    ["Jikan", "Unofficial MyAnimeList API","https://jikan.moe/","","HTTPS","CORS"],
    ["Kitsu", "Anime discovery platform","https://kitsu.docs.apiary.io/#","OAuth","HTTPS","CORS"],
    ["MangaDex", "Manga Database and Community","https://api.mangadex.org/docs.html","apiKey","HTTPS","unknown"],
    ["Mangapi", "Translate manga pages from one language to another","https://rapidapi.com/pierre.carcellermeunier/api/mangapi3/","apiKey","HTTPS","unknown"],
    ["MyAnimeList", "Anime and Manga Database and Community","https://myanimelist.net/clubs.php?cid=13727","OAuth","HTTPS","unknown"],
    ["NekosBest", "Neko Images & Anime roleplaying GIFs","https://docs.nekos.best/","","HTTPS","CORS"],
    ["Shikimori", "Anime discovery, tracking, forum, rates","https://shikimori.one/api/doc","OAuth","HTTPS","unknown"],
    ["Studio Ghibli", "Resources from Studio Ghibli films","https://ghibliapi.herokuapp.com/","","HTTPS","CORS"],
    ["Trace Moe", "A useful tool to get the exact scene of an anime from a screenshot","https://soruly.github.io/trace.moe-api/#/","","HTTPS",""],
    ["Waifu.im", "Get waifu pictures from an archive of over 4000 images and multiple tags","https://docs.waifu.im/","","HTTPS","CORS"],
    ["Waifu.pics", "Image sharing platform for anime images","https://waifu.pics/docs","","HTTPS",""]

  ];

  @override
  Widget build(BuildContext context) {


     if(widget.listIndex == 1) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           backgroundColor: Colors.black,
           title: Text('Animals'),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_2.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_2[index];
               return Card(
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.black,
                     border: Border.all(
                       color: Colors.grey.shade300,
                       width: 0.5, // Set border width
                     ),
                     borderRadius: BorderRadius.all(
                         Radius.circular(
                             5.0) //                 <--- border radius here
                     ),
                   ),
                   child: ListTile(
                     title: Padding(
                       padding: const EdgeInsets.only(top: 8.0),
                       child: Text(row[0],
                           style: GoogleFonts.openSans(textStyle: TextStyle(
                             fontSize: 22,
                             color: Colors.white,
                             fontWeight: FontWeight.w800,))
                       ),
                     ), // Display item name
                     subtitle: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                           child: Text(
                               row[1],
                               style: GoogleFonts.openSans(textStyle: TextStyle(
                                 fontSize: 13,
                                 color: Colors.grey,
                                 fontWeight: FontWeight.w600,))
                           ),
                         ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             if(row[3] !="")
                             _buildChipOne(row[3], Color(0xff3f3f3f)) ,
                             SizedBox(width: 5,),
                             if(row[4] !="")
                               _buildChipTwo(row[4], Color(0xff3f3f3f)),
                             SizedBox(width: 5,),

                             if(row[5] !="")
                               _buildChipThree(row[5], Color(0xff3f3f3f)),
                             SizedBox(width: 5,),

                           ],
                         ),
                         SizedBox(height: 5,),



                       ],
                     ),
                     trailing: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         IconButton(
                           icon: Icon(
                               Icons.launch, color: Colors.white, size: 22),
                           onPressed: () {
                             _open(row[2]);

                           },
                         ),

                         IconButton(
                           icon: Icon(
                               Icons.bookmark_border, color: Colors.white,
                               size: 22),
                           onPressed: () {

                           },
                         ),
                       ],
                     ),
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
     else
     if(widget.listIndex == 2) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           backgroundColor: Colors.black,
           title: Text('Anime'),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_3.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_3[index];
               return Card(
                 child: Container(
                   decoration: BoxDecoration(
                     color: Colors.black,
                     border: Border.all(
                       color: Colors.grey.shade300,
                       width: 0.5, // Set border width
                     ),
                     borderRadius: BorderRadius.all(
                         Radius.circular(
                             5.0) //                 <--- border radius here
                     ),
                   ),
                   child: ListTile(
                     title: Padding(
                       padding: const EdgeInsets.only(top: 8.0),
                       child: Text(row[0],
                           style: GoogleFonts.openSans(textStyle: TextStyle(
                             fontSize: 22,
                             color: Colors.white,
                             fontWeight: FontWeight.w800,))
                       ),
                     ), // Display item name
                     subtitle: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                           child: Text(
                               row[1],
                               style: GoogleFonts.openSans(textStyle: TextStyle(
                                 fontSize: 13,
                                 color: Colors.grey,
                                 fontWeight: FontWeight.w600,))
                           ),
                         ),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             if(row[3] !="")
                               _buildChipOne(row[3], Color(0xff3f3f3f)) ,
                             SizedBox(width: 5,),
                             if(row[4] !="")
                               _buildChipTwo(row[4], Color(0xff3f3f3f)),
                             SizedBox(width: 5,),

                             if(row[5] !="")
                               _buildChipThree(row[5], Color(0xff3f3f3f)),
                             SizedBox(width: 5,),

                           ],
                         ),
                         SizedBox(height: 5,),



                       ],
                     ),
                     trailing: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         IconButton(
                           icon: Icon(
                               Icons.launch, color: Colors.white, size: 22),
                           onPressed: () {
                             _open(row[2]);

                           },
                         ),

                         IconButton(
                           icon: Icon(
                               Icons.bookmark_border, color: Colors.white,
                               size: 22),
                           onPressed: () {

                           },
                         ),
                       ],
                     ),
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

     else
       {
         return Container();
       }
  }


  Future<void> _open(String text) async {
    final Uri url = Uri.parse(text);
    if (!await launchUrl(url)) {
    throw Exception('Could not launch');
    }
  }

  Widget _buildChipOne(String label, Color color) {
    return Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        labelPadding: EdgeInsets.all(2.0),
      label: Container(
        width: 60,
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),

            ),

          ],
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(1.0),
    );
  }

  Widget _buildChipTwo(String label, Color color) {
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: EdgeInsets.all(2.0),
      label: Container(
        width: 60,
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),

            ),

          ],
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(1.0),
    );
  }

  Widget _buildChipThree(String label, Color color) {
    return Chip(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      labelPadding: EdgeInsets.all(2.0),
      label: Container(
        width: 60,
        height: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),

            ),

          ],
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(1.0),
    );
  }




}
