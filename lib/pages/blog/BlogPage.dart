import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'DetailBlogPage.dart';
import 'package:intl/intl.dart';

class BlogListPage extends StatefulWidget {
  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  List<BlogItem> blogItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
  }

  Future<void> _fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse('https://api.spaceflightnewsapi.net/v4/blogs/'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final blogResults = data['results'] as List;
        setState(() {
          blogItems = blogResults.map((blog) => BlogItem.fromJson(blog)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load blogs');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to fetch blog items'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: Text('Artikel Terkini'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: blogItems.length,
          itemBuilder: (context, index) {
            final blog = blogItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailPage(blogId: blog.id),
                  ),
                );
              },
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                      child: blog.imageUrl != null
                          ? Image.network(
                        blog.imageUrl!,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      )
                          : Container(
                        height: 150,
                        color: Colors.grey[300],
                        child: Center(child: Text('No Image')),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            blog.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            blog.summary ?? 'No summary available',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.0,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8.0),
                          Row(
                            children: [
                              Text(
                                blog.newsSite,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.0,
                                ),
                              ),
                              Spacer(),
                              SizedBox(height: 20),
                              Text(
                                DateFormat('MMMM d, yyyy').format(DateTime.parse(blog.publishedAt)),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BlogItem {
  final String id;
  final String title;
  final String? summary;
  final String? imageUrl;
  final String newsSite;
  final String publishedAt;
  final String? url;

  BlogItem({
    required this.id,
    required this.title,
    this.summary,
    this.imageUrl,
    required this.newsSite,
    required this.publishedAt,
    required this.url,
  });

  factory BlogItem.fromJson(Map<String, dynamic> json) {
    return BlogItem(
      id: json['id'].toString(),
      title: json['title'],
      summary: json['summary'],
      imageUrl: json['image_url'],
      newsSite: json['news_site'],
      publishedAt: json['published_at'],
      url: json['url'],
    );
  }
}