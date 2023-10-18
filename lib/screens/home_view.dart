import 'package:chitchatappbymehdinathani/screens/chat_page.dart';
import 'package:chitchatappbymehdinathani/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //instance of firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign out
  void signOut() async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    authservice.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          actions: [
            IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
          ],
        ),
        body: _buildUsersList());
  }

  // build a list of users except the current logged user
  Widget _buildUsersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("user").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUsersListItem(doc))
              .toList(),
        );
      },
    );
  }

  Widget _buildUsersListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // display all users data except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email'].toString()),
        onTap: () {
          // pass the clicked user's uid to the chat page.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiveruserEmail: data['email'],
                receiveruserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
