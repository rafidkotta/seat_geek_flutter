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
  Event? _event;
  bool _loaded = true;

  @override
  void initState() {
    super.initState();
      _event = widget.event;
    if(!widget.isFav){
      initSlides();
    }else{
      _loadEvent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(_event!.title!),
        trailing: CupertinoButton(
          child: _event!.favourite ? const Icon(MaterialCommunityIcons.heart,color:CupertinoColors.systemRed,) : const Icon(MaterialCommunityIcons.heart_outline,color:CupertinoColors.systemRed,),
          onPressed: ()async {
            if(_loaded){
              Favourite _favourite = Favourite(photo: _event!.performers![0].image,location: _event!.venue!.displayLocation!,eventTime: _event!.datetimeUtc!,eventId: _event!.id!.toString(),title: _event!.title);
              if(!_event!.favourite){
                var stat = await Bhandaram.db!.addFavourite(_favourite);
                if(stat > 0){
                  _event!.favourite = true;
                  widget.onFav!(true);
                  if(mounted){
                    setState(() {});
                  }
                }
              }else{
                var status = await Bhandaram.db!.deleteExpense(_favourite);
                if(status > 0){
                  _event!.favourite = false;
                  widget.onFav!(false);
                  if(mounted){
                    setState(() {});
                  }
                }
              }
            }
          },
        ),
      ),
        child: _loaded ? Column(
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
              child: Text(parseDate(_event!.datetimeUtc!),textAlign: TextAlign.start,style: const TextStyle(fontWeight: FontWeight.w600,color: CupertinoColors.black),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8,bottom: 3),
              child: Text(_event!.venue!.displayLocation!,style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.black54),),
            )
          ],
        ): const Center(child: CircularProgressIndicator(),)
    );
  }

  _loadEvent()async{
    _loaded = false;
    var data = await getEvent(context: context,eventId: widget.event!.id!.toString(), body: null);
    _event = data!;
    _event!.favourite = widget.event!.favourite;
    initSlides();
    if(mounted){
      setState(() {
        _loaded = true;
      });
    }
  }

  initSlides(){
    _imageSliders = _event!.performers!
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