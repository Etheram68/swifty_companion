import 'package:flutter/material.dart';
import '../widgets/ProfileWidget.dart';

class ProfilePage extends StatefulWidget {
  final user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => ProfileWidget();
}