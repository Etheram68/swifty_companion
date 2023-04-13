import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/Profile.dart';
import 'dart:core';

class ProfileWidget extends State<ProfilePage> {
  int curNum = 0;

  @override
  Widget build(BuildContext context) {
    curNum = (widget.user["cursus_users"].length != 0) ?
        widget.user["cursus_users"].length - 1 : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user['login']),
      ),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildAvatar(),
                _personalSection(),
                _skills(),
                _projectsSection(),
                _curriculumSection(),
              ],
            ),
          )
        )
      ),
    );
  }
  
  Widget _skills() {
    if (widget.user['cursus_users'].length == 0 ||
          widget.user['cursus_users'][curNum]['skills'].length == 0) {
      return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
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
        child: const Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_rounded, size: 30),
                  Text("School Skills", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ]
        ),
      );
    }
    const ticks = [0, 5, 10, 15, 20];
    List<String> features = [];
    widget.user['cursus_users'][curNum]['skills'].forEach((obj) => features.add(obj['name']));
    List<num> value = [];
    widget.user['cursus_users'][curNum]['skills'].forEach((obj) => value.add(obj['level']));
    var data = [value];

    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
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
          const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart_rounded, size: 30),
              Text("School Skills", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(child:
            RadarChart(ticks: ticks, features: features, data: data,
              featuresTextStyle: const TextStyle(
                  fontSize: 10,
                  color: Colors.black
              ),
              graphColors: const [
                Colors.amber,
                Colors.green,
                Colors.blue,
                Colors.red,
                Colors.orange
              ],
            ),
          )
        ],
      )
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
    Iterable finishedProjects = projects.where((element) =>
        element['status'] == 'finished' && element['final_mark'] != null);

    return Container(
        constraints: const BoxConstraints(maxHeight: 500),
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
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assessment_rounded, size: 30),
                    Text("Curriculum", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
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
          const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome_sharp, size: 30),
              Text("Project In Progress", textScaleFactor: 1.2, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
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

  Widget _coalition(colorCoa) {
    if (widget.user['coalitions'].length == 0) {
      return const Row();
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.network(
          widget.user['coalitions'][0]['image_url'],
          width: 30,
          height: 30,
          colorFilter: ColorFilter.mode(colorCoa, BlendMode.srcIn),
        ),
        Text("Coalitions: ${widget.user['coalitions'][0]['name']}"),
      ],
    );
  }

  Widget _personalSection() {
    String colorHex = (widget.user['coalitions'].length > 0) ?
        widget.user['coalitions'][0]['color'] : "ffc107";
    Color colorCoa = Color(int.parse(colorHex.replaceAll("#", "ff"), radix: 16));
    double level = (widget.user['cursus_users'].length != 0) ?
        widget.user['cursus_users'][curNum]['level'] : 0.0;

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
                widget.user['location'] ?? "",
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
                    value: (level % 1),
                    backgroundColor: Colors.black26,
                    valueColor: AlwaysStoppedAnimation<Color>(colorCoa),
                  ),
                ),
              ),
              Align(alignment: Alignment.topCenter,child: Text(level.floor().toString()),),
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
          _coalition(colorCoa),
          const SizedBox(height: 10),
          const Divider(),
          const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
    dynamic image = const AssetImage('img/avatar-default.png');
    if (widget.user['image']['versions']['large'] != null) {
      image = NetworkImage(widget.user['image']['versions']['large']);
    }

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
          foregroundImage: image,
        ),
      )
    );
  }

}