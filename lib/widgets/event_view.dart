import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:seat_geek_flutter/data/bhandaram.dart';
import 'package:seat_geek_flutter/models/event.dart';
import 'package:seat_geek_flutter/models/favourite.dart';
import 'package:seat_geek_flutter/utils/utils.dart';

class EventView extends StatefulWidget{
  final bool isFav;
  final Event? event;
  final OnFav? onFav;
  const EventView({Key? key,required this.isFav,required this.event,required this.onFav}) : super(key: key);

  @override
  State<EventView> createState() => _EventViewState();
}

class _EventViewState extends State<EventView> {
  List<Widget> _imageSliders = <Widget>[];

  @override
  void initState() {
    super.initState();
    initSlides();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.event!.title!),
        trailing: CupertinoButton(
          child: widget.event!.favourite ? const Icon(MaterialCommunityIcons.heart,color:CupertinoColors.systemRed,) : const Icon(MaterialCommunityIcons.heart_outline,color:CupertinoColors.systemRed,),
          onPressed: ()async {
            Favourite _favourite = Favourite(photo: widget.event!.performers![0].image,location: widget.event!.venue!.displayLocation!,eventTime: widget.event!.datetimeUtc!,eventId: widget.event!.id!.toString(),title: widget.event!.title);
            if(!widget.event!.favourite){
              var stat = await Bhandaram.db!.addFavourite(_favourite);
              if(stat > 0){
                widget.event!.favourite = true;
                widget.onFav!(true);
                if(mounted){
                  setState(() {});
                }
              }
            }else{
              var status = await Bhandaram.db!.deleteExpense(_favourite);
              if(status > 0){
                widget.event!.favourite = false;
                widget.onFav!(false);
                if(mounted){
                  setState(() {});
                }
              }
            }
          },
        ),
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight*1.5),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                ),
                items: _imageSliders,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,bottom: 3),
              child: Text(parseDate(widget.event!.datetimeUtc!),textAlign: TextAlign.start,style: const TextStyle(fontWeight: FontWeight.w600,color: CupertinoColors.black),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,bottom: 3),
              child: Text(widget.event!.venue!.displayLocation!,style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black54),),
            )
          ],
        )
    );
  }

  initSlides(){
    _imageSliders = widget.event!.performers!
        .map((item) => Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.network(item.image, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        item.name!,
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  item.primary ? const Positioned(bottom: 5.0,right: 5.0,child: Icon(MaterialCommunityIcons.star,color: CupertinoColors.systemYellow,)) : Container()
                ],
              )),
        ))
        .toList();
  }
}