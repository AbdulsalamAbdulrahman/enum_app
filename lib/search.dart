import 'package:enum_app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Search extends StatefulWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String team;
  final String ephone;

  const Search(
      {Key? key,
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.team,
      required this.ephone})
      : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List dataList1 = [];

  Future getAccNo() async {
    Uri url = Uri.parse('https://kadirs.withholdingtax.ng/mobile/search.php');
    try {
      var response = await http.get(url);

      final List<dynamic> dataList = jsonDecode(response.body);
      // List.generate(0, (index) => {print(dataList[index])});

      setState(() {
        dataList1 = dataList;
      });
    } catch (e) {
      debugPrint('error');
    }
  }

  @override
  void initState() {
    getAccNo();
    super.initState();
  }

  void _runFilter(value) {
    List<dynamic> results = [];
    if (value.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = dataList1;
    } else {
      results = dataList1
          .where((user) =>
              user["phone"].toLowerCase().contains(value.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      dataList1 = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search Phone Number',
                  suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: dataList1.isNotEmpty
                  ? ListView.builder(
                      itemCount: dataList1.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(dataList1[index]["id"]),
                        color: Colors.green.shade900,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                            onTap: () =>
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage(
                                              fname: dataList1[index]['fname'],
                                              phone: dataList1[index]['phone'],
                                              mail: dataList1[index]['mail'],
                                              role: dataList1[index]['role'],
                                              nin: dataList1[index]['nin'] ??
                                                  "NA",
                                              id: widget.id,
                                              firstname: widget.firstname,
                                              lastname: widget.lastname,
                                              team: widget.team,
                                              ephone: widget.ephone,
                                            )),
                                    (route) => false),
                            leading: Text(dataList1[index]["role"],
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white)),
                            title: Text('${dataList1[index]["fname"]}',
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dataList1[index]['mail'] ?? "NA",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                Text(dataList1[index]['phone'] ?? "NA",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                Text(dataList1[index]['nin'] ?? "NA",
                                    style:
                                        const TextStyle(color: Colors.white)),
                              ],
                            )),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
