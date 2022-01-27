import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:seat_geek_flutter/data/bhandaram.dart';
import 'widgets/events.dart';
import 'widgets/favourites.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final CupertinoTabController _controller = CupertinoTabController(initialIndex: 0);


  @override
  Widget build(BuildContext context) {
    if(!kIsWeb){
      Bhandaram.init();
    }
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Seat Geek by Rafid'),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.account_group_outline),
              activeIcon: Icon(MaterialCommunityIcons.account_group),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(MaterialCommunityIcons.heart_outline),
              activeIcon: Icon(MaterialCommunityIcons.heart,color: CupertinoColors.destructiveRed,),
              label: 'Favourites',
            ),
          ],
        ),
        controller: _controller,
        tabBuilder:
            (context, index) {
          late final CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: Events(key: UniqueKey(),),
                );
              });
              break;
            case 1:
              returnValue = CupertinoTabView(builder: (context) {
                return CupertinoPageScaffold(
                  child: FavouritesView(key: UniqueKey(),),
                );
              });
              break;
          }
          return returnValue;
        },
      ),
    );
  }
}