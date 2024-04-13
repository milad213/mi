


import 'package:flutter/material.dart';

import '../app/home/presentation/home.dart';
import '../app/login/presentation/login.dart';

class Routes{
static const String loginRoute = "/login";
static const String homeRoute = "/home";

 }
 class RouteGenerator {
 static Route<dynamic> getRoute (RouteSettings settings)
{ switch (settings.name){
 case Routes.loginRoute:
   return MaterialPageRoute(builder: (_)=> Login());
  case Routes.homeRoute:
    return MaterialPageRoute(builder: (_)=> const Home());
 default:
return undefinedRoute ();

}

}
static Route<dynamic> undefinedRoute (){
  return MaterialPageRoute(builder: (_)=>
      Scaffold(
      appBar: AppBar(
        title: const Text("no route found"),
  )
  )
  );
}
}