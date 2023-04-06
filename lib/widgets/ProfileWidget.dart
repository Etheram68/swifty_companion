import 'package:flutter/material.dart';
import '../screens/Profile.dart';

class ProfileWidget extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user['login']),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Scrollbar(
              thumbVisibility: true,
              child: Column(
                children: [
                  _buildAvatar(),
                  _personalSection(),
                  _curriculumSection(),
                ],
              ),
            )
          ),
        )
      ),
    );
  }

  Widget _curriculumSection() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 30),
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0,3)
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.auto_awesome_sharp, size: 30),
              Text("Curriculum", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 300,
                    height: 20,
                    child: LinearProgressIndicator(
                      value: widget.user['cursus_users'][1]['level'],
                      backgroundColor: Colors.black26,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  ),
                  const Align(alignment: Alignment.topCenter,child: Text("Text"),),
                ],
              )
            ],
          )
        ],
      )
    );
  }

  Widget _personalSection() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0,3)
            )
          ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Wallet: ${widget.user['wallet']} ₳"),
              Text("Evaluation points: ${widget.user['correction_point']}")
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.account_box_rounded, size: 30),
              Text("Personal Info", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Email:"),
              Text("${widget.user['email']}", style: const TextStyle(fontStyle: FontStyle.italic))
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Name:"),
              Text("${widget.user['displayname']}", style: const TextStyle(fontStyle: FontStyle.italic))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: Offset(0,3)
              )
            ]
        ),
        child: CircleAvatar(
          radius: 100,
          foregroundImage: NetworkImage(widget.user['image']['versions']['large']),
        ),
      )
    );
  }

}