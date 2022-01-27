typedef OnFav = Function(bool value);
class Favourite{
  int? id;
  String? title;
  String? eventId;
  String? location;
  String? eventTime;
  String? photo;
  Favourite({this.id,this.title,this.eventId,this.location,this.eventTime,this.photo});
}