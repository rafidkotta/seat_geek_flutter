import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:seat_geek_flutter/data/bhandaram.dart';
import 'package:seat_geek_flutter/models/favourite.dart';
import 'package:seat_geek_flutter/theme/styles.dart';
import 'package:seat_geek_flutter/utils/utils.dart';

class FavouriteItem extends StatelessWidget{
  final Favourite favourite;
  final bool lastItem;
  final OnFav onFavUpdate;
  const FavouriteItem({Key? key,required this.favourite,required this.lastItem,required this.onFavUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        // Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => EventView(event: widget.event,isFav: false,)))
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(10)))
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(favourite.photo!,fit: BoxFit.cover,height: 80,width: 120,)
                ),
              ),
              Expanded(child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(favourite.title!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(favourite.location!,style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black54),),
                    ),
                    Text(parseDate(favourite.eventTime!),style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black54),)
                  ],
                ),
              ),
              ),
              Center(
                child: CupertinoButton(
                  child: const Icon(MaterialCommunityIcons.heart,color:CupertinoColors.systemRed,),
                  onPressed: ()async {
                    var status = await Bhandaram.db!.deleteExpense(favourite);
                    if(status > 0){
                      onFavUpdate(false);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
    if (lastItem) {
      return item;
    }

    return Column(
      children: <Widget>[
        item,
        Padding(
          padding: const EdgeInsets.only(
            left: 160,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.eventRowDivider,
          ),
        ),
      ],
    );
  }
}