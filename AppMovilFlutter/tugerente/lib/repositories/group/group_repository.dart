import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugerente/connection/http.dart';
import 'package:tugerente/models/group_model.dart';

class GroupRepository {
  Future<dynamic> add({
    @required String name,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString('token');
    var data = {'name': name, 'token': token};
    var res = await Http().post(data, 'groups');
    var body = json.decode(res.body);
    return body;
    // var token = body['access_token'];
  }

  Future getgroups() async {
    var resp = await Http().gets('groups');
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<Group> groups = new List();

    if (decodedData == null) return [];

    if (decodedData['error'] != null) return [];
    var data = decodedData['data'];
    data.forEach((element) {
      var a = element['groupcode'];
      final groupTemp = Group.fromJson(element);
      groupTemp.groupcode = a;
      groups.add(groupTemp);
    });
    return groups;

    // var token = body['access_token'];
  }
}
