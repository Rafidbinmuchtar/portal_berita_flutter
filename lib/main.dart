import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rekomendasi Musik',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> recommendations = [];

  final List<Map<String, dynamic>> genres = [
    {"name": "Lo-fi", "tempo": 1, "energy": 1, "mood": 2},
    {"name": "Jazz", "tempo": 2, "energy": 2, "mood": 2},
    {"name": "Classical", "tempo": 1, "energy": 1, "mood": 3},
    {"name": "EDM", "tempo": 3, "energy": 3, "mood": 1},
    {"name": "Hip-hop", "tempo": 3, "energy": 3, "mood": 1},
    {"name": "Acoustic", "tempo": 1, "energy": 1, "mood": 3},
    {"name": "Indie", "tempo": 2, "energy": 2, "mood": 3},
    {"name": "Ambient", "tempo": 1, "energy": 1, "mood": 3},
  ];

  Map<String, int> getProfile(String activity) {
    if (activity == "Belajar") {
      return {"tempo": 1, "energy": 1, "mood": 2};
    } else if (activity == "Olahraga") {
      return {"tempo": 3, "energy": 3, "mood": 1};
    } else {
      return {"tempo": 1, "energy": 1, "mood": 3};
    }
  }

  double similarity(Map<String, int> a, Map<String, int> b) {
    return (a["tempo"]! * b["tempo"]! +
        a["energy"]! * b["energy"]! +
        a["mood"]! * b["mood"]!).toDouble();
  }

  void recommend(String activity) {
    var user = getProfile(activity);

    List<Map<String, dynamic>> result = [];

    for (var g in genres) {
      double score = similarity(user, {
        "tempo": g["tempo"],
        "energy": g["energy"],
        "mood": g["mood"]
      });

      result.add({"name": g["name"], "score": score});
    }

    result.sort((a, b) => b["score"].compareTo(a["score"]));

    setState(() {
      recommendations =
          result.take(3).map((e) => e["name"].toString()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rekomendasi Musik")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Pilih Aktivitas", style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),

            ElevatedButton(
                onPressed: () => recommend("Belajar"),
                child: Text("Belajar")),
            ElevatedButton(
                onPressed: () => recommend("Olahraga"),
                child: Text("Olahraga")),
            ElevatedButton(
                onPressed: () => recommend("Santai"),
                child: Text("Santai")),

            SizedBox(height: 20),
            Text("Rekomendasi:", style: TextStyle(fontSize: 18)),

            ...recommendations.map((e) => Text("- $e")).toList(),
          ],
        ),
      ),
    );
  }
}