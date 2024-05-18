import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class FamilyTreeViewPageFromJson extends StatefulWidget {
  @override
  _FamilyTreeViewPageFromJsonState createState() =>
      _FamilyTreeViewPageFromJsonState();
}

class _FamilyTreeViewPageFromJsonState
    extends State<FamilyTreeViewPageFromJson> {
  var json = {
    'nodes': [
      {
        'id': 1,
        'label': 'Kantilal',
        'spouse': 'Lata',
        'children': [3, 4, 5]
      },
      {'id': 2, 'label': 'Manavv'},
      {
        'id': 3,
        'label': 'Bhupendra',
        'spouse': 'Sonal',
        'children': [2]
      },
      {
        'id': 4,
        'label': 'Paresh',
        'spouse': 'Archana',
        'children': [6, 7]
      },
      {
        'id': 5,
        'label': 'Pranju',
        'spouse': 'Rajiv',
        'children': [8, 9]
      },
      {'id': 6, 'label': 'Mihir'},
      {'id': 7, 'label': 'Apurva'},
      {'id': 8, 'label': 'Neerav', 'spouse': "Spouse"},
      {'id': 9, 'label': 'Harshit'},
      {
        'id': 10,
        'label': 'Shankarlal',
        'spouse': "Spouse",
        'children': [1, 11, 12]
      },
      {
        'id': 11,
        'label': 'Mohanlal',
        'spouse': "Kamalben",
        'children': [14, 17]
      },
      {
        'id': 12,
        'label': '---',
        'spouse': "Hansaben",
        'children': [13, 21]
      },
      {
        'id': 13,
        'label': 'Jeetendra',
        'spouse': "Mamta",
        'children': [19, 20]
      },
      {
        'id': 14,
        'label': 'Ashish',
        'spouse': "Sunita",
        'children': [15, 16]
      },
      {'id': 15, 'label': 'Nihar'},
      {'id': 16, 'label': 'Nikunj'},
      {
        'id': 17,
        'label': 'Rajuben',
        'spouse': 'Fuaji',
        'children': [18]
      },
      {'id': 18, 'label': 'Amrish'},
      {'id': 19, 'label': 'Nikhlesh'},
      {'id': 20, 'label': 'Saloni'},
      {
        'id': 21,
        'label': 'Shailesh',
        'spouse': 'Parnika',
        'children': [22, 23]
      },
      {'id': 22, 'label': 'Parth'},
      {'id': 23, 'label': 'Suhani'},
    ],
  };

  final Graph graph = Graph()..isTree = true;
  FamilyTreeBuchheimWalkerConfiguration builder =
      FamilyTreeBuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    var nodes = json['nodes']!;
    nodes.forEach((element) {
      var id = element['id'];
      graph.addNode(FamilyNode(id, element['spouse'] != null));
    });
    nodes.forEach((element) {
      var id = element['id'];
      var children = element['children'] as List<int>?;
      children?.forEach((child) {
        graph.addEdge(Node.Id(id), Node.Id(child));
      });
    });

    builder = FamilyTreeBuchheimWalkerConfiguration(
      spouseSeparation: 10,
      siblingSeparation: 20,
      levelSeparation: 30,
      subtreeSeparation: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox.expand(
          child: InteractiveViewer(
              constrained: false,
              boundaryMargin: EdgeInsets.all(double.infinity),
              minScale: 0.2,
              maxScale: 2.5,
              child: GraphView(
                graph: graph,
                algorithm: BuchheimWalkerAlgorithm(
                    builder, FamilyTreeEdgeRenderer(builder)),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 3
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  var a = node.key!.value as int?;
                  var nodes = json['nodes']!;
                  var nodeValue =
                      nodes.firstWhere((element) => element['id'] == a);
                  print("Rerendering");
                  return rectangleWidget(nodeValue['label'] as String?,
                      nodeValue["spouse"] as String?);
                },
              )),
        ));
  }

  Widget nodeWidget(String? a) {
    return InkWell(
      onTap: () {
        print('clicked');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        width: 150,
        height: 130,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.info_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  minRadius: 30,
                ),
                Spacer(),
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.account_tree_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            FittedBox(
              child: Text(
                a ?? '',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                softWrap: true,
                maxLines: 2,
              ),
            ),
            Spacer(),
            FittedBox(
              child: Text('3rd ',
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            FittedBox(
              child: Text('21 ',
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget rectangleWidget(String? a, String? spouse) {
    return Row(
      children: [
        nodeWidget(a),
        if (spouse != null) ...[
          SizedBox(
            width: builder.spouseSeparation.toDouble(),
            child: Divider(
              thickness: 5,
              color: Colors.blue,
            ),
          ),
          nodeWidget(spouse),
        ],
      ],
    );
  }
}
