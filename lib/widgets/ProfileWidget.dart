import 'package:flutter/material.dart';
import '../screens/Profile.dart';

class ProfileWidget extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user['login']),
      ),
      body: const Center(
        child: Text("Page suivante"),
      ),
    );
  }
}