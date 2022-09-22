// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:geolocator/geolocator.dart';



import 'dart:async';
import 'dart:io';
import 'dart:ui';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';


CollectionReference alok=FirebaseFirestore.instance.collection("location");
// late Position position;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeService();
  // get_the_location();
await Firebase.initializeApp();



  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled=await Geolocator.isLocationServiceEnabled();
  if(!serviceEnabled)
  {

    serviceEnabled=await Geolocator.isLocationServiceEnabled();
    // permission = await Geolocator.requestPermission();
  }
  permission=await Geolocator.requestPermission();
  if(permission==LocationPermission.denied)
  {
    permission=await Geolocator.requestPermission();
  }
  if(permission==LocationPermission.deniedForever)
  {

    Get.showSnackbar(GetSnackBar(message: "Sorry the mission failed",snackPosition: SnackPosition.TOP,backgroundColor: Colors.red,));
  }

  runApp(new GetMaterialApp(
    home: MyApp(),
    title: "BackgroundKLocation",
    debugShowCheckedModeBanner: false,
  ) );

}

Future<void> initializeService()
async {

  //
  // bool serviceEnabled;
  // LocationPermission permission;
  // serviceEnabled=await Geolocator.isLocationServiceEnabled();
  // if(!serviceEnabled)
  // {
  //   var kidding=Permission.locationAlways;
  //   permission = await Geolocator.requestPermission();
  // }
  // permission=await Geolocator.requestPermission();
  // if(permission==LocationPermission.denied)
  // {
  //   permission=await Geolocator.requestPermission();
  // }
  // if(permission==LocationPermission.deniedForever)
  // {
  //
  //   Get.showSnackbar(GetSnackBar(message: "Sorry the mission failed",snackPosition: SnackPosition.TOP,backgroundColor: Colors.red,));
  // }
  //
  //
  // Position position =await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //


  final service=FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'my_foreground', // id
    'MY FOREGROUND SERVICE', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.low, // importance must be at low or higher level
  );


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();



  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);






  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  await service.configure(
      androidConfiguration:AndroidConfiguration(
        onStart: onStart,
        isForegroundMode:true,
        autoStart:true,
        notificationChannelId: 'my_foreground',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,

      ),
    iosConfiguration:IosConfiguration(
        onForeground: onStart,
        onBackground:onIosBackground,
    autoStart:true
    )

  );
  service.startService();
  // return Future(() => true);
}



bool onIosBackground(ServiceInstance service)
{
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}




var a=1;



void onStart(ServiceInstance service)async
{

  //
  // bool serviceEnabled;
  // LocationPermission permission;
  // serviceEnabled=await Geolocator.isLocationServiceEnabled();
  // if(!serviceEnabled)
  // {
  //   var kidding=Permission.locationAlways;
  //   permission = await Geolocator.requestPermission();
  // }
  // permission=await Geolocator.requestPermission();
  // if(permission==LocationPermission.denied)
  // {
  //   permission=await Geolocator.requestPermission();
  // }
  // if(permission==LocationPermission.deniedForever)
  // {
  //
  //   Get.showSnackbar(GetSnackBar(message: "Sorry the mission failed",snackPosition: SnackPosition.TOP,backgroundColor: Colors.red,));
  // }
  //
  //
  // Position position =await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //




  DartPluginRegistrant.ensureInitialized();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {service.stopSelf();});

  // bool serviceEnabled;
  // LocationPermission permission;
  // serviceEnabled=await Geolocator.isLocationServiceEnabled();
  // if(!serviceEnabled)
  // {
  //
  //   serviceEnabled=await Geolocator.isLocationServiceEnabled();
  //   // permission = await Geolocator.requestPermission();
  // }
  // permission=await Geolocator.requestPermission();
  // if(permission==LocationPermission.denied)
  // {
  //   permission=await Geolocator.requestPermission();
  // }
  // if(permission==LocationPermission.deniedForever)
  // {
  //
  //   Get.showSnackbar(GetSnackBar(message: "Sorry the mission failed",snackPosition: SnackPosition.TOP,backgroundColor: Colors.red,));
  // }



  Timer.periodic(const Duration(seconds: 1), (timer) async
  {
    // var kidding=Permission.locationAlways;
    // if(service is AndroidServiceInstance)
    // bool serviceEnabled;
    // LocationPermission permission;
    // serviceEnabled=await Geolocator.isLocationServiceEnabled();
    // if(!serviceEnabled)
    // {
    //
    //   serviceEnabled=await Geolocator.isLocationServiceEnabled();
    //   // permission = await Geolocator.requestPermission();
    // }
    // permission=await Geolocator.requestPermission();
    // if(permission==LocationPermission.denied)
    // {
    //   permission=await Geolocator.requestPermission();
    // }
    // if(permission==LocationPermission.deniedForever)
    // {
    //
    //   Get.showSnackbar(GetSnackBar(message: "Sorry the mission failed",snackPosition: SnackPosition.TOP,backgroundColor: Colors.red,));
    // }
    //
    //
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position.toString());
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
            888,
            "Location  Service", //position.longitude.toString(),
            position.toString(),
            const NotificationDetails(
                android: AndroidNotificationDetails(
                  'my_foreground',
                  'MY FOREGROUND SERVICE',
                  icon: 'ic_bg_service_small',
                  ongoing: true,
                )
            ));
        await WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp();
        CollectionReference vikram = FirebaseFirestore.instance.collection(
            "loc");
        await vikram.add(
            {"location": GeoPoint(position.latitude, position.longitude)});
      }
    }

    service.invoke('update',
        {

        }
    );
  }
  );



}



//
// void get_the_location()async
// {
//   bool serviceEnabled;
//   LocationPermission permission;
//   serviceEnabled=await Geolocator.isLocationServiceEnabled();
//   if(!serviceEnabled)
//     {
//       var kidding=Permission.locationAlways;
//       permission = await Geolocator.requestPermission();
//     }
//   permission=await Geolocator.requestPermission();
//   if(permission==LocationPermission.denied)
//     {
//       permission=await Geolocator.requestPermission();
//     }
//   if(permission==LocationPermission.deniedForever)
//     {
//
//       Get.showSnackbar(GetSnackBar(message: "Sorry the mission failed",snackPosition: SnackPosition.TOP,backgroundColor: Colors.red,));
//     }
//
//
//   Position position =await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//
// }






// var ssssss;


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var text="start service";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children:[ ElevatedButton(
            child: Text(text),
            onPressed: ()async
            {


              // await alok.add(
              //   {
              //     "location":position.toString()
              //   }

             // );

              // await initializeService();
              final service=FlutterBackgroundService();
              var isRunning= await service.isRunning();
              if(isRunning)
                {
                  // service.
                  service.invoke('stopService');
                  Get.showSnackbar(GetSnackBar(message: "Stopping the service",duration: Duration(seconds: 2),));
                }
              else
                {
                  // service.invoke('setAsForeground');
                  service.startService();
                  Get.showSnackbar(GetSnackBar(message: "starting the location service",duration: Duration(seconds: 2),));
                }
              if(!isRunning)
                {

                  text='stop service';
                }else
                  {
                    text='start service';
                  }
              setState(() {

              });

              Position pos=await Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.high);

              await alok.add({"locationnnnnnnnn":GeoPoint(pos.latitude,pos.longitude)});
            },
          ),

            // Text(sssss);
      ]
        ),
      ),
    );
  }
}
