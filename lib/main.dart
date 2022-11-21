import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'providers/Api.dart';
import 'widgets/Companion.dart';


void main() async {
  await dotenv.load();
  Api provider = Api();
  await provider.getToken();
  runApp(const Companion());
}
