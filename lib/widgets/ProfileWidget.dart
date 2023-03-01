import 'package:flutter/material.dart';
import 'dart:async';
import '../providers/Api.dart';
import '../screens/Profile.dart';

class ProfileWidget extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.login),
      ),
      body: const Center(
        child: Text("Page suivante"),
      ),
    );
  }
}