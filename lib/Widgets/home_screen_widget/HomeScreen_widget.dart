import 'package:blog_admin_side/ADMIN/Admin_screens/BlogDeatil_Screen/BlogDetail_screen.dart';
import 'package:blog_admin_side/ADMIN/Data/models/Blog_model/Blog_mddel.dart';
import 'package:blog_admin_side/Widgets/home_screen_widget/Button_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomescreenWidget extends StatelessWidget {

  //get Blog Model to get data
  final BlogModel blog;

  const HomescreenWidget({super.key, required this.blog, });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_)=> BlogDetailScreen(
            title: blog.title, content: blog.des, author: blog.author, date: DateFormat('dd MMM yyyy').format(blog.createAt))));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          // set customize gradient
          gradient: LinearGradient(
            colors: [
              Colors.green.withOpacity(0.25),
              Colors.black.withOpacity(0.85),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          border: Border.all(
            color: Colors.green.withOpacity(0.2),
          ),
        ),

        padding: const EdgeInsets.all(18),

        //Blog data

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // TITLE & author
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    blog.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                //Author
                Icon(Icons.person,color: Colors.greenAccent.shade100,),
                Expanded(child: Text(blog.author))
              ],
            ),

            const SizedBox(height: 10),

            // DESCRIPTION
            Text(
              blog.des,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: TextStyle(
                height: 1.5,
              ),
            ),

            const SizedBox(height: 14),

            // DATE
            Row(
              children: [

                Icon(
                  Icons.access_time_rounded,
                  color: Colors.greenAccent.shade100,
                  size: 16,
                ),

                const SizedBox(width: 6),

                Text(
                  DateFormat('dd MMM yyyy').format(blog.createAt),
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            Divider(),

            SizedBox(height: 20,),

            //Status Buttons with visibility
            Expanded(
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Approved Button

                  Visibility(
                    visible: blog.status !='approved',
                    child: ButtonWidget(
                      onTap: (){
                        FirebaseFirestore.instance.collection('Blogs').doc(blog.id).update({
                          'status':'approved'
                        });
                      },
                      text: 'Approved',
                      color: Colors.green,
                    ),
                  ),

                  //Reject Button

                  Visibility(
                    visible: blog.status !='rejected',
                    child: ButtonWidget(
                      onTap: (){
                        FirebaseFirestore.instance.collection('Blogs').doc(blog.id).update({
                          'status':'rejected'
                        });
                      },
                      text: 'Rejected',
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
