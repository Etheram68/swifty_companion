import 'package:flutter/material.dart';
import '../widgets/ProfileWidget.dart';

class ProfilePage extends StatefulWidget {
  final login;
  const ProfilePage({super.key, required this.login});

  @override
  State<ProfilePage> createState() => ProfileWidget();
}