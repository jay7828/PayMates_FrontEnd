import 'package:flutter/material.dart';
import 'package:paymates/pages/Home_page.dart';
import 'package:paymates/providerr/notes_provider.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key?key}) :super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: (context)=> NotesProvider(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner:false ,
        home: HomePage(),
    )
    );
  }
}
