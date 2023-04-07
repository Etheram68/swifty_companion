import 'package:flutter/material.dart';
import '../screens/Profile.dart';
import 'dart:core';

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
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildAvatar(),
                  _personalSection(),
                  _projectsSection(),
                  _curriculumSection(),
                ],
              ),
            )
          ),
        )
      ),
    );
  }

  Widget _buildListItem(int index, Iterable finishedProjects) {
    final project = finishedProjects.elementAt(index);
    Color color = project['validated?'] ? Colors.green : Colors.red;

    return ListTile(
      trailing: Text(
    project['final_mark'].toString(),
        style: TextStyle(color: color),
      ),
      title: Text(project['project']['name']),
    );
  }

  Widget _curriculumSection() {
    List projects = widget.user['projects_users'];
    Iterable finishedProjects = projects.where((element) => element['status'] == 'finished');

    return Container(
        constraints: const BoxConstraints(maxHeight: 600),
        padding: const EdgeInsets.only(top: 10, bottom: 30),
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 30),
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
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.assessment_rounded, size: 30),
                    Text("Curriculum", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => _buildListItem(index, finishedProjects),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: finishedProjects.length
                ),
              ],
            ),
          ),
        )
    );
  }

  Widget _projectsSection() {
    List projects = widget.user['projects_users'];
    Iterable ongoingProjects = projects.where((element) => element['status'] != 'finished');

    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
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
              Text("Project In Progress", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          ListView.separated(
            shrinkWrap: true,
            itemCount: ongoingProjects.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                  child: Text(ongoingProjects.elementAt(index)['project']['name'])
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          )
        ],
      )
    );
  }

  Widget _personalSection() {
    return Container(
      padding: const EdgeInsets.only(top:10, bottom: 30, right: 30, left: 30),
      margin: const EdgeInsets.only(right: 10, left: 10),
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
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
                widget.user['cursus_users'][1]['user']['location'] ?? "",
                textScaleFactor: 1.2,
                style: const TextStyle(fontWeight: FontWeight.bold)
            ),
          ),
          Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 300,
                  height: 20,
                  child: LinearProgressIndicator(
                    value: (widget.user['cursus_users'][1]['level'] % 1),
                    backgroundColor: Colors.black26,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
              ),
              Align(alignment: Alignment.topCenter,child: Text(widget.user['cursus_users'][1]['level'].floor().toString()),),
            ],
          ),
          const SizedBox(height: 10),
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
        margin: const EdgeInsets.only(top: 10),
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