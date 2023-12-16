import 'package:flutter/material.dart';
import 'package:litera_vibe/db/collections_db.dart';
import 'package:litera_vibe/db/storage/collections_info.dart';

import '../style.dart';
import 'book.dart';

class Post extends StatefulWidget {
    const Post({required this.book});

    final Book book;

    @override
    State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isLiked = false;

  @override
  void initState() {
    isLiked = CollectionInfo().isSaved(widget.book.id);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
  return InkWell(
    onTap: (){
      Navigator.of(context).pushNamed(
        '/book_page',
        arguments: widget.book,
      );
    },
    child: Card(
      color: Colors.mycolor3,
      child: Column(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              alignment: Alignment.center,
              child: Text(widget.book.name,
                style: TextStyle(
                    color: Colors.mycolor5,
                    fontSize: widget.book.name.length < 19 ? 20 : 15,
                    fontFamily: font,

                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Container(
                width: 160,
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.mycolor4,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      width: 160,
                      height: 200,
                      "${widget.book.imageUrl}"
                      // "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
                      // fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Icon(
                              Icons.star_border,
                              color: Colors.mycolor5,
                              size: 30,
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(widget.book.mark.toStringAsFixed(1),
                            style: TextStyle(
                                color: Colors.mycolor5,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        width: 30,
                        child: isLiked ?
                        IconButton(
                            onPressed: () async {
                              int status = await CollectionsDB().deleteLikedBook(widget.book.id);
                              if (status == 200) {
                                CollectionInfo().initCollections();
                                setState(() {
                                  isLiked = !isLiked;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.mycolor5,
                              size: 30,
                            )
                        )
                        : IconButton(
                          onPressed: () async {
                            int status = await CollectionsDB().likeBook(widget.book.id);
                            if (status == 200) {
                              CollectionInfo().initCollections();
                              setState(() {
                                isLiked = !isLiked;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.favorite_border,
                            color: Colors.mycolor5,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ]
              ),
            )
          ]
        ),
      ),
    );
  }
}
