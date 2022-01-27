import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:seat_geek_flutter/data/bhandaram.dart';
import 'package:seat_geek_flutter/models/event.dart';
import 'package:seat_geek_flutter/models/favourite.dart';
import 'package:seat_geek_flutter/theme/styles.dart';
import 'package:seat_geek_flutter/utils/utils.dart';

import 'event_view.dart';

class EvenItemView extends StatefulWidget{
  final Event event;
  final bool lastItem;
  final OnFav onFavUpdate;
  const EvenItemView({Key? key,required this.event,required this.lastItem,required this.onFavUpdate}) : super(key: key);

  @override
  State<EvenItemView> createState() => _EvenItemViewState();
}

class _EvenItemViewState extends State<EvenItemView> {
  @override
  Widget build(BuildContext context) {
    final item = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(builder: (context) => EventView(event: widget.event,isFav: widget.event.favourite,onFav: widget.onFavUpdate,)));
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
                  child: Image.network(widget.event.performers![0].image,fit: BoxFit.cover,height: 80,width: 120,)
              ),
            ),
            Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.event.title!,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(widget.event.venue!.displayLocation!,style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black54),),
                  ),
                  Text(parseDate(widget.event.datetimeUtc!),style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black54),)
                ],
              ),
            ),
            ),
            !kIsWeb ? Center(
              child: CupertinoButton(
                child: widget.event.favourite ? const Icon(MaterialCommunityIcons.heart,color:CupertinoColors.systemRed,) : const Icon(MaterialCommunityIcons.heart_outline,color:CupertinoColors.systemRed,),
                onPressed: ()async {
                  Favourite _favourite = Favourite(photo: widget.event.performers![0].image,location: widget.event.venue!.displayLocation!,eventTime: widget.event.datetimeUtc!,eventId: widget.event.id!.toString(),title: widget.event.title);
                  if(!widget.event.favourite){
                    var stat = await Bhandaram.db!.addFavourite(_favourite);
                    if(stat > 0){
                      widget.event.favourite = true;
                      widget.onFavUpdate(true);
                    }
                  }else{
                    var status = await Bhandaram.db!.deleteExpense(_favourite);
                    if(status > 0){
                      widget.event.favourite = false;
                      widget.onFavUpdate(false);
                    }
                  }
                },
              ),
            ) : Container()
          ],
        ),
      ),
      ),
    );
    if (widget.lastItem) {
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