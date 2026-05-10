//Blog model to extract data in MAP form

class BlogModel {

  String id ,userId,title,des,status,author;
  DateTime createAt;

  BlogModel(this.id,this.userId,this.title,this.des,this.status,this.createAt,this.author);

  //factory contractor

  factory BlogModel.fromMap(map)=> BlogModel(
      map['id'],
      map['userId'],
      map['title'],
      map['des'],
      map['status'],
      DateTime.parse(map['createAt']),
      map['author'] ?? 'Unknown author'
  );

  //MAP finction

  Map<String,dynamic> toMap()=>{

    'id':id,
    'userId':userId,
    'title':title,
    'des':des,
    'status':status,
    'createAt': createAt.toString(),
    'author': author
  };
}