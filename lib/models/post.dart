import 'package:flutter/material.dart';

        import '../style.dart';
        import 'book.dart';
    class Post extends StatefulWidget {
    const Post({required this.book});

    final Book book;

    @override
    State<Post> createState() => _PostState();
    }

    class _PostState extends State<Post> {
    // book get => widget.book;

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
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(widget.book.name,
                  style: TextStyle(
                      color: Colors.mycolor5,
                      fontSize: 15,
                      fontFamily: font
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  width: 160,
                  height: 180,
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
                        height: 160,
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxjLYTFNXwui-lMM7PeA9eS-ebbA9mxsk3xwTseXNxJoqVwEOZ4ViBKXr-iPwxzxhsVhw&usqp=CAU",
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
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
                          child: Text(widget.book.mark.toString(),
                            style: TextStyle(
                                color: Colors.mycolor5,
                                fontSize: 18
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.favorite_border, color: Colors.mycolor5, size: 30,),
                    )
                  ]
              )
            ]
        ),
      ),
    );
  }
}
