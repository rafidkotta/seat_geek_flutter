import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:seat_geek_flutter/data/bhandaram.dart';
import 'package:seat_geek_flutter/models/favourite.dart';
import 'package:seat_geek_flutter/theme/styles.dart';
import 'package:seat_geek_flutter/widgets/favourite_item.dart';

class FavouritesView extends StatefulWidget{
  const FavouritesView({Key? key}) : super(key: key);

  @override
  State<FavouritesView> createState() => _FavouritesViewState();
}

class _FavouritesViewState extends State<FavouritesView> {
  final List<Favourite> _favourites = <Favourite>[];

  @override
  void initState() {
    if(!kIsWeb){
      _loadFavourites(true);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb ? const Center(child: Text("Favourites not available in Web"),) : DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => FavouriteItem(
                  favourite: _favourites[index],
                  lastItem: index == _favourites.length - 1,
                  onFavUpdate: (status){
                    Bhandaram.unFavItem(_favourites[index].eventId!);
                    _favourites.removeAt(index);
                    _loadFavourites(false);
                  },
                ),
                itemCount: _favourites.length,
              ),
            )
          ],
        ),
      ),
    );
  }
  _loadFavourites(bool init){
    if(init){
      _favourites.addAll(Bhandaram.favourites);
    }else{
      _favourites.clear();
      _favourites.addAll(Bhandaram.favourites);
      setState(() {});
    }
  }
}