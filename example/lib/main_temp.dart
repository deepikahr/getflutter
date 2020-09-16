import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/getwidget.dart';

final List<String> imageList = [
  'https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg',
  'https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg',
  'https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg',
  'https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg',
  'https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg',
  'https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg',
  'https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg',
  'https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg',
];

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'GetWidget Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'GetWidget Example'),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController tabController;
  final _ratingController = TextEditingController();
  bool check = false;
  String searchData;
  final TextEditingController _searchController = TextEditingController();
  int groupValue = 0;
  final GFBottomSheetController _controller = GFBottomSheetController();

  @override
  void initState() {
    super.initState();
    _ratingController.text = '4.5';
    tabController = TabController(length: 6, initialIndex: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  bool switchValue = true;
  bool showToast = false;

  List list = [
    'Flutter',
    'React',
    'Ionic',
    'Xamarin',
    'Flutter2',
    'React2',
    'Ionic2',
    'Xamarin2',
  ];

  final List<String> imageList = [
    'https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg',
    'https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg',
    'https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg',
    'https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg',
    'https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg',
  ];

  void _persistentBottomSheet() {
    _scaffoldKey.currentState.showBottomSheet((context) => Container(
          color: Colors.redAccent,
          height: 250,
          child: const Center(
            child: Text('Hey! guys , this is a persistent bottom sheet'),
          ),
        ));
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        elevation: 10,
        builder: (builder) => Container(
              height: 350,
              color: Colors.transparent,
              child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: const Center(
                    child: Text('This is a modal sheet'),
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: GFAppBar(
          title: const Text('UI KIt'),
        ),
        body: ListView.builder(
            itemCount: imageList.length,
            itemBuilder: (context, index) => Material(
                  color: Colors.grey[300],
                  child: GFStickyHeader(
                    header: Container(
                      height: 50.0,
                      color: Colors.blueGrey[700],
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Header #$index',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    content: Container(
                      child: Image.network(imageList[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200.0),
                    ),
                  ),
                )),
      );

  //     ListView(
  //       children: [
  //         Image.network(imageList[3], height: 200, fit: BoxFit.cover,),
  //         Image.network(imageList[4], height: 200, fit: BoxFit.cover,),
  //         GFStickyHeader(
  //           header: Container(
  //             height: 100,
  //             color: Colors.teal,
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             alignment: Alignment.centerLeft,
  //             child: const Text(
  //               'Title',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //           content: ListView(
  //             shrinkWrap: true,
  //             physics: const ScrollPhysics(),
  //             children: [
  //               Image.network(imageList[0], height: 200, fit: BoxFit.fill,),
  //               Image.network(imageList[1], height: 200, fit: BoxFit.fill,),
  //               Image.network(imageList[2], height: 200, fit: BoxFit.fill,),
  //               Image.network(imageList[0], height: 200, fit: BoxFit.fill,),
  //               Image.network(imageList[1], height: 200, fit: BoxFit.fill,),
  //               Image.network(imageList[2], height: 200, fit: BoxFit.fill,)
  //             ],
  //           ),
  //         )
  //       ],
  //     ),
  // );

//    SingleChildScrollView(
//      child: Column(
//        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: [
//          Container(
//            height: 10,
//          ),
//          Radio(
//            value: 0,
//            groupValue: groupValue,
//            onChanged: (val) {
//              setState(() {
//                groupValue = val;
//              });
//            },
//          ),
//          Radio(
//            value: 1,
//            groupValue: groupValue,
//            onChanged: (val) {
//              setState(() {
//                groupValue = val;
//              });
//            },
//          ),
//        ],
//      ),
//    ),
//    bottomSheet: GFBottomSheet(
//      controller: _controller,
////animationDuration: 800,
////      minContentHeight: 100,
//      maxContentHeight: 300,
////      elevation: 10,
//      enableExpandableContent: true,
//      stickyHeaderHeight: 100,
//      stickyHeader: Container(
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(10),
//            color: Colors.tealAccent),
////        height: 100,
//        child: const Center(
//          child: Text('Swipe me!'),
//        ),
//      ),
//      contentBody: Container(
//        color: Colors.teal,
//        child: ListView(
//          shrinkWrap: true,
//          physics: const ScrollPhysics(),
//          children: const [
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//            Text('fhj'),
//          ],
//        ),
//      ),
////      stickyFooter: Container(
////        color: Theme.of(context).primaryColor,
////        height: 100,
////        child: const Center(
////          child: Text('I am Footer!'),
////        ),
////      ),
////      stickyFooterHeight: 50,
//    ),
//    floatingActionButton: FloatingActionButton(
//        child: const Icon(Icons.stars),
//        onPressed: () {
//          _controller.isBottomSheetOpened
//              ? _controller.hideBottomSheet()
//              : _controller.showBottomSheet();
//        }),
//  );
}
