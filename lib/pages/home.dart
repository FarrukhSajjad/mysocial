import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mysocial/modals/user.dart';
import 'package:mysocial/pages/activity_feed.dart';
import 'package:mysocial/pages/profile.dart';
import 'package:mysocial/pages/search.dart';
import 'package:mysocial/pages/timeline.dart';
import 'package:mysocial/pages/upload.dart';

import 'create_account.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = FirebaseFirestore.instance.collection('users');
final timestamp = DateTime.now();
User currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handlesignIn(account);
    }).onError((err) {
      print('Error during Signing in: $err');
    });
    // googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   handlesignIn(account);
    // });s
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  createUserInFirestore() async {
    //check if user exists
    try {
      final GoogleSignInAccount userAccount = googleSignIn.currentUser;
      DocumentSnapshot doc = await usersRef.doc(userAccount.id).get();
      if (!doc.exists) {
        final username = await Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => CreateAccount()));

        usersRef.doc(userAccount.id).set({
          'id': userAccount.id,
          'username': username,
          'photoUrl': userAccount.photoUrl,
          'email': userAccount.email,
          'displayName': userAccount.displayName,
          'bio': '',
          'timestamp': timestamp,
        });

        doc = await usersRef.doc(userAccount.id).get();
      }
      currentUser = User.fromDocument(doc);
      print(currentUser.username);
    } catch (e) {}
  }

  handlesignIn(GoogleSignInAccount account) {
    try {
      if (account != null) {
        createUserInFirestore();
        setState(() {
          isAuth = true;
        });
      } else {
        setState(() {
          isAuth = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  int pageIndex = 0;

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  Widget buildAuthScreen() {
    return Scaffold(
      body: PageView(
        children: [
          // RaisedButton(
          //   onPressed: logout,
          //   child: Text('logout'),
          // ),
          Timeline(),
          ActivityFeed(),
          Upload(),
          Search(),
          Profile(),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        border: Border(
          top: BorderSide.none,
        ),
        backgroundColor: Colors.white,
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.red,
        inactiveColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.whatshot_outlined,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications_active_outlined,
              // color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.camera_alt,
              // color: Colors.black,
              size: 35.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              // color: Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              // color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  onTap(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.pinkAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Insta for Dumbs',
              style: TextStyle(
                fontFamily: 'Signatra',
                fontSize: 80,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: login,
              child: Container(
//width: 200,
                height: 65,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/google_signin_button.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
