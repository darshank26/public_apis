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
  ["Blockchain", "Bitcoin Payment, Wallet & Transaction Data", "https://www.blockchain.com/explorer/api","apiKey", "Yes", "Unknown"],
  ["blockfrost Cardano", "Interaction with the Cardano mainnet and several testnets", "https://blockfrost.io/","apiKey", "HTTPS", "Unknown"],

    ["Brave NewCoin", "Real-time and historic crypto data from more than 200+ exchanges", "apiKey", "HTTPS", "Unknown"],
  ["BtcTurk", "Real-time cryptocurrency data, graphs and API that allows buy&sell", "apiKey", "HTTPS", "CORS"],
  ["Bybit", "Cryptocurrency data feed and algorithmic trading", "apiKey", "HTTPS", "Unknown"],
  ["CoinAPI", "All Currency Exchanges integrate under a single api", "apiKey", "HTTPS", ""],
  ["Coinbase", "Bitcoin, Bitcoin Cash, Litecoin and Ethereum Prices", "apiKey", "HTTPS", "Unknown"],
  ["Coinbase Pro", "Cryptocurrency Trading Platform", "apiKey", "HTTPS", "Unknown"],
  ["CoinCap", "Real-time Cryptocurrency prices through a RESTful API", "", "HTTPS", "Unknown"],
  ["CoinDCX", "Cryptocurrency Trading Platform", "apiKey", "HTTPS", "Unknown"],
  ["CoinDesk", "CoinDesk's Bitcoin Price Index (BPI) in multiple currencies", "", "HTTPS", "Unknown"],
  ["CoinGecko", "Cryptocurrency Price, Market, and Developer/Social Data", "", "HTTPS", "CORS"],
  ["Coinigy", "Interacting with Coinigy Accounts and Exchange Directly", "apiKey", "HTTPS", "Unknown"],
  ["Coinlib", "Crypto Currency Prices", "apiKey", "HTTPS", "Unknown"],
  ["Coinlore", "Cryptocurrencies prices, volume and more", "", "HTTPS", "Unknown"],
  ["CoinMarketCap", "Cryptocurrencies Prices", "apiKey", "HTTPS", "Unknown"],
  ["Coinpaprika", "Cryptocurrencies prices, volume and more", "", "YeHTTPSs", "CORS"],
  ["CoinRanking", "Live Cryptocurrency data", "apiKey", "HTTPS", "Unknown"],
  ["Coinremitter", "Cryptocurrencies Payment & Prices", "apiKey", "HTTPS", "Unknown"],
  ["CoinStats", "Crypto Tracker", "No", "Yes", "Unknown"],
  ["CryptAPI", "Cryptocurrency Payment Processor", "", "HTTPS", "Unknown"],
  ["CryptingUp", "Cryptocurrency data", "", "HTTPS", "Unknown"],
  ["CryptoCompare", "Cryptocurrencies Comparison", "", "HTTPS", "Unknown"],
  ["CryptoMarket", "Cryptocurrencies Trading platform", "apiKey", "HTTPS", "CORS"],
  ["Cryptonator", "Cryptocurrencies Exchange Rates", "", "HTTPS", "Unknown"],
  ["dYdX", "Decentralized cryptocurrency exchange", "apiKey", "HTTPS", "Unknown"],
  ["Ethplorer", "Ethereum tokens, balances, addresses, history of transactions, contracts, and custom structures", "apiKey", "HTTPS", "Unknown"],
  ["EXMO", "Cryptocurrencies exchange based in UK", "apiKey", "HTTPS", "Unknown"],
  ["FTX", "Complete REST, websocket, and FTX APIs to suit your algorithmic trading needs", "apiKey", "HTTPS", "CORS"],
  ["Gateio", "API provides spot, margin and futures trading operations", "apiKey", "HTTPS", "Unknown"],
  ["Gemini", "Cryptocurrencies Exchange", "", "HTTPS", "Unknown"],
  ["Hirak Exchange Rates", "Exchange rates between 162 currency & 300 crypto currency update each 5 min, accurate, no limits", "apiKey", "HTTPS", "Unknown"],
  ["Huobi", "Seychelles based cryptocurrency exchange", "apiKey", "HTTPS", "Unknown"],
  ["icy.tools", "GraphQL based NFT API", "apiKey", "HTTPS", "Unknown"],
  ["Indodax", "Trade your Bitcoin and other assets with rupiah", "apiKey", "HTTPS", "Unknown"],
  ["INFURA Ethereum", "Interaction with the Ethereum mainnet and several testnets", "apiKey", "HTTPS", "CORS"],
  ["Kraken", "Cryptocurrencies Exchange", "apiKey", "HTTPS", "Unknown"],
  ["KuCoin", "Cryptocurrency Trading Platform", "apiKey", "HTTPS", "Unknown"],
  ["Localbitcoins", "P2P platform to buy and sell Bitcoins", "", "HTTPS", "Unknown"],
  ["Mempool", "Bitcoin API Service focusing on the transaction fee", "", "HTTPS", ""]
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
           title: Text('Anrt & Design',style: TextStyle(color: Colors.white)),
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
