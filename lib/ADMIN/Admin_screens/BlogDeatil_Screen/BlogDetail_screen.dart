import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {

  final String title;
  final String content;
  final String author;
  final String date;
  const BlogDetailScreen({super.key, required this.title, required this.content, required this.author, required this.date});

  @override
  Widget build(BuildContext context) {

    //main root of screen
    return Scaffold(
      backgroundColor: const Color(0xFFF4ECE6),

      //app bar
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4ECE6),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_rounded)
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          bool isMobile = constraints.maxWidth < 800;

          return Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 1100,
              ),

              padding: const EdgeInsets.all(20),

              child: SingleChildScrollView(
                child: Card(
                  elevation: 8,
                  shadowColor: Colors.black12,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(
                      isMobile ? 20 : 40,
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [

                        // BLOG TITLE
                        Text(
                          title,

                          style: TextStyle(
                            fontSize: isMobile ? 28 : 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 25),

                        // DATE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.orange.shade100,

                            borderRadius:
                            BorderRadius.circular(30),
                          ),

                          child: Row(
                            mainAxisSize: MainAxisSize.min,

                            children: [

                              const Icon(
                                Icons.calendar_month,
                                size: 20,
                                color: Colors.black87,
                              ),

                              const SizedBox(width: 8),

                              Flexible(
                                child: Text(
                                  date,
                                  overflow:
                                  TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    fontWeight:
                                    FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 35),

                        // CONTENT CARD
                        Card(
                          elevation: 0,
                          color: Colors.grey.shade100,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(24),

                            child: Text(
                              content,

                              style: TextStyle(
                                fontSize:
                                isMobile ? 16 : 18,

                                height: 1.8,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // AUTHOR SECTION
                        Card(
                          elevation: 0,
                          color: const Color(0xFFDDBEA9),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(20),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(20),

                            child: Row(
                              children: [

                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor:
                                  Colors.white,

                                  child: Icon(
                                    Icons.person,
                                    color: Colors.orange.shade700,
                                    size: 30,
                                  ),
                                ),

                                const SizedBox(width: 18),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                    children: [

                                      const Text(
                                        "Author",

                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        author,

                                        overflow:
                                        TextOverflow.ellipsis,

                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
