import 'package:blog_admin_side/ADMIN/Admin_screens/Splash_screen/spalsh_screen.dart';
import 'package:blog_admin_side/ADMIN/Data/Admin_provider/AdminAuth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AdminBlog());
}

//scaffoldMessengerKey use for current state and context
final scaffoldMessengerKey=GlobalKey<ScaffoldMessengerState>();


class AdminBlog extends StatelessWidget {
  const AdminBlog({super.key});

  @override
  Widget build(BuildContext context) {

    //multi provider
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>AdminAuthProvider())
        ],
        child :MaterialApp(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessengerKey,
          home: SplashScreen(),
        )
        );
  }
}

