import 'package:flutter/material.dart';
import 'package:onegid/components/post.dart';
import 'package:onegid/services/fetchPosts.dart';

class Posts extends StatelessWidget{
  Posts({super.key});

  late final List<Post> posts = getPosts();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage('assets/images/add.png'))
        ),
        child: InkWell(
          onTap: () => getPosts()
          // onTap: () => Navigator.pushNamed(context, '/addPost')
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              alignment: Alignment.centerLeft,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: const DecorationImage(image: AssetImage('assets/images/top_img.png'))
              ),
              child: const Padding(
                padding: EdgeInsets.only(left: 30, top: 70),
                child: Text('ИНТЕРЕСНЫЕ\nПОСТЫ', style: TextStyle(fontSize: 35, color: Colors.black87))
              )
            ),
          ),
          Expanded(
            flex: 7,
            child: ListView(
              children: const [
                Row(
                    children: [
                      Post(title: 'Post', image: ''),
                      Post(title: 'Post', image: '')
                    ],
                  ),
                  Row(
                    children: [
                      Post(title: 'Post', image: ''),
                      Post(title: 'Post', image: '')
                    ],
                  ),
                  Row(
                    children: [
                      Post(title: 'Post', image: ''),
                      Post(title: 'Post', image: '')
                    ],
                  ),
                  Row(
                    children: [
                      Post(title: 'Post', image: ''),
                      Post(title: 'Post', image: '')
                    ],
                  ),
                  Row(
                    children: [
                      Post(title: 'Post', image: ''),
                      Post(title: 'Post', image: '')
                    ],
                  ),
              ],
            )
          )
          
        ],
      ),
    );
  }
}