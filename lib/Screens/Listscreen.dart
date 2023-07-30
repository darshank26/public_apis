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

  final List<List<String>> data_4 = [
    ["AbuseIPDB", "IP/domain/URL reputation","https://docs.abuseipdb.com/#introduction","apiKey","HTTPS","Unknown"],
    ["AlienVault Open Threat Exchange (OTX)", "IP/domain/URL reputation","https://otx.alienvault.com/api","apiKey","HTTPS","Unknown"],
    ["CAPEsandbox", "Malware execution and analysis","https://capev2.readthedocs.io/en/latest/usage/api.html","apiKey","HTTPS","Unknown"],
    ["Google Safe Browsing", "Google Link/Domain Flagging","https://developers.google.com/safe-browsing/","apiKey","HTTPS","Unknown"],
    ["MalDatabase", "Provide malware datasets and threat intelligence feeds","https://maldatabase.com/api-doc.html","apiKey","HTTPS","Unknown"],
    ["MalShare", "Malware Archive / file sourcing","https://malshare.com/doc.php","apiKey","HTTPS",""],
    ["MalwareBazaar", "Collect and share malware samples","https://bazaar.abuse.ch/api/","apiKey","HTTPS","Unknown"],
    ["Metacert", "Metacert Link Flagging","https://metacert.com/","apiKey","HTTPS","CORS"],
    ["NoPhishy", "Check links to see if they're known phishing attempts","https://rapidapi.com/Amiichu/api/exerra-phishing-check/","apiKey","HTTPS","Unknown"],
    ["Phisherman", "IP/domain/URL reputation","https://phisherman.gg/","apiKey","HTTPS","Unknown"],
    ["Scanii", "Simple REST API that can scan submitted documents/files for the presence of threats","https://docs.scanii.com/","apiKey","HTTPS","CORS"],
    ["URLhaus", "Bulk queries and Download Malware Samples","https://urlhaus-api.abuse.ch/","","HTTPS","CORS"],
    ["URLScan.io", "Scan and Analyse URLs","https://urlscan.io/docs/api/","apiKey","HTTPS","Unknown"],
    ["VirusTotal", "VirusTotal File/URL Analysis","https://www.virustotal.com/en/documentation/public-api/","apiKey","HTTPS","Unknown"],
    ["Web of Trust", "IP/domain/URL reputation","https://support.mywot.com/hc/en-us/sections/360004477734-API-","apiKey","HTTPS","Unknown"]
  ];

  final List<List<String>> data_5 = [

  ["Améthyste", "Generate images for Discord users","https://api.amethyste.moe/", "apiKey", "HTTPS", "Unknown"],
  ["Art Institute of Chicago", "Art","https://api.artic.edu/docs/", "", "HTTPS", "CORS"],
  ["Colormind", "Color scheme generator","http://colormind.io/api-access/", "", "", "Unknown"],
  ["ColourLovers", "Get various patterns, palettes and images", "https://www.colourlovers.com/api", "", "", "Unknown"],
  ["Cooper Hewitt", "Smithsonian Design Museum", "https://collection.cooperhewitt.org/api","apiKey", "HTTPS","Unknown"],
  ["Dribbble", "Discover the world’s top designers & creatives","https://developer.dribbble.com/", "OAuth", "HTTPS", "Unknown"],
  ["EmojiHub", "Get emojis by categories and groups","https://github.com/cheatsnake/emojihub", "", "HTTPS", "CORS"],
  ["Europeana", "European Museum and Galleries content","https://pro.europeana.eu/resources/apis/search", "apiKey", "HTTPS","Unknown"],
  ["Harvard Art Museums", "Art","https://github.com/harvardartmuseums/api-docs" , "apiKey", "", "Unknown"],
  ["Icon Horse", "Favicons for any website, with fallbacks","https://icon.horse/", "", "HTTPS", "CORS"],
  ["Iconfinder", "Icons","https://developer.iconfinder.com/", "apiKey", "HTTPS","Unknown"],
  ["Icons8", "Icons (find 'search icon' hyperlink in the page)", "https://img.icons8.com/","", "HTTPS", "Unknown"],
  ["Lordicon", "Icons with pre-done animations", "https://lordicon.com/","", "HTTPS", "CORS"],
  ["Metropolitan Museum of Art", "Met Museum of Art", "https://metmuseum.github.io/","", "HTTPS", ""],
  ["Noun Project", "Icons","http://api.thenounproject.com/index.html" ,"OAuth", "", "Unknown"],
  ["PHP-Noise", "Noise Background Image Generator", "https://php-noise.com/", "", "HTTPS", "CORS"],
  ["Pixel Encounter", "SVG Icon Generator","https://pixelencounter.com/api", "", "HTTPS", ""],
  ["Rijksmuseum", "RijksMuseum Data","https://data.rijksmuseum.nl/object-metadata/api/", "apiKey","HTTPS" ,"Unknown"],
  ["Word Cloud", "Easily create word clouds","https://wordcloudapi.com/", "apiKey","HTTPS" ,"Unknown"],
  ["xColors", "Generate & convert colors", "https://x-colors.herokuapp.com/","", "HTTPS", "CORS"]

];

  final List<List<String>> data_6 = [

    ["Auth0", "Easy to implement, adaptable authentication and authorization platform","https://auth0.com/", "apiKey", "HTTPS", "CORS"],
    ["GetOTP", "Implement OTP flow quickly","https://otp.dev/en/docs/", "apiKey", "HTTPS", ""],
    ["Micro User Service", "User management and authentication", "https://m3o.com/user","apiKey", "HTTPS", ""],
    ["MojoAuth", "Secure and modern passwordless authentication platform","https://mojoauth.com/", "apiKey", "HTTPS", "CORS"],
    ["SAWO Labs", "Simplify login and improve user experience by integrating passwordless authentication in your app","https://sawolabs.com/", "apiKey", "HTTPS", "CORS"],
    ["Stytch", "User infrastructure for modern applications", "https://stytch.com/","apiKey", "HTTPS", "No"],
    ["Warrant", "APIs for authorization and access control","https://warrant.dev/", "apiKey", "HTTPS", "CORS"]

  ];

  final List<List<String>> data_7 = [
    ["Bitquery", "Onchain GraphQL APIs & DEX APIs","https://ide.bitquery.io/", "apiKey", "HTTPS", "CORS"],
    ["Chainlink", "Build hybrid smart contracts with Chainlink","https://chain.link/developer-resources", "", "HTTPS", "Unknown"],
    ["Chainpoint", "Chainpoint is a global network for anchoring data to the Bitcoin blockchain","https://tierion.com/chainpoint/", "", "HTTPS", "Unknown"],
    ["Covalent", "Multi-blockchain data aggregator platform", "https://www.covalenthq.com/docs/api/","apiKey", "HTTPS", "Unknown"],
    ["Etherscan", "Ethereum explorer API","https://etherscan.io/apis", "apiKey", "HTTPS", "CORS"],
    ["Helium", "Helium is a global, distributed network of Hotspots that create public, long-range wireless coverage","https://docs.helium.com/blockchain/api/blockchain/introduction/", "", "HTTPS", "Unknown"],
    ["Nownodes", "Blockchain-as-a-service solution that provides high-quality connection via API", "https://nownodes.io/","apiKey", "HTTPS", "Unknown"],
    ["Steem", "Blockchain-based blogging and social media website", "https://developers.steem.io/","", "", ""],
    ["The Graph", "Indexing protocol for querying networks like Ethereum with GraphQL", "https://thegraph.com/","apiKey", "HTTPS", "Unknown"],
    ["Walltime", "To retrieve Walltime's market info", "https://walltime.info/api.html","", "HTTPS", "Unknown"],
    ["Watchdata", "Provide simple and reliable API access to Ethereum blockchain","https://docs.watchdata.io/" ,"apiKey", "HTTPS", "Unknown"]

    ];

  final List<List<String>> data_8 = [
  ["A Bíblia Digital", "Do not worry about managing the multiple versions of the Bible", "https://www.abibliadigital.com.br/en","apiKey", "HTTPS", ""],
  ["Bhagavad Gita", "Open Source Shrimad Bhagavad Gita API including 21+ authors translation in Sanskrit/English/Hindi","https://docs.bhagavadgitaapi.in/", "apiKey", "HTTPS", "CORS"],
  ["Bhagavad Gita", "Bhagavad Gita text", "https://bhagavadgita.io/api/","OAuth", "HTTPS", "CORS"],
  ["Bhagavad Gita telugu", "Bhagavad Gita API in telugu and odia languages", "https://gita-api.vercel.app/","", "HTTPS", "CORS"],
  ["Bible-api", "Free Bible API with multiple languages", "https://bible-api.com/","", "HTTPS", "CORS"],
  ["British National Bibliography", "Books","https://www.bl.uk/collection-metadata/metadata-services/linked-open-bnb", "", "", "Unknown"],
  ["Crossref Metadata Search", "Books & Articles Metadata", "https://github.com/CrossRef/rest-api-doc","", "HTTPS", "Unknown"],
  ["Ganjoor", "Classic Persian poetry works including access to related manuscripts, recitations and music tracks", "https://api.ganjoor.net/index.html","OAuth", "HTTPS", "CORS"],
  ["Google Books", "Books", "https://developers.google.com/books/","OAuth", "HTTPS", "Unknown"],
  ["GurbaniNow", "Fast and Accurate Gurbani RESTful API", "https://github.com/GurbaniNow/api","", "HTTPS", "Unknown"],
  ["Gutendex", "Web-API for fetching data from Project Gutenberg Books Library", "https://gutendex.com/","", "HTTPS", "Unknown"],
  ["Open Library", "Books, book covers and related data", "https://openlibrary.org/developers/api","", "HTTPS", "No"],
  ["Penguin Publishing", "Books, book covers and related data", "http://www.penguinrandomhouse.biz/webservices/rest/","", "HTTPS", "CORS"],
  ["PoetryDB", "Enables you to get instant data from our vast poetry collection", "https://github.com/thundercomb/poetrydb#readme","", "HTTPS", "CORS"],
  ["Quran", "RESTful Quran API with multiple languages", "https://quran.api-docs.io/","", "HTTPS", "CORS"],
  ["Quran Cloud", "A RESTful Quran API to retrieve an Ayah, Surah, Juz or the entire Holy Quran", "https://alquran.cloud/api","", "HTTPS", "CORS"],
  ["Quran-api", "Free Quran API Service with 90+ different languages and 400+ translations", "https://github.com/fawazahmed0/quran-api#readme","", "HTTPS", "CORS"],
  ["Rig Veda", "Gods and poets, their categories, and the verse meters, with the mandal and sukta number", "https://aninditabasu.github.io/indica/html/rv.html","", "HTTPS", "Unknown"],
  ["The Bible", "Everything you need from the Bible in one discoverable place","https://docs.api.bible/" ,"apiKey", "HTTPS", "Unknown"],
  ["Thirukkural", "1330 Thirukkural poems and explanation in Tamil and English","https://api-thirukkural.web.app/" ,"", "HTTPS", "CORS"],
  ["Vedic Society", "Descriptions of all nouns (names, places, animals, things) from vedic literature"," https://aninditabasu.github.io/indica/html/vs.html","", "HTTPS", "Unknown"],
  ["Wizard World", "Get information from the Harry Potter universe", "https://wizard-world-api.herokuapp.com/swagger/index.html","", "HTTPS", "CORS"],
  ["Wolne Lektury", "API for obtaining information about e-books available on the WolneLektury.pl website","https://wolnelektury.pl/api/" ,"", "HTTPS", "Unknown"]
  ];



  final List<List<String>> data_9 = [
    ["Apache Superset", "API to manage your BI dashboards and data sources on Superset", "https://superset.apache.org/docs/api/","apiKey", "HTTPS", "CORS"],
    ["Charity Search", "Non-profit charity data", "https://charityapi.orghunter.com/","apiKey", "", "Unknown"],
    ["Clearbit Logo", "Search for company logos and embed them in your projects","https://dashboard.clearbit.com/docs#logo-api", "apiKey", "HTTPS", "Unknown"],
    ["Domainsdb.info", "Registered Domain Names Search", "https://domainsdb.info/","", "HTTPS", ""],
    ["Freelancer", "Hire freelancers to get work done", "https://developers.freelancer.com/","OAuth", "HTTPS", "Unknown"],
    ["Gmail", "Flexible, RESTful access to the user's inbox", "https://developers.google.com/gmail/api/guides","OAuth", "HTTPS", "Unknown"],
    ["Google Analytics", "Collect, configure and analyze your data to reach the right audience", "https://developers.google.com/analytics/","OAuth", "HTTPS", "Unknown"],
    ["Instatus", "Post to and update maintenance and incidents on your status page through an HTTP REST API", "https://instatus.com/help/api","apiKey", "HTTPS", "Unknown"],
    ["Mailchimp", "Send marketing campaigns and transactional mails", "https://mailchimp.com/developer/","apiKey", "HTTPS", "Unknown"],
    ["mailjet", "Marketing email can be sent and mail templates made in MJML or HTML can be sent using API", "https://www.mailjet.com/","apiKey", "HTTPS", "Unknown"],
    ["markerapi", "Trademark Search","https://markerapi.com/", "", "", "Unknown"],
    ["ORB Intelligence", "Company lookup", "https://api.orb-intelligence.com/docs/","apiKey", "HTTPS", "Unknown"],
    ["Redash", "Access your queries and dashboards on Redash","https://redash.io/help/user-guide/integrations-and-api/api/", "apiKey", "HTTPS", "CORS"],
    ["Smartsheet", "Allows you to programmatically access and Smartsheet data and account information", "https://smartsheet.redoc.ly/","OAuth", "HTTPS", ""],
    ["Square", "Easy way to take payments, manage refunds, and help customers checkout online", "https://developer.squareup.com/reference/square","OAuth", "HTTPS", "Unknown"],
    ["SwiftKanban", "Kanban software, Visualize Work, Increase Organizations Lead Time, Throughput & Productivity", "https://www.nimblework.com/knowledge-base/swiftkanban/article/api-for-swift-kanban-web-services/#restapi","apiKey", "HTTPS", "Unknown"],
    ["Tenders in Hungary", "Get data for procurements in Hungary in JSON format","https://tenders.guru/hu/api", "", "HTTPS", "Unknown"],
    ["Tenders in Poland", "Get data for procurements in Poland in JSON format","https://tenders.guru/pl/api", "", "HTTPS", "Unknown"],
    ["Tenders in Romania", "Get data for procurements in Romania in JSON format", "https://tenders.guru/ro/api","", "HTTPS", "Unknown"],
    ["Tenders in Spain", "Get data for procurements in Spain in JSON format", "https://tenders.guru/es/api","", "HTTPS", "Unknown"],
    ["Tenders in Ukraine", "Get data for procurements in Ukraine in JSON format", "https://tenders.guru/ua/api","", "HTTPS", "Unknown"],
    ["Tomba email finder", "Email Finder for B2B sales and email marketing and email verifier","https://tomba.io/api", "apiKey", "HTTPS", "CORS"],
    ["Trello", "Boards, lists and cards to help you organize and prioritize your projects", "https://developer.atlassian.com/cloud/trello/","OAuth", "HTTPS", "Unknown"]
  ];


  final List<List<String>> data_10 = [
    ["Abstract Public Holidays", "Data on national, regional, and religious holidays via API", "https://www.abstractapi.com/api/holidays-api","apiKey", "HTTPS", "CORS"],
    ["Calendarific", "Worldwide Holidays", "https://calendarific.com/","apiKey", "HTTPS", "Unknown"],
    ["Checkiday - National Holiday API", "Industry-leading Holiday API. Over 5,000 holidays and thousands of descriptions. Trusted by the World’s leading companies", "https://apilayer.com/marketplace/checkiday-api","apiKey", "HTTPS", "Unknown"],
    ["Church Calendar", "Catholic liturgical calendar", "http://calapi.inadiutorium.cz/","", "", "Unknown"],
    ["Czech Namedays Calendar", "Lookup for a name and returns nameday date","https://svatky.adresa.info/", "", "", "Unknown"],
    ["Festivo Public Holidays", "Fastest and most advanced public holiday and observance service on the market","https://docs.getfestivo.com/docs/products/public-holidays-api/intro/", "apiKey", "HTTPS", "CORS"],
    ["Google Calendar", "Display, create and modify Google calendar events","https://developers.google.com/google-apps/calendar/", "OAuth", "HTTPS", "Unknown"],
    ["Hebrew Calendar", "Convert between Gregorian and Hebrew, fetch Shabbat and Holiday times, etc","https://www.hebcal.com/home/developer-apis", "", "", "Unknown"],
    ["Holidays", "Historical data regarding holidays", "https://holidayapi.com/","apiKey", "HTTPS", "Unknown"],
    ["LectServe", "Protestant liturgical calendar", "https://www.lectserve.com/","", "", "Unknown"],
    ["Nager.Date", "Public holidays for more than 90 countries", "https://date.nager.at/","", "HTTPS", ""],
    ["Namedays Calendar", "Provides namedays for multiple countries","https://nameday.abalin.net/", "", "HTTPS", "CORS"],
    ["Non-Working Days", "Database of ICS files for non working days", "https://github.com/gadael/icsdb","", "HTTPS", "Unknown"],
    ["Non-Working Days", "Simple REST API for checking working, non-working or short days for Russia, CIS, USA and other","https://www.isdayoff.ru/", "", "HTTPS", "CORS"],
    ["Russian Calendar", "Check if a date is a Russian holiday or not", "https://github.com/egno/work-calendar","", "HTTPS", ""],
    ["UK Bank Holidays", "Bank holidays in England and Wales, Scotland and Northern Ireland", "https://www.gov.uk/bank-holidays.json","", "HTTPS", "Unknown"]

  ];

  final List<List<String>> data_11 = [

  ["AnonFiles", "Upload and share your files anonymously", "https://anonfiles.com/docs/api","", "HTTPS", "Unknown"],
  ["BayFiles", "Upload and share your files","https://bayfiles.com/docs/api", "", "HTTPS", "Unknown"],
  ["Box", "File Sharing and Storage","https://developer.box.com/", "OAuth", "HTTPS", "Unknown"],
  ["ddownload", "File Sharing and Storage","https://ddownload.com/api", "apiKey", "HTTPS", "Unknown"],
  ["Dropbox", "File Sharing and Storage","https://www.dropbox.com/developers", "OAuth", "HTTPS", "Unknown"],
  ["File.io", "Super simple file sharing, convenient, anonymous and secure","https://www.file.io/", "", "HTTPS", "Unknown"],
  ["Filestack", "Filestack File Uploader & File Upload API","https://www.filestack.com/", "apiKey", "HTTPS", "Unknown"],
  ["GoFile", "Unlimited size file uploads for free", "https://gofile.io/api","apiKey", "HTTPS", "Unknown"],
  ["Google Drive", "File Sharing and Storage","https://developers.google.com/drive/" ,"OAuth", "HTTPS", "Unknown"],
  ["Gyazo", "Save & Share screen captures instantly", "https://gyazo.com/api/docs","apiKey", "HTTPS", "Unknown"],
  ["Imgbb", "Simple and quick private image sharing", "https://api.imgbb.com/","apiKey", "HTTPS", "Unknown"],
  ["OneDrive", "File Sharing and Storage", "https://developer.microsoft.com/en-us/onedrive","OAuth", "HTTPS", "Unknown"],
  ["Pantry", "Free JSON storage for small projects", "https://getpantry.cloud/","", "HTTPS", "CORS"],
  ["Pastebin", "Plain Text Storage", "https://pastebin.com/doc_api","apiKey", "HTTPS", "Unknown"],
  ["Pinata", "IPFS Pinning Services API","https://docs.pinata.cloud/", "apiKey", "HTTPS", "Unknown"],
  ["Quip", "File Sharing and Storage for groups", "https://quip.com/dev/automation/documentation","apiKey", "HTTPS", "CORS"],
  ["Storj", "Decentralized Open-Source Cloud Storage", "https://docs.storj.io/dcs/","apiKey", "HTTPS", "Unknown"],
  ["The Null Pointer", "No-bullshit file hosting and URL shortening service", "https://0x0.st/","", "HTTPS", "Unknown"],
  ["Web3 Storage", "File Sharing and Storage for Free with 1TB Space","https://web3.storage/", "apiKey", "HTTPS", "CORS"]
  ];

  final List<List<String>> data_12 = [

    ["Azure DevOps Health", "Resource health helps you diagnose and get support when an Azure issue impacts your resources", "https://learn.microsoft.com/en-us/rest/api/resourcehealth/","apiKey", "", ""],
    ["Bitrise", "Build tool and processes integrations to create efficient development pipelines","https://api-docs.bitrise.io/","apiKey", "HTTPS", "Unknown"],
    ["Buddy", "The fastest continuous integration and continuous delivery platform","https://buddy.works/docs/api/getting-started/overview", "OAuth", "HTTPS", "Unknown"],
    ["CircleCI", "Automate the software development process using continuous integration and continuous delivery","https://circleci.com/docs/api/v1/index.html#circleci-v1-api-overview", "apiKey", "HTTPS", "Unknown"],
    ["Codeship", "Codeship is a Continuous Integration Platform in the cloud","https://docs.cloudbees.com/docs/cloudbees-codeship/latest/api-overview/", "apiKey", "HTTPS", "Unknown"],
    ["Travis CI", "Sync your GitHub projects with Travis CI to test your code in minutes","https://docs.travis-ci.com/api/", "apiKey", "HTTPS", "Unknown"]

  ];


  final List<List<String>> data_13 = [

  ["0x", "API for querying token and pool stats across various liquidity pools","https://0x.org/api", "", "HTTPS", "CORS"],
  ["1inch", "API for querying decentralized exchange","https://1inch.io/api/", "", "HTTPS", "Unknown"],
  ["Alchemy Ethereum", "Ethereum Node-as-a-Service Provider","https://docs.alchemy.com/", "apiKey", "HTTPS", "CORS"],
  ["apilayer coinlayer", "Real-time Crypto Currency Exchange Rates","https://coinlayer.com/", "apiKey", "HTTPS", "Unknown"],
  ["Binance", "Exchange for Trading Cryptocurrencies based in China", "https://github.com/binance/binance-spot-api-docs","apiKey", "HTTPS", "Unknown"],
  ["Bitcambio", "Get the list of all traded assets in the exchange","https://nova.bitcambio.com.br/api/v3/docs#a-public", "", "HTTPS", "Unknown"],
  ["BitcoinAverage", "Digital Asset Price Data for the blockchain industry","https://apiv2.bitcoinaverage.com/", "apiKey", "HTTPS", "Unknown"],
  ["BitcoinCharts", "Financial and Technical Data related to the Bitcoin Network", "https://bitcoincharts.com/about/exchanges/","No", "HTTPS", "Unknown"],
  ["Bitfinex", "Cryptocurrency Trading Platform","https://docs.bitfinex.com/docs", "apiKey", "HTTPS", "Unknown"],
  ["Bitmex", "Real-Time Cryptocurrency derivatives trading platform based in Hong Kong","https://www.bitmex.com/app/apiOverview", "apiKey", "HTTPS", "Unknown"],
  ["Bittrex", "Next Generation Crypto Trading Platform","https://bittrex.github.io/api/v3", "apiKey", "HTTPS", "Unknown"],
  ["Block", "Bitcoin Payment, Wallet & Transaction Data", "https://block.io/docs/basic","apiKey", "HTTPS", "Unknown"],
  ["Blockchain", "Bitcoin Payment, Wallet & Transaction Data", "https://www.blockchain.com/explorer/api","apiKey", "HTTPS", "Unknown"],
  ["blockfrost Cardano", "Interaction with the Cardano mainnet and several testnets", "https://blockfrost.io/","apiKey", "HTTPS", "Unknown"],
  ["Brave NewCoin", "Real-time and historic crypto data from more than 200+ exchanges","https://bravenewcoin.com/developers", "apiKey", "HTTPS", "Unknown"],
  ["BtcTurk", "Real-time cryptocurrency data, graphs and API that allows buy&sell","https://docs.btcturk.com/", "apiKey", "HTTPS", "CORS"],
  ["Bybit", "Cryptocurrency data feed and algorithmic trading", "https://bybit-exchange.github.io/docs/linear/#t-introduction","apiKey", "HTTPS", "Unknown"],
  ["CoinAPI", "All Currency Exchanges integrate under a single api","https://docs.coinapi.io/", "apiKey", "HTTPS", ""],
  ["Coinbase", "Bitcoin, Bitcoin Cash, Litecoin and Ethereum Prices","https://www.coinbase.com/cloud", "apiKey", "HTTPS", "Unknown"],
  ["Coinbase Pro", "Cryptocurrency Trading Platform", "https://docs.cloud.coinbase.com/exchange/docs/welcome#api","apiKey", "HTTPS", "Unknown"],
  ["CoinCap", "Real-time Cryptocurrency prices through a RESTful API", "https://docs.coincap.io/", "", "HTTPS", "Unknown"],
  ["CoinDCX", "Cryptocurrency Trading Platform", "https://docs.coindcx.com/#terms-and-conditions","apiKey", "HTTPS", "Unknown"],
  ["CoinDesk", "CoinDesk's Bitcoin Price Index (BPI) in multiple currencies", "https://old.coindesk.com/coindesk-api/","", "HTTPS", "Unknown"],
  ["CoinGecko", "Cryptocurrency Price, Market, and Developer/Social Data", "http://www.coingecko.com/api", "","HTTPS", "CORS"],
  ["Coinigy", "Interacting with Coinigy Accounts and Exchange Directly", "https://coinigy.docs.apiary.io/#","apiKey", "HTTPS", "Unknown"],
  ["Coinlib", "Crypto Currency Prices", "https://coinlib.io/apidocs","apiKey", "HTTPS", "Unknown"],
  ["Coinlore", "Cryptocurrencies prices, volume and more", "https://www.coinlore.com/cryptocurrency-data-api","", "HTTPS", "Unknown"],

  ["CoinMarketCap", "Cryptocurrencies Prices", "https://coinmarketcap.com/api/","apiKey", "HTTPS", "Unknown"],
  ["Coinpaprika", "Cryptocurrencies prices, volume and more", "https://api.coinpaprika.com/", "","HTTPS", "CORS"],
  ["CoinRanking", "Live Cryptocurrency data", "https://developers.coinranking.com/api/documentation","apiKey", "HTTPS", "Unknown"],
  ["Coinremitter", "Cryptocurrencies Payment & Prices", "https://coinremitter.com/docs","apiKey", "HTTPS", "Unknown"],
  ["CoinStats", "Crypto Tracker","https://documenter.getpostman.com/view/5734027/RzZ6Hzr3?version=latest", "No", "HTTPS", "Unknown"],
  ["CryptAPI", "Cryptocurrency Payment Processor", "https://docs.cryptapi.io/", "","HTTPS", "Unknown"],
  ["CryptingUp", "Cryptocurrency data", "https://www.cryptingup.com/apidoc/#introduction", "","HTTPS", "Unknown"],
  ["CryptoCompare", "Cryptocurrencies Comparison", "https://min-api.cryptocompare.com/", "","HTTPS", "Unknown"],
  ["CryptoMarket", "Cryptocurrencies Trading platform", "https://api.exchange.cryptomkt.com/","apiKey", "HTTPS", "CORS"],
  ["Cryptonator", "Cryptocurrencies Exchange Rates", "https://www.cryptonator.com/api/", "","HTTPS", "Unknown"],
  ["dYdX", "Decentralized cryptocurrency exchange","https://dydxprotocol.github.io/v3-teacher/#terms-of-service-and-privacy-policy" ,"apiKey", "HTTPS", "Unknown"],
  ["Ethplorer", "Ethereum tokens, balances, addresses, history of transactions, contracts, and custom structures","https://github.com/EverexIO/Ethplorer/wiki/Ethplorer-API", "apiKey", "HTTPS", "Unknown"],
  ["EXMO", "Cryptocurrencies exchange based in UK", "https://documenter.getpostman.com/view/10287440/SzYXWKPi","apiKey", "HTTPS", "Unknown"],
  ["FTX", "Complete REST, websocket, and FTX APIs to suit your algorithmic trading needs", "https://docs.ftx.com/","apiKey", "HTTPS", "CORS"],
  ["Gateio", "API provides spot, margin and futures trading operations", "https://www.gate.io/api2","apiKey", "HTTPS", "Unknown"],
  ["Gemini", "Cryptocurrencies Exchange", "https://docs.gemini.com/rest-api/","", "HTTPS", "Unknown"],
  ["Hirak Exchange Rates", "Exchange rates between 162 currency & 300 crypto currency update each 5 min, accurate, no limits","https://rates.hirak.site/", "apiKey", "HTTPS", "Unknown"],
  ["Huobi", "Seychelles based cryptocurrency exchange", "https://huobiapi.github.io/docs/spot/v1/en/","apiKey", "HTTPS", "Unknown"],
  ["icy.tools", "GraphQL based NFT API","https://developers.icy.tools/", "apiKey", "HTTPS", "Unknown"],
  ["Indodax", "Trade your Bitcoin and other assets with rupiah", "https://github.com/btcid/indodax-official-api-docs","apiKey", "HTTPS", "Unknown"],
  ["INFURA Ethereum", "Interaction with the Ethereum mainnet and several testnets","https://www.infura.io/product/ethereum", "apiKey", "HTTPS", "CORS"],
  ["Kraken", "Cryptocurrencies Exchange","https://docs.kraken.com/rest/", "apiKey", "HTTPS", "Unknown"],
  ["KuCoin", "Cryptocurrency Trading Platform","https://docs.kucoin.com/#hftrading", "apiKey", "HTTPS", "Unknown"],
  ["Localbitcoins", "P2P platform to buy and sell Bitcoins", "https://localbitcoins.com/api-docs/", "","HTTPS", "Unknown"],
  ["Mempool", "Bitcoin API Service focusing on the transaction fee", "https://mempool.space/api", "","HTTPS", ""],
  ["MercadoBitcoin", "Brazilian Cryptocurrency Information","https://www.mercadobitcoin.com.br/api-doc/", "", "HTTPS", "Unknown"],
  ["Messari", "Provides API endpoints for thousands of crypto assets","https://messari.io/", "", "HTTPS", "Unknown"],
  ["Nexchange", "Automated cryptocurrency exchange service","https://nexchange2.docs.apiary.io/", "", "", "CORS"],
  ["Nomics", "Historical and realtime cryptocurrency prices and market data","https://nomics.com/docs/", "apiKey", "HTTPS", "CORS"],
  ["NovaDax", "NovaDAX API to access all market data, trading management endpoints","https://doc.novadax.com/en-US/#introduction", "apiKey", "HTTPS", "Unknown"],
  ["OKEx", "Cryptocurrency exchange based in Seychelles","https://www.okx.com/docs-v5/", "apiKey", "HTTPS", "Unknown"],
  ["Poloniex", "US based digital asset exchange","https://docs.poloniex.com/#introduction", "apiKey", "HTTPS", "Unknown"],
  ["Solana JSON RPC", "Provides various endpoints to interact with the Solana Blockchain","https://docs.solana.com/api/http", "", "HTTPS", "Unknown"],
  ["Technical Analysis", "Cryptocurrency prices and technical analysis", "https://technical-analysis-api.com/","apiKey", "", ""],
  ["VALR", "Cryptocurrency Exchange based in South Africa","https://docs.valr.com/", "apiKey", "HTTPS", "Unknown"],
  ["WorldCoinIndex", "Cryptocurrencies Prices", "https://www.worldcoinindex.com/apiservice","apiKey", "HTTPS", "Unknown"],
  ["ZMOK", "Ethereum JSON RPC API and Web3 provider","https://zmok.io/", "", "HTTPS", "Unknown"]

  ];

  final List<List<String>> data_14 = [

  ["1Forge", "Forex currency market data","https://1forge.com/api", "apiKey", "HTTPS", "Unknown"],
  ["Amdoren", "Free currency API with over 150 currencies","https://www.amdoren.com/currency-api/", "apiKey", "HTTPS", "Unknown"],
  ["apilayer fixer.io", "Exchange rates and currency conversion","https://fixer.io/", "apiKey", "", "Unknown"],
  ["Bank of Russia", "Exchange rates and currency conversion","https://www.cbr.ru/development/SXML/", "", "HTTPS", "Unknown"],
  ["Currency-api", "Free Currency Exchange Rates API with 150+ Currencies & No Rate Limits","https://github.com/fawazahmed0/currency-api#readme", "", "HTTPS", "CORS"],
  ["CurrencyFreaks", "Provides current and historical currency exchange rates with free plan 1K requests/month", "https://currencyfreaks.com/","apiKey", "HTTPS", "CORS"],
  ["Currencylayer", "Exchange rates and currency conversion", "https://currencylayer.com/documentation","apiKey", "HTTPS", "Unknown"],
  ["CurrencyScoop", "Real-time and historical currency rates JSON API","https://currencyscoop.com/api-documentation", "apiKey", "HTTPS", "CORS"],
  ["Czech National Bank", "A collection of exchange rates", "https://www.cnb.cz/cs/financni_trhy/devizovy_trh/kurzy_devizoveho_trhu/denni_kurz.xml","", "HTTPS", "Unknown"],
  ["Economia.Awesome", "Portuguese free currency prices and conversion with no rate limits","https://docs.awesomeapi.com.br/api-de-moedas", "", "HTTPS", "Unknown"],
  ["ExchangeRate-API", "Free currency conversion","https://www.exchangerate-api.com/", "apiKey", "HTTPS", "CORS"],
  ["Exchangerate.host", "Free foreign exchange & crypto rates API", "https://exchangerate.host/#/","", "HTTPS", "Unknown"],
  ["Exchangeratesapi.io", "Exchange rates with currency conversion", "https://exchangeratesapi.io/","apiKey", "HTTPS", "CORS"],
  ["Frankfurter", "Exchange rates, currency conversion and time series", "https://www.frankfurter.app/docs/","", "HTTPS", "CORS"],
  ["FreeForexAPI", "Real-time foreign exchange rates for major currency pairs","https://freeforexapi.com/Home/Api", "", "HTTPS", ""],
  ["National Bank of Poland", "A collection of currency exchange rates (data in XML and JSON)", "http://api.nbp.pl/en.html","", "HTTPS", "CORS"],
  ["VATComply.com", "Exchange rates, geolocation and VAT number validation", "https://www.vatcomply.com/documentation","", "HTTPS", "CORS"]
];

  final List<List<String>> data_15 = [

  ["Lob.com", "US Address Verification", "https://www.lob.com/", "apiKey", "HTTPS", "Unknown"],
  ["Postman Echo", "Test api server to receive and return value from HTTP method","https://www.postman-echo.com/", "", "HTTPS", "Unknown"],
  ["PurgoMalum", "Content validator against profanity & obscenity", "http://www.purgomalum.com/","", "", "Unknown"],
  ["US Autocomplete", "Enter address data quickly with real-time address suggestions","https://www.smarty.com/docs/cloud/us-autocomplete-pro-api", "apiKey", "HTTPS", "CORS"],
  ["US Extract", "Extract postal addresses from any text including emails","https://www.smarty.com/products/apis/us-extract-api", "apiKey", "HTTPS", "CORS"],
  ["US Street Address", "Validate and append data for any US postal address", "https://www.smarty.com/docs/cloud/us-street-api","apiKey", "HTTPS", "CORS"],
  ["vatlayer", "VAT number validation","https://vatlayer.com/documentation", "apiKey", "HTTPS", "Unknown"]

  ];

  final List<List<String>> data_16 = [


    ["24 Pull Requests", "Project to promote open source collaboration during December", "https://24pullrequests.com/api" ,"", "HTTPS", "CORS"],
  ["Abstract Screenshot", "Take programmatic screenshots of web pages from any website", "https://www.abstractapi.com/api/website-screenshot-api","apiKey", "HTTPS", "CORS"],
  ["Agify.io", "Estimates the age from a first name","https://agify.io/", "", "HTTPS", "CORS"],
  ["API Grátis", "Multiples services and public APIs","https://apigratis.com.br/", "", "HTTPS", "Unknown"],
  ["ApicAgent", "Extract device details from user-agent string","https://www.apicagent.com/", "", "HTTPS", "CORS"],
  ["ApiFlash", "Chrome based screenshot API for developers", "https://apiflash.com/","apiKey", "HTTPS", "Unknown"],
  ["apilayer userstack", "Secure User-Agent String Lookup JSON API", "https://userstack.com/","OAuth", "HTTPS", "Unknown"],
  ["APIs.guru", "Wikipedia for Web APIs, OpenAPI/Swagger specs for public APIs", "https://apis.guru/api-doc/","", "HTTPS", "Unknown"],
  ["Azure DevOps", "The Azure DevOps basic components of a REST API request/response pair", "https://learn.microsoft.com/en-us/rest/api/azure/devops/?view=azure-devops-rest-7.1","apiKey", "HTTPS", "Unknown"],
  ["Base", "Building quick backends", "http://ww12.base-api.io/","apiKey", "HTTPS", "CORS"],
  ["Beeceptor", "Build a mock Rest API endpoint in seconds", "https://beeceptor.com/","", "HTTPS", "CORS"],
  ["Bitbucket", "Bitbucket API","https://developer.atlassian.com/cloud/bitbucket/?utm_source=%2Fbitbucket%2Fapi%2F2%2Freference%2F&utm_medium=302", "OAuth", "HTTPS", "Unknown"],
  ["Blague.xyz", "La plus grande API de Blagues FR/The biggest FR jokes API", "https://blague.xyz/","apiKey", "HTTPS", "CORS"],
  ["Blitapp", "Schedule screenshots of web pages and sync them to your cloud", "https://blitapp.com/api/","apiKey", "HTTPS", "Unknown"],
  ["Blynk-Cloud", "Control IoT Devices from Blynk IoT Cloud","https://blynkapi.docs.apiary.io/#", "apiKey", "", "Unknown"],
  ["Bored", "Find random activities to fight boredom", "https://www.boredapi.com/","", "HTTPS", "Unknown"],
  ["Brainshop.ai", "Make A Free A.I Brain", "https://brainshop.ai/","apiKey", "HTTPS", "CORS"],
  ["Browshot", "Easily make screenshots of web pages in any screen size, as any device", "https://browshot.com/api/documentation","apiKey", "HTTPS", "CORS"],
  ["CDNJS", "Library info on CDNJS", "https://api.cdnjs.com/libraries/jquery","", "HTTPS", "Unknown"],
  ["Changelogs.md", "Structured changelog metadata from open source projects","https://changelogs.md/", "", "HTTPS", "Unknown"],
  ["Ciprand", "Secure random string generator", "https://github.com/polarspetroll/ciprand","", "HTTPS", ""],
  ["Cloudflare Trace", "Get IP Address, Timestamp, User Agent, Country Code, IATA, HTTP Version, TLS/SSL Version & More","https://github.com/fawazahmed0/cloudflare-trace-api", "", "HTTPS", "CORS"],
  ["Codex", "Online Compiler for Various Languages", "https://github.com/Jaagrav/CodeX","", "HTTPS", "Unknown"],
  ["Contentful Images", "Used to retrieve and apply transformations to images", "https://www.contentful.com/developers/docs/references/images-api/","apiKey", "HTTPS", "CORS"],
  ["CORS Proxy", "Get around the dreaded CORS error by using this proxy as a middle man", "https://github.com/burhanuday/cors-proxy","", "HTTPS", "CORS"],
  ["CountAPI", "Free and simple counting service. You can use it to track page hits and specific events", "https://countapi.xyz/","", "HTTPS", "CORS"],
  ["Databricks", "Service to manage your databricks account,clusters, notebooks, jobs and workspaces", "https://docs.databricks.com/api/workspace/introduction","apiKey", "HTTPS", "CORS"],
  ["DigitalOcean Status", "Status of all DigitalOcean services", "https://status.digitalocean.com/api","", "HTTPS", "Unknown"],
  ["Docker Hub", "Interact with Docker Hub", "https://docs.docker.com/docker-hub/api/latest/","apiKey", "HTTPS", "CORS"],
  ["DomainDb Info", "Domain name search to find all domains containing particular words/phrases/etc","https://api.domainsdb.info/", "", "HTTPS", "Unknown"],
  ["ExtendsClass JSON Storage", "A simple JSON store API", "https://extendsclass.com/json-storage.html","", "HTTPS", "CORS"],
  ["GeekFlare", "Provide numerous capabilities for important testing and monitoring methods for websites","https://apidocs.geekflare.com/docs/geekflare-api", "apiKey", "HTTPS", "Unknown"],
  ["Genderize.io", "Estimates a gender from a first name","https://genderize.io/", "", "HTTPS", "CORS"],
  ["GETPing", "Trigger an email notification with a simple GET request", "https://www.getping.info/","apiKey", "HTTPS", "Unknown"],
  ["Ghost", "Get Published content into your Website, App or other embedded media","https://ghost.org/", "apiKey", "HTTPS", "CORS"],
  ["GitHub", "Make use of GitHub repositories, code and user info programmatically","https://docs.github.com/en/rest?apiVersion=2022-11-28", "OAuth", "HTTPS", "CORS"],
  ["Gitlab", "Automate GitLab interaction programmatically","https://docs.gitlab.com/ee/api/", "OAuth", "HTTPS", "Unknown"],
  ["Gitter", "Chat for Developers", "https://developer.gitter.im/docs/welcome","OAuth", "HTTPS", "Unknown"],
  ["Glitterly", "Image generation API","https://glitterly.app/", "apiKey", "HTTPS", "CORS"],
  ["Google Docs", "API to read, write, and format Google Docs documents", "https://developers.google.com/docs/api/reference/rest","OAuth", "HTTPS", "Unknown"],
  ["Google Firebase", "Google's mobile application development platform that helps build, improve, and grow app", "https://firebase.google.com/docs","apiKey", "HTTPS", "CORS"],
  ["Google Fonts", "Metadata for all families served by Google Fonts","https://developers.google.com/fonts/docs/developer_api", "apiKey", "HTTPS", "Unknown"],
  ["Google Keep", "API to read, write, and format Google Keep notes", "https://developers.google.com/keep/api/reference/rest","OAuth", "HTTPS", "Unknown"],
  ["Google Sheets", "API to read, write, and format Google Sheets data", "https://developers.google.com/sheets/api/reference/rest","OAuth", "HTTPS", "Unknown"],
  ["Google Slides", "API to read, write, and format Google Slides presentations", "https://developers.google.com/slides/api/reference/rest","OAuth", "HTTPS", "Unknown"],
  ["Gorest", "Online REST API for Testing and Prototyping", "https://gorest.co.in/","OAuth", "HTTPS", "Unknown"],
  ["Hasura", "GraphQL and REST API Engine with built in Authorization", "https://hasura.io/opensource/","apiKey", "HTTPS", "CORS"],
  ["Heroku", "REST API to programmatically create apps, provision add-ons and perform other task on Heroku", "https://devcenter.heroku.com/articles/platform-api-reference","OAuth", "HTTPS", "CORS"],
  ["host-t.com", "Basic DNS query via HTTP GET request","https://host-t.com/", "", "HTTPS", ""],
  ["Host.io", "Domains Data API for Developers", "https://host.io/","apiKey", "HTTPS", "CORS"],
  ["HTTP2.Pro", "Test endpoints for client and server HTTP/2 protocol support","https://http2.pro/doc/api", "", "HTTPS", "Unknown"],
  ["Httpbin", "A Simple HTTP Request & Response Service","https://httpbin.org/", "", "HTTPS", "CORS"],
  ["Httpbin Cloudflare", "A Simple HTTP Request & Response Service with HTTP/3 Support by Cloudflare","https://cloudflare-quic.com/b/", "", "HTTPS", "CORS"],
  ["Hunter", "API for domain search, professional email finder, author finder and email verifier","https://cloudflare-quic.com/b/", "apiKey", "HTTPS", "Unknown"],
  ["IBM Text to Speech", "Convert text to speech", "https://cloud.ibm.com/docs/text-to-speech/getting-started.html","apiKey", "HTTPS", "CORS"],
  ["Icanhazepoch", "Get Epoch time", "https://major.io/p/extra-icanhaz-services-going-offline/","", "HTTPS", "CORS"],
  ["Icanhazip", "IP Address API","https://major.io/icanhazip-com-faq/", "", "HTTPS", "CORS"],
  ["IFTTT", "IFTTT Connect API","https://ifttt.com/docs/connect_api", "", "HTTPS", "Unknown"],
  ["Image-Charts", "Generate charts, QR codes and graph images","https://documentation.image-charts.com/", "", "HTTPS", "CORS"],
  ["import.io", "Retrieve structured data from a website or RSS feed", "https://api.docs.import.io/","apiKey", "HTTPS", "Unknown"],
  ["ip-fast.com", "IP address, country and city","https://ip-fast.com/docs/", "", "HTTPS", "CORS"],
  ["IP2WHOIS Information Lookup", "WHOIS domain name lookup", "https://www.ip2whois.com/","apiKey", "HTTPS", "Unknown"],
  ["ipfind.io", "Geographic location of an IP address or any domain name along with some other useful information","https://ipfind.io/", "apiKey", "HTTPS", "CORS"],
  ["IPify", "A simple IP Address API", "https://www.ipify.org/","", "HTTPS", "Unknown"],
  ["IPinfo", "Another simple IP Address API", "https://ipinfo.io/developers","", "HTTPS", "Unknown"],
  ["jsDelivr", "Package info and download stats on jsDelivr CDN", "https://github.com/jsdelivr/data.jsdelivr.com","", "HTTPS", "CORS"],
  ["JSON 2 JSONP", "Convert JSON to JSONP (on-the-fly) for easy cross-domain data requests using client-side JavaScript", "https://json2jsonp.com/","", "HTTPS", "Unknown"],
  ["JSONbin.io", "Free JSON storage service. Ideal for small scale Web apps, Websites and Mobile apps", "https://jsonbin.io/","apiKey", "HTTPS", "CORS"],
  ["Kroki", "Creates diagrams from textual descriptions", "https://kroki.io/","", "HTTPS", "CORS"],
  ["License-API", "Unofficial REST API for choosealicense.com","https://github.com/cmccandless/license-api/blob/master/README.md", "", "HTTPS", ""],
  ["Logs.to", "Generate logs", "https://logs.to/","apiKey", "HTTPS", "Unknown"],
  ["Lua Decompiler", "Online Lua 5.1 Decompiler","https://lua-decompiler.ferib.dev/", "", "HTTPS", "CORS"],
  ["MAC address vendor lookup", "Retrieve vendor details and other information regarding a given MAC address or an OUI","https://mac-address.alldatafeeds.com/mac-address-api", "apiKey", "HTTPS", "CORS"],
  ["Micro DB", "Simple database service","https://m3o.com/db", "apiKey", "HTTPS", "Unknown"],
  ["MicroENV", "Fake Rest API for developers", "https://microenv.com/","", "HTTPS", "Unknown"],
  ["Mocky", "Mock user defined test JSON for REST API endpoints", "https://designer.mocky.io/","", "HTTPS", "CORS"],
  ["MY IP", "Get IP address information","https://www.myip.com/api-docs/", "", "HTTPS", "Unknown"],
  ["Nationalize.io", "Estimate the nationality of a first name","https://nationalize.io/", "", "HTTPS", "CORS"],
  ["Netlify", "Netlify is a hosting service for the programmable web","https://docs.netlify.com/api/get-started/", "OAuth", "HTTPS", "Unknown"],
  ["NetworkCalc", "Network calculators, including subnets, DNS, binary, and security tools","https://networkcalc.com/api/docs", "", "HTTPS", "CORS"],
  ["npm Registry", "Query information about your favorite Node.js libraries programatically", "https://github.com/npm/registry/blob/master/docs/REGISTRY-API.md","", "HTTPS", "Unknown"],
  ["OneSignal", "Self-serve customer engagement solution for Push Notifications, Email, SMS & In-App","https://documentation.onesignal.com/docs/onesignal-api", "apiKey", "HTTPS", "Unknown"],
  ["Open Page Rank", "API for calculating and comparing metrics of different websites using Page Rank algorithm","https://www.domcop.com/openpagerank/", "apiKey", "HTTPS", "Unknown"],
  ["OpenAPIHub", "The All-in-one API Platform", "X-Mashape-Key","https://hub.openapihub.com/en-us/", "HTTPS", "Unknown"],
  ["OpenGraphr", "Really simple API to retrieve Open Graph data from an URL", "https://opengraphr.com/docs/1.0/overview","apiKey", "HTTPS", "Unknown"],
  ["oyyi", "API for Fake Data, image/video conversion, optimization, pdf optimization and thumbnail generation","https://oyyi.xyz/docs/1.0", "", "HTTPS", "CORS"],
  ["PageCDN", "Public API for javascript, css and font libraries on PageCDN", "https://pagecdn.com/docs/public-api","apiKey", "HTTPS", "CORS"],
  ["Postman", "Tool for testing APIs","https://www.postman.com/postman/workspace/postman-public-workspace/documentation/12959542-c8142d51-e97c-46b6-bd77-52bb66712c9a", "apiKey", "HTTPS", "Unknown"],
  ["ProxyCrawl", "Scraping and crawling anticaptcha service","https://crawlbase.com/", "apiKey","HTTPS", "Unknown"],
  ["ProxyKingdom", "Rotating Proxy API that produces a working proxy on every request", "https://proxykingdom.com/","apiKey", "HTTPS", "CORS"],
  ["Pusher Beams", "Push notifications for Android & iOS", "https://pusher.com/beams/","apiKey", "HTTPS", "Unknown"],
  ["QR code", "Create an easy to read QR code and URL shortener", "https://www.qrtag.net/api/","", "HTTPS", "CORS"],
  ["QR code", "Generate and decode / read QR code graphics", "https://goqr.me/api/","", "HTTPS", "Unknown"],
  ["Qrcode Monkey", "Integrate custom and unique looking QR codes into your system or workflow","https://www.qrcode-monkey.com/qr-code-api-with-logo/", "", "HTTPS", "Unknown"],
  ["QuickChart", "Generate chart and graph images","https://quickchart.io/", "No", "HTTPS", "CORS"],
  ["Random Stuff", "Can be used to get AI Response, jokes, memes, and much more at lightning-fast speed", "https://api-docs.pgamerx.com/","apiKey", "HTTPS", "CORS"],
  ["Rejax", "Reverse AJAX service to notify clients","https://rejax.io/", "apiKey", "HTTPS", ""],
  ["ReqRes", "A hosted REST-API ready to respond to your AJAX requests","https://reqres.in/", "", "HTTPS", "Unknown"],
  ["RSS feed to JSON", "Returns RSS feed in JSON format using feed URL","https://rss-to-json-serverless-api.vercel.app/", "", "HTTPS", "CORS"],
  ["SavePage.io", "A free, RESTful API used to screenshot any desktop, or mobile website", "https://www.savepage.io/","apiKey", "HTTPS", "CORS"],
  ["ScrapeNinja", "Scraping API with Chrome fingerprint and residential proxies","https://scrapeninja.net/", "apiKey", "HTTPS", "Unknown"],
  ["ScraperApi", "Easily build scalable web scrapers", "https://www.scraperapi.com/","apiKey", "HTTPS", "Unknown"],
  ["scraperBox", "Undetectable web scraping API", "https://scraperbox.com/","apiKey", "HTTPS", "CORS"],
  ["scrapestack", "Real-time, Scalable Proxy & Web Scraping REST API", "https://scrapestack.com/","apiKey", "HTTPS", "Unknown"],
  ["ScrapingAnt", "Headless Chrome scraping with a simple API","https://scrapingant.com/", "apiKey", "HTTPS", "Unknown"],
  ["ScrapingDog", "Proxy API for Web scraping", "https://www.scrapingdog.com/","apiKey", "HTTPS", "Unknown"],
  ["ScreenshotAPI.net", "Create pixel-perfect website screenshots","https://www.screenshotapi.net/", "apiKey", "HTTPS", "CORS"],
  ["Serialif Color", "Color conversion, complementary, grayscale and contrasted text","https://color.serialif.com/", "", "HTTPS", ""],
  ["serpstack", "Real-Time & Accurate Google Search Results API","https://serpstack.com/", "apiKey", "HTTPS", "CORS"],
  ["Sheetsu", "Easy google sheets integration", "https://sheetsu.com/","apiKey", "HTTPS", "Unknown"],
  ["SHOUTCLOUD", "ALL-CAPS AS A SERVICE","http://shoutcloud.io/", "", "", "Unknown"],
  ["Sonar", "Project Sonar DNS Enumeration API","https://github.com/Cgboal/SonarSearch", "", "HTTPS", "CORS"],
  ["SonarQube", "SonarQube REST APIs to detect bugs, code smells & security vulnerabilities", "https://sonarcloud.io/web_api","OAuth", "HTTPS", "Unknown"],
  ["StackExchange", "Q&A forum for developers", "https://api.stackexchange.com/","OAuth", "HTTPS", "Unknown"],
  ["Statically", "A free CDN for developers", "https://statically.io/","", "HTTPS", "CORS"],
  ["Supportivekoala", "Autogenerate images with template", "https://developers.supportivekoala.com/","apiKey", "HTTPS", "CORS"],
  ["Tyk", "Api and service management platform", "https://tyk.io/open-source/","apiKey", "HTTPS", "CORS"],
  ["Wandbox", "Code compiler supporting 35+ languages mentioned at wandbox.org", "https://github.com/melpon/wandbox/blob/master/kennel2/API.rst","", "HTTPS", "Unknown"],
  ["WebScraping.AI", "Web Scraping API with built-in proxies and JS rendering","https://webscraping.ai/", "apiKey", "HTTPS", "CORS"],
  ["ZenRows", "Web Scraping API that bypasses anti-bot solutions while offering JS rendering, and rotating proxies", "https://www.zenrows.com/","apiKey", "HTTPS", "Unknown"],
];


  final List<List<String>> data_17 = [
    ["Chinese Character Web", "Chinese character definitions and pronunciations", " http://ccdb.hemiola.com/" ,"", "", ""],
    ["Chinese Text Project", "Online open-access digital library for pre-modern Chinese texts", " https://ctext.org/tools/api" ,"", "HTTPS", "Unknown"],
    ["Collins", "Bilingual Dictionary and Thesaurus Data", "https://api.collinsdictionary.com/api/v1/documentation/html/" ,"apiKey", "HTTPS", "Unknown"],
    ["Free Dictionary", "Definitions, phonetics, pronunciations, parts of speech, examples, synonyms","https://dictionaryapi.dev/" , "", "HTTPS", "Unknown"],
    ["Indonesia Dictionary", "Indonesia dictionary many words","https://new-kbbi-api.herokuapp.com/" , "", "HTTPS", "Unknown"],
    ["Lingua Robot", "Word definitions, pronunciations, synonyms, antonyms and others", "https://www.linguarobot.io/" ,"apiKey", "HTTPS", "CORS"],
    ["Merriam-Webster", "Dictionary and Thesaurus Data", "https://dictionaryapi.com/" ,"apiKey", "HTTPS", "Unknown"],
    ["OwlBot", "Definitions with example sentence and photo if available", "https://owlbot.info/" ,"apiKey", "HTTPS", "CORS"],
    ["Oxford", "Dictionary Data", "https://developer.oxforddictionaries.com/" ,"apiKey", "HTTPS", ""],
    ["Synonyms", "Synonyms, thesaurus and antonyms information for any given word","https://www.synonyms.com/synonyms_api.php" , "apiKey", "HTTPS", "Unknown"],
    ["Wiktionary", "Collaborative dictionary data", "https://en.wiktionary.org/w/api.php" ,"", "HTTPS", "CORS"],
    ["Wordnik", "Dictionary Data", "https://developer.wordnik.com/" ,"apiKey", "HTTPS", "Unknown"],
    ["Words", "Definitions and synonyms for more than 150,000 words","https://www.wordsapi.com/docs/" , "apiKey", "HTTPS", "Unknown"]

    ];


  final List<List<String>> data_18 = [
    ["Airtable", "Integrate with Airtable", "https://airtable.com/developers/web/api/introduction","apiKey", "HTTPS", "Unknown"],
    ["Api2Convert", "Online File Conversion API","https://www.api2convert.com/", "apiKey", "HTTPS", "Unknown"],
    ["apilayer pdflayer", "HTML/URL to PDF", "https://pdflayer.com/","apiKey", "HTTPS", "Unknown"],
    ["Asana", "Programmatic access to all data in your Asana system","https://developers.asana.com/docs", "apiKey", "HTTPS", "CORS"],
    ["ClickUp", "ClickUp is a robust, cloud-based project management tool for boosting productivity", "https://clickup.com/api/","OAuth", "HTTPS", "Unknown"],
    ["Clockify", "Clockify's REST-based API can be used to push/pull data to/from it & integrate it with other systems","https://docs.clockify.me/", "apiKey", "HTTPS", "Unknown"],
    ["CloudConvert", "Online file converter for audio, video, document, ebook, archive, image, spreadsheet, presentation", "https://cloudconvert.com/api/v2","apiKey", "HTTPS", "Unknown"],
    ["Cloudmersive Document and Data Conversion", "HTML/URL to PDF/PNG, Office documents to PDF, image conversion", "https://cloudmersive.com/convert-api","apiKey", "HTTPS", "CORS"],
    ["Code::Stats", "Automatic time tracking for programmers", "https://codestats.net/api-docs","apiKey", "HTTPS", ""],
    ["CraftMyPDF", "Generate PDF documents from templates with a drop-and-drop editor and a simple API","https://craftmypdf.com/", "apiKey", "HTTPS", ""],
    ["Flowdash", "Automate business workflows", "https://docs.flowdash.com/docs/api","apiKey", "HTTPS", "Unknown"],
    ["Html2PDF", "HTML/URL to PDF", "https://html2pdf.app/","apiKey", "HTTPS", "Unknown"],
    ["iLovePDF", "Convert, merge, split, extract text and add page numbers for PDFs. Free for 250 documents/month", "https://developer.ilovepdf.com/","apiKey", "HTTPS", "CORS"],
    ["JIRA", "JIRA is a proprietary issue tracking product that allows bug tracking and agile project management","https://developer.atlassian.com/server/jira/platform/rest-apis/", "OAuth", "HTTPS", "Unknown"],
    ["Mattermost", "An open source platform for developer collaboration","https://api.mattermost.com/", "OAuth", "HTTPS", "Unknown"],
    ["Mercury", "Web parser","https://reader.postlight.com/web-parser/", "apiKey", "HTTPS", "Unknown"],
    ["Monday", "Programmatically access and update data inside a monday.com account","https://api.developer.monday.com/docs", "apiKey", "HTTPS", "Unknown"],
    ["Notion", "Integrate with Notion", "https://developers.notion.com/docs/getting-started","OAuth", "HTTPS", "Unknown"],
    ["PandaDoc", "DocGen and eSignatures API", "https://developers.pandadoc.com/","apiKey", "HTTPS", ""],
    ["Pocket", "Bookmarking service", "https://getpocket.com/developer/","OAuth", "HTTPS", "Unknown"],
    ["Podio", "File sharing and productivity","https://developers.podio.com/", "OAuth", "HTTPS", "Unknown"],
    ["PrexView", "Data from XML or JSON to PDF, HTML or Image","https://prexview.com/", "apiKey", "HTTPS", "Unknown"],
    ["Restpack", "Provides screenshot, HTML to PDF and content extraction APIs", "https://restpack.io/","apiKey", "HTTPS", "Unknown"],
    ["Todoist", "Todo Lists", "https://developer.todoist.com/guides/#developing-with-todoist","OAuth", "HTTPS", "Unknown"],
    ["Smart Image Enhancement API", "Performs image upscaling by adding detail to images through multiple super-resolution algorithms","https://apilayer.com/", "apiKey", "HTTPS", "Unknown"],
    ["Vector Express v2.0", "Free vector file converting API","https://vector.express/", "", "HTTPS", ""],
    ["WakaTime", "Automated time tracking leaderboards for programmers", "https://wakatime.com/developers","No", "HTTPS", "Unknown"],
    ["Zube", "Full stack project management","https://zube.io/docs/api", "OAuth", "HTTPS", "Unknown"]

  ];


  final List<List<String>> data_19 = [

  ["Abstract Email Validation", "Validate email addresses for deliverability and spam","https://www.abstractapi.com/api/email-verification-validation-api", "apiKey", "HTTPS", "CORS"],
  ["apilayer mailboxlayer", "Email address validation","https://mailboxlayer.com/", "apiKey", "HTTPS", "Unknown"],
  ["Cloudmersive Validate", "Validate email addresses, phone numbers, VAT numbers and domain names","https://cloudmersive.com/validate-api", "apiKey", "HTTPS", "CORS"],
  ["Disify", "Validate and detect disposable and temporary email addresses", "https://www.disify.com/","", "HTTPS", "CORS"],
  ["DropMail", "GraphQL API for creating and managing ephemeral e-mail inboxes", "https://dropmail.me/api/#live-demo","", "HTTPS", "Unknown"],
  ["EVA", "Validate email addresses", "https://eva.pingutil.com/","", "HTTPS", "CORS"],
  ["Guerrilla Mail", "Disposable temporary Email addresses","https://www.guerrillamail.com/GuerrillaMailAPI.html", "", "HTTPS", "Unknown"],
  ["ImprovMX", "API for free email forwarding service", "https://improvmx.com/api/","apiKey", "HTTPS", "Unknown"],
  ["Kickbox", "Email verification API", "https://open.kickbox.com/","", "HTTPS", "CORS"],
  ["mail.gw", "10 Minute Mail", "https://docs.mail.gw/","", "HTTPS", "CORS"],
  ["mail.tm", "Temporary Email Service", "https://docs.mail.tm/","", "HTTPS", "CORS"],
  ["MailboxValidator", "Validate email address to improve deliverability","https://www.mailboxvalidator.com/api-email-free", "apiKey", "HTTPS", "Unknown"],
  ["MailCheck.ai", "Prevent users from signing up with temporary email addresses","https://www.mailcheck.ai/#documentation","", "HTTPS", "Unknown"],
  ["Mailtrap", "A service for the safe testing of emails sent from the development and staging environments","https://mailtrap.docs.apiary.io/#", "apiKey", "HTTPS", "Unknown"],
  ["Sendgrid", "A cloud-based SMTP provider that allows you to send emails without having to maintain email servers","https://docs.sendgrid.com/api-reference/how-to-use-the-sendgrid-v3-api/authentication", "apiKey", "HTTPS", "Unknown"],
  ["Sendinblue", "A service that provides solutions relating to marketing and/or transactional email and/or SMS", "https://developers.brevo.com/docs","apiKey", "HTTPS", "Unknown"],
  ["Verifier", "Verifies that a given email is real","https://verifier.meetchopra.com/docs#/", "apiKey", "HTTPS", "CORS"]

  ];


  final List<List<String>> data_20 = [

  ["chucknorris.io", "JSON API for hand-curated Chuck Norris jokes", "https://api.chucknorris.io/","", "HTTPS", "Unknown"],
  ["Corporate Buzz Words", "REST API for Corporate Buzz Words", "https://github.com/sameerkumar18/corporate-bs-generator-api","", "HTTPS", "CORS"],
  ["Excuser", "Get random excuses for various situations","https://excuser.herokuapp.com/", "", "HTTPS", "Unknown"],
  ["Fun Fact", "A simple HTTPS API that can randomly select and return a fact from the FFA database","https://api.aakhilv.me/", "", "HTTPS", "CORS"],
  ["Imgflip", "Gets an array of popular memes", "https://imgflip.com/api","", "HTTPS", "Unknown"],
  ["Meme Maker", "REST API for creating your own meme", "https://mememaker.github.io/API/","", "HTTPS", "Unknown"],
  ["NaMoMemes", "Memes on Narendra Modi","https://github.com/theIYD/NaMoMemes", "", "HTTPS", "Unknown"],
  ["Random Useless Facts", "Get useless, but true facts", "https://uselessfacts.jsph.pl/","", "HTTPS", "Unknown"],
  ["Techy", "JSON and Plaintext API for tech-savvy sounding phrases", "https://techy-api.vercel.app/","", "HTTPS", "Unknown"],
  ["Yo Momma Jokes", "REST API for Yo Momma Jokes", "https://github.com/beanboi7/yomomma-apiv2","", "HTTPS", "Unknown"]

  ];

  final List<List<String>> data_21 = [

    ["BreezoMeter Pollen", "Daily Forecast pollen conditions data for a specific location","https://docs.breezometer.com/api-documentation/pollen-api/v2/", "apiKey", "HTTPS", "Unknown"],
    ["Carbon Interface", "API to calculate carbon (CO2) emissions estimates for common CO2 emitting activities","https://docs.carboninterface.com/#/", "apiKey", "HTTPS", "CORS"],
    ["Climatiq", "Calculate the environmental footprint created by a broad range of emission-generating activities","https://www.climatiq.io/docs", "apiKey", "HTTPS", "CORS"],
    ["Cloverly", "API calculates the impact of common carbon-intensive activities in real-time","https://www.cloverly.com/carbon-offset-documentation", "apiKey", "HTTPS", "Unknown"],
    ["CO2 Offset", "API calculates and validates the carbon footprint","https://corrently.io/books/susscope2-framework-fur-co2-emissionen-strombezug", "", "HTTPS", "Unknown"],
    ["Danish data service Energi", "Open energy data from Energinet to society", "https://www.energidataservice.dk/","", "HTTPS", "Unknown"],
    ["GrünstromIndex", "Green Power Index for Germany (Grünstromindex/GSI)", "https://gruenstromindex.de/","", "", "CORS"],
    ["IQAir", "Air quality and weather data", "https://www.iqair.com/air-pollution-data-api","apiKey", "HTTPS", "Unknown"],
    ["Luchtmeetnet", "Predicted and actual air quality components for The Netherlands (RIVM)", "https://api-docs.luchtmeetnet.nl/","", "HTTPS", "Unknown"],
    ["National Grid ESO", "Open data from Great Britain’s Electricity System Operator","https://data.nationalgrideso.com/", "", "HTTPS", "Unknown"],
    ["OpenAQ", "Open air quality data","https://docs.openaq.org/docs", "apiKey", "HTTPS", "Unknown"],
    ["PM2.5 Open Data Portal", "Open low-cost PM2.5 sensor data", "https://pm25.lass-net.org/#apis","", "HTTPS", "Unknown"],
    ["PM25.in", "Air quality of China", "http://www.pm25.in/api_doc","apiKey", "", "Unknown"],
    ["PVWatts", "Energy production photovoltaic (PV) energy systems", "https://developer.nrel.gov/docs/solar/pvwatts/v6/","apiKey", "HTTPS", "Unknown"],
    ["Srp Energy", "Hourly usage energy report for SRP customers", "https://srpenergy-api-client-python.readthedocs.io/en/latest/api.html","apiKey", "HTTPS", ""],
    ["UK Carbon Intensity", "The Official Carbon Intensity API for Great Britain developed by National Grid", "https://carbon-intensity.github.io/api-definitions/#carbon-intensity-api-v2-0-0","", "HTTPS", "Unknown"],
    ["Website Carbon", "API to estimate the carbon footprint of loading web pages", "https://api.websitecarbon.com/","", "HTTPS", "Unknown"]

  ];

  final List<List<String>> data_22 = [

  ["Eventbrite", "Find events", "https://www.eventbrite.com/platform/api/","OAuth", "HTTPS", "Unknown"],
  ["SeatGeek", "Search events, venues, and performers", "https://platform.seatgeek.com/","apiKey", "HTTPS", "Unknown"],
  ["Ticketmaster", "Search events, attractions, or venues", "https://developer.ticketmaster.com/products-and-docs/apis/getting-started/","apiKey", "HTTPS", "Unknown"]

  ];

  final List<List<String>> data_23 = [

    ["Abstract VAT Validation", "Validate VAT numbers and calculate VAT rates", "https://www.abstractapi.com/api/vat-validation-rates-api","apiKey", "HTTPS", "CORS"],
    ["Aletheia", "Insider trading data, earnings call analysis, financial statements, and more", "https://aletheiaapi.com/","apiKey", "HTTPS", "CORS"],
    ["Alpaca", "Realtime and historical market data on all US equities and ETFs", "https://alpaca.markets/docs/api-references/market-data-api/","apiKey", "HTTPS", "CORS"],
    ["Alpha Vantage", "Realtime and historical stock data","https://www.alphavantage.co/", "apiKey", "HTTPS", "Unknown"],
    ["apilayer marketstack", "Real-Time, Intraday & Historical Market Data API", "https://marketstack.com/","apiKey", "HTTPS", "Unknown"],
    ["Banco do Brasil", "All Banco do Brasil financial transaction APIs", "OAuth", "https://marketstack.com/","HTTPS", "CORS"],
    ["Bank Data API", "Instant IBAN and SWIFT number validation across the globe", "https://apilayer.com/marketplace/bank_data-api","apiKey", "HTTPS", "Unknown"],
    ["Billplz", "Payment platform","https://www.billplz.com/api#introduction", "apiKey", "HTTPS", "Unknown"],
    ["Binlist", "Public access to a database of IIN/BIN information", "https://binlist.net/","", "HTTPS", "Unknown"],
    ["Boleto.Cloud", "An API to generate boletos in Brazil","https://boleto.cloud/", "apiKey", "HTTPS", "Unknown"],
    ["Citi", "All Citigroup account and statement data APIs", "https://sandbox.developerhub.citi.com/api-catalog-list","apiKey", "HTTPS", "Unknown"],
    ["Econdb", "Global macroeconomic data","https://www.econdb.com/api/series/?page=1", "", "HTTPS", "CORS"],
    ["Fed Treasury", "U.S. Department of the Treasury Data", "https://fiscaldata.treasury.gov/api-documentation/","", "HTTPS", "Unknown"],
    ["Finage", "A stock, currency, cryptocurrency, indices, and ETFs real-time & historical data provider", "https://finage.co.uk/","apiKey", "HTTPS", "Unknown"],
    ["Financial Modeling Prep", "Realtime and historical stock data","https://site.financialmodelingprep.com/developer/docs/", "apiKey", "HTTPS", "Unknown"],
    ["Finnhub", "Real-Time RESTful APIs and Websocket for Stocks, Currencies, and Crypto", "https://finnhub.io/docs/api","apiKey", "HTTPS", "Unknown"],
    ["FRED", "Economic data from the Federal Reserve Bank of St. Louis", "https://fred.stlouisfed.org/docs/api/fred/","apiKey", "HTTPS", "CORS"],
    ["Front Accounting APIs", "Front accounting is multilingual and multicurrency software for small businesses","https://frontaccounting.com/fawiki/index.php?n=Devel.SimpleAPIModule", "OAuth", "HTTPS", "CORS"],
    ["Hotstoks", "Stock market data powered by SQL", "https://hotstoks.com/?utm_source=public-apis","apiKey", "HTTPS", "CORS"],
    ["IEX Cloud", "Realtime & Historical Stock and Market Data","https://iexcloud.io/docs/api/", "apiKey", "HTTPS", "CORS"],
    ["IG", "Spreadbetting and CFD Market Data", "https://labs.ig.com/gettingstarted","apiKey", "Yes", "Unknown"],
    ["Indian Mutual Fund", "Get complete history of India Mutual Funds Data", "https://www.mfapi.in/","", "HTTPS", "Unknown"],
    ["Intrinio", "A wide selection of financial data feeds","https://intrinio.com/", "apiKey", "HTTPS", "Unknown"],
    ["Klarna", "Klarna payment and shopping service","https://docs.klarna.com/api/payments/", "apiKey", "HTTPS", "Unknown"],
    ["MercadoPago", "Mercado Pago API reference - all the information you need to develop your integrations", "https://www.mercadopago.com.br/developers/es/reference","apiKey", "HTTPS", "Unknown"],
    ["Mono", "Connect with users’ bank accounts and access transaction data in Africa", "https://mono.co/","apiKey", "HTTPS", "Unknown"],
    ["Moov", "The Moov API makes it simple for platforms to send, receive, and store money", "https://docs.moov.io/api/","apiKey", "HTTPS", "Unknown"],
    ["Nordigen", "Connect to bank accounts using official bank APIs and get raw transaction data", "https://gocardless.com/bank-account-data/","apiKey", "HTTPS", "Unknown"],
    ["OpenFIGI", "Equity, index, futures, options symbology from Bloomberg LP","https://www.openfigi.com/api", "apiKey", "HTTPS", "CORS"],
    ["Plaid", "Connect with user's bank accounts and access transaction data","https://plaid.com/", "apiKey", "HTTPS", "Unknown"],
    ["Polygon", "Historical stock market data", "https://polygon.io/","apiKey", "HTTPS", "Unknown"],
    ["Portfolio Optimizer", "Portfolio analysis and optimization", "https://portfoliooptimizer.io/","", "HTTPS", "CORS"],
    ["Razorpay IFSC", "Indian Financial Systems Code (Bank Branch Codes)", "https://razorpay.com/docs/#home-payments","", "HTTPS", "Unknown"],
    ["Real Time Finance", "Websocket API to access realtime stock data", "https://github.com/Real-time-finance/finance-websocket-API/","apiKey", "", "Unknown"],
    ["SEC EDGAR Data", "API to access annual reports of public US companies", "https://www.sec.gov/edgar/sec-api-documentation","", "HTTPS", "CORS"],
    ["SmartAPI", "Gain access to set of and create end-to-end broking services", "https://smartapi.angelbroking.com/","apiKey", "HTTPS", "Unknown"],
    ["StockData", "Real-Time, Intraday & Historical Market Data, News, and Sentiment API", "https://www.stockdata.org/","apiKey", "HTTPS", "CORS"],
    ["Styvio", "Realtime and historical stock data and current stock sentiment", "https://www.styvio.com/","apiKey", "HTTPS", "Unknown"],
    ["Tax Data API", "Instant VAT number and tax validation across the globe", "https://apilayer.com/marketplace/tax_data-api","apiKey", "HTTPS", "Unkown"],
    ["Tradier", "US equity/option market data (delayed, intraday, historical)","https://developer.tradier.com/", "OAuth", "HTTPS", "CORS"],
    ["Twelve Data", "Stock market data (real-time & historical)", "https://twelvedata.com/","apiKey", "HTTPS", "Unknown"],
    ["WallstreetBets", "WallstreetBets Stock Comments Sentiment Analysis","https://tradestie.com/apps/reddit/api/", "", "HTTPS", "Unknown"],
    ["Yahoo Finance", "Real-time low latency Yahoo Finance API for stock market, cryptocurrencies, and currency exchange", "https://www.yahoofinanceapi.com/","apiKey", "HTTPS", "CORS"],
    ["YNAB", "Budgeting & Planning","https://api.ynab.com/", "OAuth", "HTTPS", "CORS"],
    ["Zoho Books", "Online accounting software, built for your business","https://www.zoho.com/books/api/v3/introduction/#organization-id", "OAuth", "HTTPS", "Unknown"]

  ];

  final List<List<String>> data_24 = [

    ["BaconMockup", "Resizable bacon placeholder images","https://baconmockup.com/", "", "HTTPS", "CORS"],
    ["Chomp", "Data about various grocery products and foods","https://chompthis.com/api/", "apiKey", "HTTPS", "Unknown"],
    ["Coffee", "Random pictures of coffee", "https://coffee.alexflipnote.dev/","", "HTTPS", "Unknown"],
    ["Edamam nutrition", "Nutrition Analysis", "https://developer.edamam.com/edamam-docs-nutrition-api","apiKey", "HTTPS", "Unknown"],
    ["Edamam recipes", "Recipe Search", "https://developer.edamam.com/edamam-docs-recipe-api","apiKey", "HTTPS", "Unknown"],
    ["Foodish", "Random pictures of food dishes", "https://github.com/surhud004/Foodish#readme","", "HTTPS", "CORS"],
    ["Fruityvice", "Data about all kinds of fruit","https://www.fruityvice.com/", "", "HTTPS", "Unknown"],
    ["Kroger", "Supermarket Data", "https://developer.kroger.com/reference/","apiKey", "HTTPS", "Unknown"],
    ["LCBO", "Alcohol", "https://github.com/heycarsten/lcbo-api","apiKey", "HTTPS", "Unknown"],
    ["Open Brewery DB", "Breweries, Cideries and Craft Beer Bottle Shops","https://www.openbrewerydb.org/", "", "HTTPS", "CORS"],
    ["Open Food Facts", "Food Products Database","https://world.openfoodfacts.org/data", "", "HTTPS", "Unknown"],
    ["PunkAPI", "Brewdog Beer Recipes", "https://punkapi.com/","", "HTTPS", "Unknown"],
    ["Rustybeer", "Beer brewing tools", "https://rustybeer.herokuapp.com/","", "HTTPS", ""],
    ["Spoonacular", "Recipes, Food Products, and Meal Planning","https://spoonacular.com/food-api", "apiKey", "HTTPS", "Unknown"],
    ["Systembolaget", "Government-owned liquor store in Sweden", "https://api-portal.systembolaget.se/","apiKey", "HTTPS", "Unknown"],
    ["TacoFancy", "Community-driven taco database", "https://github.com/evz/tacofancy-api","", "", "Unknown"],
    ["Tasty", "API to query data about recipe, plan, ingredients", "https://rapidapi.com/apidojo/api/tasty/","apiKey", "HTTPS", "Unknown"],
    ["The Report of the Week", "Food & Drink Reviews", "https://github.com/andyklimczak/TheReportOfTheWeek-API","", "HTTPS", "Unknown"],
    ["TheCocktailDB", "Cocktail Recipes", "https://www.thecocktaildb.com/api.php","apiKey", "HTTPS", "CORS"],
    ["TheMealDB", "Meal Recipes","https://www.themealdb.com/api.php", "apiKey", "HTTPS", "CORS"],
    ["Untappd", "Social beer sharing", "https://untappd.com/api/docs","OAuth", "HTTPS", "Unknown"],
    ["What's on the menu?", "NYPL human-transcribed historical menu collection", "http://nypl.github.io/menus-api/","apiKey", "", "Unknown"],
    ["WhiskyHunter", "Past online whisky auctions statistical data","https://whiskyhunter.net/api/", "", "HTTPS", "Unknown"],
    ["Zestful", "Parse recipe ingredients", "https://zestfuldata.com/","apiKey", "HTTPS", "CORS"]


  ];

  final List<List<String>> data_25 = [
    ["Age of Empires II", "Get information about Age of Empires II resources", "https://age-of-empires-2-api.herokuapp.com/", "", "HTTPS", ""],
    ["AmiiboAPI", "Nintendo Amiibo Information", "https://amiiboapi.com/", "", "HTTPS", "CORS"],
    ["Animal Crossing: New Horizons", "API for critters, fossils, art, music, furniture and villagers", "https://acnhapi.com/", "", "HTTPS", "Unknown"],
    ["Autochess VNG", "Rest API for Autochess VNG",  "https://github.com/didadadida93/autochess-vng-api","", "HTTPS", "CORS"],
    ["Barter.VG", "Provides information about Game, DLC, Bundles, Giveaways, Trading",  "https://github.com/bartervg/barter.vg/wiki","", "HTTPS", "CORS"],
    ["Battle.net", "Diablo III, Hearthstone, StarCraft II and World of Warcraft game data APIs", "https://develop.battle.net/documentation/guides/getting-started", "OAuth", "HTTPS", "CORS"],
    ["Board Game Geek", "Board games, RPG and videogames", "https://boardgamegeek.com/wiki/page/BGG_XML_API2", "", "HTTPS", ""],
    ["Brawl Stars", "Brawl Stars Game Information",  "https://developer.brawlstars.com/#/","apiKey", "HTTPS", "Unknown"],
    ["Bugsnax", "Get information about Bugsnax", "https://chrome.google.com/webstore/detail/world-clock-tab/chhgiolcbbpbpeacocefmkillpelcebc", "", "HTTPS", "CORS"],
    ["CheapShark", "Steam/PC Game Prices and Deals",  "https://apidocs.cheapshark.com/","", "HTTPS", "CORS"],
    ["Chess.com", "Chess.com read-only REST API",  "https://apidocs.cheapshark.com/","", "HTTPS", "Unknown"],
    ["Chuck Norris Database", "Jokes", "http://www.icndb.com/api/", "", "", "Unknown"],
    ["Clash of Clans", "Clash of Clans Game Information", "https://developer.clashofclans.com/#/", "apiKey", "HTTPS", "Unknown"],
    ["Clash Royale", "Clash Royale Game Information", "https://developer.clashroyale.com/#/", "apiKey", "HTTPS", "Unknown"],
    ["Comic Vine", "Comics",  "https://comicvine.gamespot.com/api/documentation","", "HTTPS", "Unknown"],
    ["Crafatar", "API for Minecraft skins and faces",  "https://crafatar.com/","", "HTTPS", "CORS"],
    ["Cross Universe", "Cross Universe Card Data", "https://crossuniverse.net/apiDocs/", "", "HTTPS", "CORS"],
    ["Deck of Cards", "Deck of Cards",  "https://deckofcardsapi.com/","", "", "Unknown"],
    ["Destiny The Game", "Bungie Platform API",  "https://bungie-net.github.io/multi/index.html","apiKey", "HTTPS", "Unknown"],
    ["Digimon Information", "Provides information about Digimon creatures",  "https://digimon-api.vercel.app/","", "HTTPS", "Unknown"],
    ["Digimon TCG", "Search for Digimon cards in digimoncard.io",  "https://documenter.getpostman.com/view/14059948/TzecB4fH","", "HTTPS", "Unknown"],
    ["Disney", "Information of Disney characters", "https://disneyapi.dev/", "", "HTTPS", "CORS"],
    ["Dota 2", "Provides information about Player stats, Match stats, Rankings for Dota 2",  "https://docs.opendota.com/","apiKey", "HTTPS", "Unknown"],
    ["Dungeons and Dragons", "Reference for 5th edition spells, classes, monsters, and more", "https://www.dnd5eapi.co/docs/", "", "", ""],
    ["Dungeons and Dragons (Alternate)", "Includes all monsters and spells from the SRD (System Reference Document) as well as a search API",  "https://open5e.com/","", "HTTPS", "CORS"],
    ["Eve Online", "Third-Party Developer Documentation", "https://esi.evetech.net/ui", "OAuth", "HTTPS", "Unknown"],
    ["FFXIV Collect", "Final Fantasy XIV data on collectables",  "https://ffxivcollect.com/","", "HTTPS", "CORS"],
    ["FIFA Ultimate Team", "FIFA Ultimate Team items API", "https://www.easports.com/fifa/ultimate-team/api/fut/item", "", "HTTPS", "Unknown"],
    ["Final Fantasy XIV", "Final Fantasy XIV Game data API", "https://xivapi.com/", "", "HTTPS", "CORS"],
    ["Fortnite", "Fortnite Stats", "https://fortnitetracker.com/site-api", "apiKey", "HTTPS", "Unknown"],
    ["Forza", "Show random image of a car from Forza",  "https://docs.forza-api.tk/","", "HTTPS", "Unknown"],
    ["FreeToGame", "Free-To-Play Games Database", "https://www.freetogame.com/api-doc", "", "HTTPS", "CORS"],
    ["Fun Facts", "Random Fun Facts", "https://asli-fun-fact-api.herokuapp.com/", "", "HTTPS", "CORS"],
    ["FunTranslations", "Translate Text into funny languages", "https://api.funtranslations.com/", "", "HTTPS", "CORS"],
    ["GamerPower", "Game Giveaways Tracker", "https://www.gamerpower.com/api-read", "", "HTTPS", "CORS"],
    ["GDBrowser", "Easy way to use the Geometry Dash Servers", "https://gdbrowser.com/api", "", "HTTPS", "Unknown"],
    ["Geek-Jokes", "Fetch a random geeky/programming related joke for use in all sorts of applications",  "https://github.com/sameerkumar18/geek-joke-api","", "HTTPS", "CORS"],
    ["Genshin Impact", "Genshin Impact game data", "https://genshin.dev/", "", "HTTPS", "CORS"],
    ["Giant Bomb", "Video Games",  "https://www.giantbomb.com/api/documentation/","apiKey", "HTTPS", "Unknown"],
    ["GraphQL Pokemon", "GraphQL powered Pokemon API. Supports generations 1 through 8",  "https://github.com/favware/graphql-pokemon","", "HTTPS", "CORS"],
    ["Guild Wars 2", "Guild Wars 2 Game Information",  "https://wiki.guildwars2.com/wiki/API:Main","apiKey", "HTTPS", "Unknown"],
    ["GW2Spidy", "GW2Spidy API, Items data on the Guild Wars 2 Trade Market",  "https://github.com/rubensayshi/gw2spidy/wiki","", "HTTPS", "Unknown"],
    ["Halo", "Halo 5 and Halo Wars 2 Information",  "https://developer.haloapi.com/","apiKey", "HTTPS", "Unknown"],
    ["Hearthstone", "Hearthstone Cards Information", "X-Mashape-Key",  "https://hearthstoneapi.com/" ,"","HTTPS", "Unknown"],
    ["Humble Bundle", "Humble Bundle's current bundles",  "https://rapidapi.com/Ziggoto/api/humble-bundle","apiKey", "HTTPS", "Unknown"],
    ["Humor", "Humor, Jokes, and Memes",  "https://humorapi.com/","apiKey", "HTTPS", "Unknown"],
    ["Hypixel", "Hypixel player stats",  "https://api.hypixel.net/","apiKey", "HTTPS", "Unknown"],
    ["Hyrule Compendium", "Data on all interactive items from The Legend of Zelda: BOTW",  "https://github.com/gadhagod/Hyrule-Compendium-API","", "HTTPS", "Unknown"],
    ["Hytale", "Hytale blog posts and jobs",  "https://hytale-api.com/","", "HTTPS", "Unknown"],
    ["IGDB.com", "Video Game Database",  "https://api-docs.igdb.com/#getting-started","apiKey", "HTTPS", "Unknown"],
    ["JokeAPI", "Programming, Miscellaneous and Dark Jokes", "https://sv443.net/jokeapi/v2/", "", "HTTPS", "CORS"],
    ["Jokes One", "Joke of the day and large category of jokes accessible via REST API",  "https://jokes.one/api/joke/","apiKey", "HTTPS", "CORS"],
    ["Jservice", "Jeopardy Question Database",  "http://jservice.io/","", "", "Unknown"],
    ["Lichess", "Access to all data of users, games, puzzles and etc on Lichess",  "https://lichess.org/api","OAuth", "HTTPS", "Unknown"],
    ["Magic The Gathering", "Magic The Gathering Game Information", "https://magicthegathering.io/", "", "", "Unknown"],
    ["Mario Kart Tour", "API for Drivers, Karts, Gliders and Courses",  "https://mario-kart-tour-api.herokuapp.com/","OAuth", "HTTPS", "Unknown"],
    ["Marvel", "Marvel Comics", "https://developer.marvel.com/", "apiKey", "HTTPS", "Unknown"],
    ["Minecraft Server Status", "API to get Information about a Minecraft Server", "https://api.mcsrvstat.us/", "", "HTTPS", ""],
    ["MMO Games", "MMO Games Database, News and Giveaways",  "https://www.mmobomb.com/api","", "HTTPS", ""],
    ["mod.io", "Cross Platform Mod API",  "https://docs.mod.io/#getting-started","apiKey", "HTTPS", "Unknown"],
    ["Mojang", "Mojang / Minecraft API",  "https://wiki.vg/Mojang_API","apiKey", "HTTPS", "Unknown"],
    ["Monster Hunter World", "Monster Hunter World data",  "https://docs.mhw-db.com/","", "HTTPS", "CORS"],
    ["Open Trivia", "Trivia Questions",  "https://opentdb.com/api_config.php","", "HTTPS", "Unknown"],
    ["PandaScore", "E-sports games and results",  "https://developers.pandascore.co/docs","apiKey", "HTTPS", "Unknown"],
    ["Path of Exile", "Path of Exile Game Information",  "https://www.pathofexile.com/developer/docs","OAuth", "HTTPS", "Unknown"],
    ["PlayerDB", "Query Minecraft, Steam and Xbox Accounts", "https://playerdb.co/", "", "HTTPS", "Unknown"],
    ["Pokéapi", "Pokémon Information",  "https://pokeapi.co/","", "HTTPS", "Unknown"],
    ["PokéAPI (GraphQL)", "The Unofficial GraphQL for PokeAPI",  "https://github.com/mazipan/graphql-pokeapi","", "HTTPS", "CORS"],
    ["Pokémon TCG", "Pokémon TCG Information", "https://pokemontcg.io/", "", "HTTPS", "Unknown"],
    ["Psychonauts", "Psychonauts World Characters Information and PSI Powers",  "https://pokemontcg.io/","", "HTTPS", "CORS"],
    ["PUBG", "Access in-game PUBG data",  "https://developer.pubg.com/","apiKey", "HTTPS", "CORS"],
    ["Puyo Nexus", "Puyo Puyo information from Puyo Nexus Wiki",  "https://github.com/deltadex7/puyodb-api-deno","", "HTTPS", "CORS"],
    ["quizapi.io", "Access to various kinds of quiz questions",  "https://quizapi.io/","apiKey", "HTTPS", "CORS"],
    ["Raider", "Provides detailed character and guild rankings for Raiding and Mythic+ content in World of Warcraft", "https://raider.io/api", "", "HTTPS", "Unknown"],
    ["RAWG.io", "500,000+ games for 50 platforms including mobiles",  "https://rawg.io/apidocs","apiKey", "HTTPS", "Unknown"],
    ["Rick and Morty", "All the Rick and Morty information, including images",  "https://rickandmortyapi.com/","", "HTTPS", "CORS"],
    ["Riot Games", "League of Legends Game Information", "https://developer.riotgames.com/", "apiKey", "HTTPS", "Unknown"],
    ["RPS 101", "Rock, Paper, Scissors with 101 objects",  "https://rps101.pythonanywhere.com/api","", "HTTPS", "CORS"],
    ["RuneScape", "RuneScape and OSRS RPGs information", "https://runescape.wiki/w/Application_programming_interface", "", "HTTPS", ""],
    ["Sakura CardCaptor", "Sakura CardCaptor Cards Information",  "https://github.com/JessVel/sakura-card-captor-api","", "HTTPS", "Unknown"],
    ["Scryfall", "Magic: The Gathering database",  "https://scryfall.com/docs/api","", "HTTPS", "CORS"],
    ["SpaceTradersAPI", "A playable inter-galactic space trading MMO API",  "https://spacetraders.io/?rel=pub-apis","OAuth", "HTTPS", "CORS"],
    ["Steam", "Steam Web API documentation", "https://steamapi.xpaw.me/", "apiKey", "HTTPS", ""],
    ["Steam", "Internal Steam Web API documentation", "https://github.com/Revadike/InternalSteamWebAPI/wiki", "", "HTTPS", ""],
    ["SuperHeroes", "All SuperHeroes and Villains data from all universes under a single API",  "https://superheroapi.com/","apiKey", "HTTPS", "Unknown"],
    ["TCGdex", "Multi languages Pokémon TCG Information",  "https://tcgdex.dev/","", "HTTPS", "CORS"],
    ["Tebex", "Tebex API for information about game purchases", "X-Mashape-Key",  "https://docs.tebex.io/plugin/","","HTTPS", ""],
    ["TETR.IO", "TETR.IO Tetra Channel API", "https://tetr.io/about/api/", "", "HTTPS", "Unknown"],
    ["Tronald Dump", "The dumbest things Donald Trump has ever said",  "https://www.tronalddump.io/","", "HTTPS", "Unknown"],
    ["Universalis", "Final Fantasy XIV market board data",  "https://docs.universalis.app/", "HTTPS", "CORS"],
    ["Valorant (non-official)", "An extensive API containing data of most Valorant in-game items, assets and more",  "https://valorant-api.com/","", "HTTPS", "Unknown"],
    ["Warface (non-official)", "Official API proxy with better data structure and more features", "https://api.wfstats.cf/", "", "HTTPS", ""],
    ["Wargaming.net", "Wargaming.net info and stats", "https://developers.wargaming.net/", "apiKey", "HTTPS", ""],
    ["When is next MCU film", "Upcoming MCU film information",  "https://github.com/DiljotSG/MCU-Countdown/blob/develop/docs/API.md","", "HTTPS", "Unknown"],
    ["xkcd", "Retrieve xkcd comics as JSON", "https://xkcd.com/json.html", "", "HTTPS", ""],
    ["Yu-Gi-Oh!", "Yu-Gi-Oh! TCG Information", "https://ygoprodeck.com/api-guide/", "", "HTTPS", "Unknown"]
    ];


  @override
  Widget build(BuildContext context) {


     if(widget.listIndex == 1) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Animals',style: TextStyle(color: Colors.white),),
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
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Anime',style: TextStyle(color: Colors.white)),
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
     if(widget.listIndex == 3) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Anti-Malware',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_4.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_4[index];
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
     if(widget.listIndex == 4) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Art & Design',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_5.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_5[index];
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
     if(widget.listIndex == 5) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Authentication',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_6.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_6[index];
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
     if(widget.listIndex == 6) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Blockchain',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_7.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_7[index];
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
     if(widget.listIndex == 7) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Books',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_8.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_8[index];
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
     if(widget.listIndex == 8) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Business',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_9.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_9[index];
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
     if(widget.listIndex == 9) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Calendar',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_10.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_10[index];
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
     if(widget.listIndex == 10) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Cloud Storage',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_11.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_11[index];
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
     if(widget.listIndex == 11) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Continuos Integration',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_12.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_12[index];
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
     if(widget.listIndex == 12) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Cryptocurrency',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_13.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_13[index];
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
     if(widget.listIndex == 13) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Currency Exchange',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_14.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_14[index];
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
     if(widget.listIndex == 14) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Data Validation',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_15.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_15[index];
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
     if(widget.listIndex == 15) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Development',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_15.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_15[index];
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
     if(widget.listIndex == 16) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Dictionaries',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_17.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_17[index];
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
     if(widget.listIndex == 17) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Documents & Productivity',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_18.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_18[index];
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
     if(widget.listIndex == 18) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Email',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_19.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_19[index];
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
     if(widget.listIndex == 19) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Entertainment',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_20.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_20[index];
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
     if(widget.listIndex == 20) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Environment',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_21.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_21[index];
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
     if(widget.listIndex == 21) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Events',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_22.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_22[index];
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
     if(widget.listIndex == 22) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Finance',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_23.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_23[index];
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
     if(widget.listIndex == 23) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Food & Drink',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_24.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_24[index];
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
     if(widget.listIndex == 24) {
       return Scaffold(
         backgroundColor: Colors.black,
         appBar: AppBar(
           iconTheme: IconThemeData(
             color: Colors.white, //change your color here
           ),
           backgroundColor: Colors.black,
           title: Text('Games & Comics',style: TextStyle(color: Colors.white)),
         ),
         body: Padding(
           padding: const EdgeInsets.all(8.0),
           child: ListView.builder(
             itemCount: data_25.length,
             itemBuilder: (BuildContext context, int index) {
               List<String> row = data_25[index];
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
        width: 45,
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
        width: 45,
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
