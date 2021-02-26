import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mysocial/modals/user.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:mysocial/widgets/progress.dart';
import 'home.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<QuerySnapshot> searchResultsFuture;
  TextEditingController searchController = TextEditingController();

  handleSearch(String querey) {
    Future<QuerySnapshot> users =
        usersRef.where('displayName', isGreaterThanOrEqualTo: querey).get();

    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch() {
    searchController.clear();
    searchResults = null;
  }

  AppBar buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        onFieldSubmitted: handleSearch,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: 'Search for a user...',
          filled: true,
          prefixIcon: Icon(
            Icons.account_box_outlined,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            onPressed: clearSearch,
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  buildNoContent() {
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Image(
              image: Svg(
                'assets/images/search.svg',
                size: Size(300, 300),
              ),
              //s  height: 200,
            ),
            Text(
              'Find Users...',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 60.0,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<UserResult> searchResults = [];

  buildSearchResults() {
    return FutureBuilder<QuerySnapshot>(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          circularProgressBar();
        }

        snapshot.data.docs.forEach((element) {
          User user = User.fromDocument(element);
          UserResult searchresult = UserResult(user: user);
          searchResults.add(searchresult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildSearchField(),
      body:
          searchResultsFuture == null ? buildNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;
  UserResult({this.user});
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.redAccent.withOpacity(0.5),
      child: Column(
        children: [
          GestureDetector(
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.photoUrl),
                backgroundColor: Colors.grey,
                radius: 30,
              ),
              title: Text(
                user.username,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                user.displayName,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
