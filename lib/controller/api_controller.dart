import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:seat_geek_flutter/constant/credentials.dart';
import 'package:seat_geek_flutter/constant/urls.dart';

Future<http.Response?> apiCall({required String url,Map<String,String>? body,@required BuildContext? context})async{
  if(body != null){
    body.putIfAbsent(queryClientId, () => Credential.clientId);
  }
  else{
    body = {queryClientId:Credential.clientId};
  }
  var _endPoint = Uri.https(domain,url,body) ;
  try{
      return await http.get(_endPoint)/*.timeout(Duration(seconds: 70))*/;
  }catch(ex){
    // showSnackBar(context: context!, message: ex.toString(), color: Colors.red);
    debugPrint(ex.toString());
    return null;
  }
}