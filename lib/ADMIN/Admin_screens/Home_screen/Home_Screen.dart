import 'package:blog_admin_side/ADMIN/Data/Admin_provider/AdminAuth_provider.dart';
import 'package:blog_admin_side/Widgets/home_screen_widget/HomeScreen_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Data/models/Blog_model/Blog_mddel.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  FirebaseFirestore db=FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    //main root of screen

    return Scaffold(
        backgroundColor: const Color(0xFFF4ECE6),

        //body with safe area
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),

                child: Column(
                    children: [

                      //TOP BAR
                      Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                          children: [

                            // LOGO with text
                            Expanded(
                              child: Row(
                                children: [

                                  const Icon(
                                    Icons.auto_awesome,
                                    color: Colors.greenAccent,
                                  ),

                                  const SizedBox(width: 8),

                                  const Text(
                                    "Mir_Blogs",

                                    style: TextStyle(
                                      color: Colors.greenAccent,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  //Spacer

                                  Spacer(),

                                   //PopUpMenu Button
                                  
                                   PopupMenuButton(
                                       itemBuilder: (context)=>[
                                       PopupMenuItem(
                                   child:
                                   //LogOut Button with loading

                                   Provider.of<AdminAuthProvider>(context,listen: false).isLoading? CircularProgressIndicator():
                                   TextButton.icon(
                                       onPressed: (){
                                         Provider.of<AdminAuthProvider>(context,listen: false).signOut(context);
                                       },
                                       icon: const Icon(Icons.login_outlined),
                                       label: const Text('SignOut')
                                   )
                                  ),
                                       //About section

                                         PopupMenuItem(
                                             child: Text('About v1.0')
                                         )
                                       ]
                                   )
                                ],
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(height: 35),

                      // TITLE
                      const Align(
                        alignment: Alignment.centerLeft,

                        child: Text(
                          "Admin Side",

                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      //LayOut Builder with constraints

                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {

                            int crossAxisCount = 1;

                            if (constraints.maxWidth > 1200) {
                              crossAxisCount = 4;
                            } else if (constraints.maxWidth > 900) {
                              crossAxisCount = 3;
                            } else if (constraints.maxWidth > 600) {
                              crossAxisCount = 2;
                            } else {
                              crossAxisCount = 1;
                            }

                            //use stream builder for immediately action

                            return StreamBuilder(
                                stream: db.collection('Blogs').snapshots(),
                                builder: (context,snapshot) {

                                  // LOADING state
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return const Center(child: CircularProgressIndicator(),
                                    );
                                  }

                                  // EMPTY state
                                  if(!snapshot.hasData || snapshot.data!.docs.isEmpty){

                                    return const Center(
                                      child: Text(
                                        "No Blogs Found",

                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    );
                                  }

                                  // DATA
                                  final blogs = snapshot.data!.docs
                                      .map((e) => BlogModel.fromMap(
                                    e.data(),
                                  ))
                                      .toList();

                                  //show in grid view form

                                  return GridView.builder(
                                    padding: const EdgeInsets.all(20),

                                    itemCount: blogs.length,

                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      childAspectRatio: 1.2,
                                    ),

                                    itemBuilder: (context, index) {

                                      final blog = blogs[index];

                                      //separate  HomescreenWidget
                                      return HomescreenWidget(
                                        blog: blog,

                                      );
                                    },
                                  );
                                }
                            );
                          },
                        ),
                      )
                    ]
                )
            )
        )
    );
  }
}
