import 'package:flutter/material.dart';
import 'package:seat_geek_flutter/data/bhandaram.dart';
import 'package:seat_geek_flutter/models/event.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/styles.dart';
import 'event_item.dart';
import 'search_bar.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocus;
  String _terms = '';
  List<Event> _events = <Event>[];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController()..addListener(_onTextChanged);
    _searchFocus = FocusNode();
    _loadEvents(context,"");
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if(_terms != _searchController.text){
      setState(() {
        _terms = _searchController.text;
      });
      _loadEvents(context, _terms);
    }
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller: _searchController,
        focusNode: _searchFocus,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: !_loading ? ListView.builder(
                itemBuilder: (context, index) => EvenItemView(
                  event: _events[index],
                  lastItem: index == _events.length - 1,
                  onFavUpdate: (status){
                    if(status){
                      _events[index].favourite = true;
                    }else{
                      _events[index].favourite = false;
                    }
                    Bhandaram.updateFavourites();
                    setState(() {});
                  },
                ),
                itemCount: _events.length,
              ): _getShimmer(),
            )
          ],
        ),
      ),
    );
  }
  _loadEvents(BuildContext context,String query)async{
    setState(() {
      _loading = true;
      _events.clear();
    });
    try{
      Map<String,String>? myQuery = <String,String> {};
      if(query != ""){
        myQuery.putIfAbsent("q", () => query);
      }else{
        myQuery = null;
      }
      var data = await getEvents(context: context,body:myQuery);
      for (int i = 0; i < data!.events!.length; i++){
        if(checkFavourite(data.events![i].id!.toString())){
          data.events![i].favourite = true;
        }
      }
      _events = data.events!;
      _loading = false;
      if(mounted){
        setState(() {});
      }
    }catch(ex){
      debugPrint(ex.toString());
    }
  }
  Widget _getShimmer(){
    return Shimmer.fromColors(
      baseColor: Styles.shimmerBase,
      highlightColor: Styles.shimmerHighLight,
      enabled: true,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(15, (index){
            return Padding(
              padding: const EdgeInsets.all(2.0),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Center(
                      child: Container(
                        decoration: ShapeDecoration(color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),side: const BorderSide(color: Styles.shimmerBorder))),
                        width: 120,
                        height: 80,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: ShapeDecoration(color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2),side: const BorderSide(color: Styles.shimmerBorder))),
                              width: 300,
                              height: 24.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: ShapeDecoration(color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2),side: const BorderSide(color: Styles.shimmerBorder))),
                                width: 120,
                                height: 20.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                decoration: ShapeDecoration(color: Colors.white,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2),side: const BorderSide(color: Styles.shimmerBorder))),
                                width: 200,
                                height: 20.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      flex: 6,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  bool checkFavourite(String id){
    for (var element in Bhandaram.favourites) {
      if(element.eventId.toString() == id){
        return true;
      }
    }
    return false;
  }
}