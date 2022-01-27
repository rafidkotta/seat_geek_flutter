import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:seat_geek_flutter/constant/urls.dart';
import 'package:seat_geek_flutter/controller/api_controller.dart';

Future<EventsResponse?> getEvents({required BuildContext context,required Map<String,String>? body})async{
  var _response = await apiCall(url: urlListEvents, context: context,body: body);
  if(_response!.statusCode == 200){
    var _data = json.decode(_response.body);
      return EventsResponse.fromJson(_data);
  }else{
    return EventsResponse(error: true,events: [],meta: null);
  }
}

Future<Event?> getEvent({required BuildContext context,required Map<String,String>? body,required String eventId})async{
  var _response = await apiCall(url: urlListEvents+eventId, context: context,body: body);
  if(_response!.statusCode == 200){
    var _data = json.decode(_response.body);
    return Event.fromJson(_data);
  }else{
    return Event(favourite: false);
  }
}

class EventsResponse {
  List<Event>? events;
  Meta? meta;
  bool? error;

  EventsResponse({this.events, this.meta, this.error});

  EventsResponse.fromJson(Map<String, dynamic> json) {
    try{
      if (json['events'] != null) {
        events = <Event>[];
        json['events'].forEach((v) {
          events!.add(Event.fromJson(v));
        });
      }
      meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Event {
  String? type;
  bool favourite = false;
  int? id;
  String? datetimeUtc;
  Venue? venue;
  bool? datetimeTbd;
  List<Performers>? performers;
  bool? isOpen;
  String? datetimeLocal;
  bool? timeTbd;
  String? shortTitle;
  String? visibleUntilUtc;
  Stats? stats;
  String? url;
  String? score;
  String? announceDate;
  String? createdAt;
  bool? dateTbd;
  String? title;
  String? popularity;
  String? description;
  String? status;
  AccessMethod? accessMethod;
  Announcements? announcements;
  bool? conditional;
  bool? generalAdmission;

  Event(
      {this.type,
        this.id,
        this.datetimeUtc,
        this.venue,
        required this.favourite,
        this.datetimeTbd,
        this.performers,
        this.isOpen,
        this.datetimeLocal,
        this.timeTbd,
        this.shortTitle,
        this.visibleUntilUtc,
        this.stats,
        this.url,
        this.score,
        this.announceDate,
        this.createdAt,
        this.dateTbd,
        this.title,
        this.popularity,
        this.description,
        this.status,
        this.accessMethod,
        this.announcements,
        this.conditional,
        this.generalAdmission});

  Event.fromJson(Map<String, dynamic> json) {
    try{
      type = json['type'];
      id = json['id'];
      datetimeUtc = json['datetime_utc'];
      venue = json['venue'] != null ? Venue.fromJson(json['venue']) : null;
      datetimeTbd = json['datetime_tbd'];
      if (json['performers'] != null) {
        performers = <Performers>[];
        json['performers'].forEach((v) {
          performers!.add(Performers.fromJson(v));
        });
      }
      isOpen = json['is_open'];
      datetimeLocal = json['datetime_local'];
      timeTbd = json['time_tbd'];
      shortTitle = json['short_title'];
      visibleUntilUtc = json['visible_until_utc'];
      url = json['url'];
      score = json['score'].toString();
      announceDate = json['announce_date'];
      createdAt = json['created_at'];
      dateTbd = json['date_tbd'];
      title = json['title'];
      popularity = json['popularity'].toString();
      description = json['description'];
      status = json['status'];
      accessMethod = json['access_method'] != null
          ? AccessMethod.fromJson(json['access_method'])
          : null;
      announcements = json['announcements'] != null
          ? Announcements.fromJson(json['announcements'])
          : null;
      conditional = json['conditional'];
      generalAdmission = json['general_admission'];
    }catch(ex){
      debugPrint(ex.toString());
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['datetime_utc'] = datetimeUtc;
    if (venue != null) {
      data['venue'] = venue!.toJson();
    }
    data['datetime_tbd'] = datetimeTbd;
    if (performers != null) {
      data['performers'] = performers!.map((v) => v.toJson()).toList();
    }
    data['is_open'] = isOpen;
    data['datetime_local'] = datetimeLocal;
    data['time_tbd'] = timeTbd;
    data['short_title'] = shortTitle;
    data['visible_until_utc'] = visibleUntilUtc;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    data['url'] = url;
    data['score'] = score;
    data['announce_date'] = announceDate;
    data['created_at'] = createdAt;
    data['date_tbd'] = dateTbd;
    data['title'] = title;
    data['popularity'] = popularity;
    data['description'] = description;
    data['status'] = status;
    if (accessMethod != null) {
      data['access_method'] = accessMethod!.toJson();
    }
    if (announcements != null) {
      data['announcements'] = announcements!.toJson();
    }
    data['conditional'] = conditional;
    data['general_admission'] = generalAdmission;
    return data;
  }
}

class Venue {
  String? state;
  String? nameV2;
  String? postalCode;
  String? name;
  String? timezone;
  String? url;
  String? score;
  Location? location;
  String? address;
  String? country;
  bool? hasUpcomingEvents;
  int? numUpcomingEvents;
  String? city;
  String? slug;
  String? extendedAddress;
  int? id;
  int? popularity;
  AccessMethod? accessMethod;
  int? metroCode;
  int? capacity;
  String? displayLocation;

  Venue(
      {this.state,
        this.nameV2,
        this.postalCode,
        this.name,
        this.timezone,
        this.url,
        this.score,
        this.location,
        this.address,
        this.country,
        this.hasUpcomingEvents,
        this.numUpcomingEvents,
        this.city,
        this.slug,
        this.extendedAddress,
        this.id,
        this.popularity,
        this.accessMethod,
        this.metroCode,
        this.capacity,
        this.displayLocation});

  Venue.fromJson(Map<String, dynamic> json) {
    try{
      state = json['state'];
      nameV2 = json['name_v2'];
      postalCode = json['postal_code'];
      name = json['name'];
      timezone = json['timezone'];
      url = json['url'];
      score = json['score'].toString();
      location = json['location'] != null
          ? Location.fromJson(json['location'])
          : null;
      address = json['address'];
      country = json['country'];
      hasUpcomingEvents = json['has_upcoming_events'];
      numUpcomingEvents = json['num_upcoming_events'];
      city = json['city'];
      slug = json['slug'];
      extendedAddress = json['extended_address'];
      id = json['id'];
      popularity = json['popularity'];
      accessMethod = json['access_method'] != null
          ? AccessMethod.fromJson(json['access_method'])
          : null;
      metroCode = json['metro_code'];
      capacity = json['capacity'];
      displayLocation = json['display_location'];
    }catch(ex){
      debugPrint(ex.toString());
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['state'] = state;
    data['name_v2'] = nameV2;
    data['postal_code'] = postalCode;
    data['name'] = name;
    data['timezone'] = timezone;
    data['url'] = url;
    data['score'] = score;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['address'] = address;
    data['country'] = country;
    data['has_upcoming_events'] = hasUpcomingEvents;
    data['num_upcoming_events'] = numUpcomingEvents;
    data['city'] = city;
    data['slug'] = slug;
    data['extended_address'] = extendedAddress;
    data['id'] = id;
    data['popularity'] = popularity;
    if (accessMethod != null) {
      data['access_method'] = accessMethod!.toJson();
    }
    data['metro_code'] = metroCode;
    data['capacity'] = capacity;
    data['display_location'] = displayLocation;
    return data;
  }
}

class Location {
  double? lat;
  double? lon;

  Location({this.lat, this.lon});

  Location.fromJson(Map<String, dynamic> json) {
    try{
      lat = json['lat'];
      lon = json['lon'];
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}

class AccessMethod {
  String? method;
  String? createdAt;
  bool? employeeOnly;

  AccessMethod({this.method, this.createdAt, this.employeeOnly});

  AccessMethod.fromJson(Map<String, dynamic> json) {
    try{
      method = json['method'];
      createdAt = json['created_at'];
      employeeOnly = json['employee_only'];
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['created_at'] = createdAt;
    data['employee_only'] = employeeOnly;
    return data;
  }
}

class Performers {
  String? type;
  String? name;
  String image = "";
  int? id;
  bool? hasUpcomingEvents;
  bool primary = false;
  Stats? stats;
  String? imageAttribution;
  String? url;
  double? score;
  String? slug;
  String? homeVenueId;
  String? shortName;
  int? numUpcomingEvents;
  String? imageLicense;
  int? popularity;
  bool? homeTeam;
  bool? awayTeam;

  Performers(
      {this.type,
        this.name,
        required this.image,
        this.id,
        this.hasUpcomingEvents,
        required this.primary,
        this.stats,
        this.imageAttribution,
        this.url,
        this.score,
        this.slug,
        this.homeVenueId,
        this.shortName,
        this.numUpcomingEvents,
        this.imageLicense,
        this.popularity,
        this.homeTeam,
        this.awayTeam});

  Performers.fromJson(Map<String, dynamic> json) {
    try{
      if(json['type'] != null){
        type = json['type'];
      }
      if(json['name'] != null){
        name = json['name'];
      }
      if(json['image'] != null){
        image = json['image'];
      }
      if(json['id'] != null){
        id = json['id'];
      }
      if(json['has_upcoming_events'] != null){
        hasUpcomingEvents = json['has_upcoming_events'];
      }
      if(json['primary'] != null){
        primary = json['primary'];
      }
      if(json['image_attribution'] != null){
        imageAttribution = json['image_attribution'];
      }
      if(json['url'] != null){
        url = json['url'];
      }
      if(json['score'] != null){
        score = json['score'];
      }
      if(json['slug'] != null){
        slug = json['slug'];
      }
      if(json['home_venue_id'] != null){
        homeVenueId = json['home_venue_id'].toString();
      }
      if(json['short_name'] != null){
        shortName = json['short_name'];
      }
      if(json['num_upcoming_events'] != null){
        numUpcomingEvents = json['num_upcoming_events'];
      }
      if(json[''] != null){

      }
      if(json['image_license'] != null){
        imageLicense = json['image_license'];
      }
      if(json['popularity'] != null){
        popularity = json['popularity'];
      }
      if(json['home_team'] != null){
        homeTeam = json['home_team'];
      }
      if(json['away_team'] != null){
        awayTeam = json['away_team'];
      }
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['image'] = image;
    data['id'] = id;
    data['has_upcoming_events'] = hasUpcomingEvents;
    data['primary'] = primary;
    if (stats != null) {
      data['stats'] = stats!.toJson();
    }
    data['image_attribution'] = imageAttribution;
    data['url'] = url;
    data['score'] = score;
    data['slug'] = slug;
    data['home_venue_id'] = homeVenueId;
    data['short_name'] = shortName;
    data['num_upcoming_events'] = numUpcomingEvents;
    data['image_license'] = imageLicense;
    data['popularity'] = popularity;
    data['home_team'] = homeTeam;
    data['away_team'] = awayTeam;
    return data;
  }
}

class Images {
  String? huge;

  Images({this.huge});

  Images.fromJson(Map<String, dynamic> json) {
    try{
      huge = json['huge'];
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['huge'] = huge;
    return data;
  }
}

class Divisions {
  int? taxonomyId;
  String? shortName;
  String? displayName;
  String? displayType;
  int? divisionLevel;
  String? slug;

  Divisions(
      {this.taxonomyId,
        this.shortName,
        this.displayName,
        this.displayType,
        this.divisionLevel,
        this.slug});

  Divisions.fromJson(Map<String, dynamic> json) {
    taxonomyId = json['taxonomy_id'];
    shortName = json['short_name'];
    displayName = json['display_name'];
    displayType = json['display_type'];
    divisionLevel = json['division_level'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taxonomy_id'] = taxonomyId;
    data['short_name'] = shortName;
    data['display_name'] = displayName;
    data['display_type'] = displayType;
    data['division_level'] = divisionLevel;
    data['slug'] = slug;
    return data;
  }
}



class Genres {
  int? id;
  String? name;
  String? slug;
  bool? primary;
  ImagesData? images;
  String? image;
  Genres(
      {this.id,
        this.name,
        this.slug,
        this.primary,
        this.images,
        this.image});

  Genres.fromJson(Map<String, dynamic> json) {
    try{
      id = json['id'];
      name = json['name'];
      slug = json['slug'];
      primary = json['primary'];
      images =
      json['images'] != null ? ImagesData.fromJson(json['images']) : null;
      image = json['image'];
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['primary'] = primary;
    if (images != null) {
      data['images'] = images!.toJson();
    }
    data['image'] = image;
    return data;
  }
}

class ImagesData {
  String? s1200x525;
  String? s1200x627;
  String? s136x136;
  String? s500700;
  String? s800x320;
  String? banner;
  String? block;
  String? criteo130160;
  String? criteo170235;
  String? criteo205100;
  String? criteo400300;
  String? fb100x72;
  String? fb600315;
  String? huge;
  String? ipadEventModal;
  String? ipadHeader;
  String? ipadMiniExplore;
  String? mongo;
  String? squareMid;
  String? triggitFbAd;

  ImagesData(
      {this.s1200x525,
        this.s1200x627,
        this.s136x136,
        this.s500700,
        this.s800x320,
        this.banner,
        this.block,
        this.criteo130160,
        this.criteo170235,
        this.criteo205100,
        this.criteo400300,
        this.fb100x72,
        this.fb600315,
        this.huge,
        this.ipadEventModal,
        this.ipadHeader,
        this.ipadMiniExplore,
        this.mongo,
        this.squareMid,
        this.triggitFbAd});

  ImagesData.fromJson(Map<String, dynamic> json) {
    try{
      s1200x525 = json['1200x525'];
      s1200x627 = json['1200x627'];
      s136x136 = json['136x136'];
      s500700 = json['500_700'];
      s800x320 = json['800x320'];
      banner = json['banner'];
      block = json['block'];
      criteo130160 = json['criteo_130_160'];
      criteo170235 = json['criteo_170_235'];
      criteo205100 = json['criteo_205_100'];
      criteo400300 = json['criteo_400_300'];
      fb100x72 = json['fb_100x72'];
      fb600315 = json['fb_600_315'];
      huge = json['huge'];
      ipadEventModal = json['ipad_event_modal'];
      ipadHeader = json['ipad_header'];
      ipadMiniExplore = json['ipad_mini_explore'];
      mongo = json['mongo'];
      squareMid = json['square_mid'];
      triggitFbAd = json['triggit_fb_ad'];
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['1200x525'] = s1200x525;
    data['1200x627'] = s1200x627;
    data['136x136'] = s136x136;
    data['500_700'] = s500700;
    data['800x320'] = s800x320;
    data['banner'] = banner;
    data['block'] = block;
    data['criteo_130_160'] = criteo130160;
    data['criteo_170_235'] = criteo170235;
    data['criteo_205_100'] = criteo205100;
    data['criteo_400_300'] = criteo400300;
    data['fb_100x72'] = fb100x72;
    data['fb_600_315'] = fb600315;
    data['huge'] = huge;
    data['ipad_event_modal'] = ipadEventModal;
    data['ipad_header'] = ipadHeader;
    data['ipad_mini_explore'] = ipadMiniExplore;
    data['mongo'] = mongo;
    data['square_mid'] = squareMid;
    data['triggit_fb_ad'] = triggitFbAd;
    return data;
  }
}

class Stats {
  int? listingCount;
  int? averagePrice;
  int? lowestPriceGoodDeals;
  int? lowestPrice;
  int? highestPrice;
  int? visibleListingCount;
  List<int>? dqBucketCounts;
  int? medianPrice;
  int? lowestSgBasePrice;
  int? lowestSgBasePriceGoodDeals;

  Stats(
      {this.listingCount,
        this.averagePrice,
        this.lowestPriceGoodDeals,
        this.lowestPrice,
        this.highestPrice,
        this.visibleListingCount,
        this.dqBucketCounts,
        this.medianPrice,
        this.lowestSgBasePrice,
        this.lowestSgBasePriceGoodDeals});

  Stats.fromJson(Map<String, dynamic> json) {
    try{
      listingCount = json['listing_count'];
      averagePrice = json['average_price'];
      lowestPriceGoodDeals = json['lowest_price_good_deals'];
      lowestPrice = json['lowest_price'];
      highestPrice = json['highest_price'];
      visibleListingCount = json['visible_listing_count'];
      dqBucketCounts = json['dq_bucket_counts'].cast<int>();
      medianPrice = json['median_price'];
      lowestSgBasePrice = json['lowest_sg_base_price'];
      lowestSgBasePriceGoodDeals = json['lowest_sg_base_price_good_deals'];
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['listing_count'] = listingCount;
    data['average_price'] = averagePrice;
    data['lowest_price_good_deals'] = lowestPriceGoodDeals;
    data['lowest_price'] = lowestPrice;
    data['highest_price'] = highestPrice;
    data['visible_listing_count'] = visibleListingCount;
    data['dq_bucket_counts'] = dqBucketCounts;
    data['median_price'] = medianPrice;
    data['lowest_sg_base_price'] = lowestSgBasePrice;
    data['lowest_sg_base_price_good_deals'] = lowestSgBasePriceGoodDeals;
    return data;
  }
}

class Announcements {
  CheckoutDisclosures? checkoutDisclosures;

  Announcements({this.checkoutDisclosures});

  Announcements.fromJson(Map<String, dynamic> json) {
    checkoutDisclosures = json['checkout_disclosures'] != null
        ? CheckoutDisclosures.fromJson(json['checkout_disclosures'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (checkoutDisclosures != null) {
      data['checkout_disclosures'] = checkoutDisclosures!.toJson();
    }
    return data;
  }
}

class CheckoutDisclosures {
  List<Messages>? messages;

  CheckoutDisclosures({this.messages});

  CheckoutDisclosures.fromJson(Map<String, dynamic> json) {
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  String? text;

  Messages({this.text});

  Messages.fromJson(Map<String, dynamic> json) {
    try{
      text = json['text'];
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Meta {
  int? total;
  int? took;
  int? page;
  int? perPage;
  Geolocation? geolocation;

  Meta({this.total, this.took, this.page, this.perPage, this.geolocation});

  Meta.fromJson(Map<String, dynamic> json) {
    try{
      total = json['total'];
      took = json['took'];
      page = json['page'];
      perPage = json['per_page'];
      geolocation = json['geolocation'] != null
          ? Geolocation.fromJson(json['geolocation'])
          : null;
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['took'] = took;
    data['page'] = page;
    data['per_page'] = perPage;
    if (geolocation != null) {
      data['geolocation'] = geolocation!.toJson();
    }
    return data;
  }
}

class Geolocation {
  double? lat;
  double? lon;
  String? city;
  String? state;
  String? country;
  String? displayName;
  String? range;

  Geolocation(
      {this.lat,
        this.lon,
        this.city,
        this.state,
        this.country,
        this.displayName,
        this.range});

  Geolocation.fromJson(Map<String, dynamic> json) {
    try{
      lat = json['lat'];
      lon = json['lon'];
      city = json['city'];
      state = json['state'];
      country = json['country'];
      displayName = json['display_name'];
      range = json['range'];
    }catch(ex){
      debugPrint(ex.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['display_name'] = displayName;
    data['range'] = range;
    return data;
  }
}