import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() =>
      __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For the To do task hint: consider defining the widget and name of the
    // tabs here
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];
    final icons = [
          Icons.mail,
          Icons.music_note,
          Icons.camera,
          Icons.settings,
    ];


    return Scaffold (
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tabs Demo',
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // hint for the to do task:Considering creating the different for
          // different tabs
          tab01(context),
          tab02(),
          tab03(context),
          
          Container(
            color: Colors.lime.shade50,
            child: ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: 4,
              itemBuilder: (context, index){
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      
                      backgroundColor: Colors.amberAccent,
                      child: Icon(icons[index]),
                    ),
                    title: Text(
                      'App #${index+1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('This is app #${index+1}'),
                    trailing: Icon ( Icons.arrow_forward_ios, size: 16),
                    onTap: () {/* Handle Tap */},
                  ),
                );
              },
            ),
          )
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 232, 196, 87),
        child: Padding(
          padding: EdgeInsets.symmetric (
            horizontal: 16.0, vertical: 12.0
          ),
          child: Row(
            children: [
              Icon(Icons.home_filled, color: Colors.greenAccent),
              SizedBox(width: 15,),
              Text (
                'Bottom App Bar',
                style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
    );
  }

  Widget tab01 (BuildContext context) {
    return Container(
      color: Colors.blueAccent.shade100,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Style for the text widget
            Text(
              'Tab 1 Text',
              style:  TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),

            // This is the button for the alerts
            ElevatedButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: ( _) => AlertDialog(
                    title: Text ('Tab 1 - Alert!'),
                    actions: [
                      TextButton(
                        // This handles the action after pressing the button
                        onPressed: () => Navigator.pop(context),
                        child: Text('close'),
                      )
                    ],
                  ),
                );
              },
              child: Text('Reveal Alert Text'),
            )
          ],
        ),
      ),
    );
  }

  Widget tab02 (){
    return Container(
      color: Colors.lightGreen,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              //This is where Input goes
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12,),

              //Text Box #2!
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox( height: 24),

              //Image link
              Image.network(
                'https://toppng.com/uploads/preview/jotaro-kujo-jojos-bizarre-adventure-jotaro-pose-11562875415vvptnvmowd.png',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
              Text(
                'Jotaro Kujo',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tab03 (BuildContext context){
    return Container(
      color: Colors.tealAccent.shade400,
      child: Center(
        child: ElevatedButton(
          onPressed: (){
            final snakbar = SnackBar(
                content: Text('This isn\'t the SnackBar Message! (It is.)'),
                behavior: SnackBarBehavior.floating,

                //Instead of duration I'll use manual dismiss
                action: SnackBarAction(
                  label: 'dismiss',
                  onPressed: () {},
                )
              );
              
            ScaffoldMessenger.of(context).showSnackBar(snakbar);
          },
          child: Text('Don\'t Click me. (Do it)'),
        ),
      ),
    );
  }

  Widget tab04(BuildContext context){
    return MaterialApp(
      title: 'idk',
      home: Scaffold(
        body: ListView(
          children: [
            ListTile(leading: Icon(Icons.mail), title: const Text('Mail')),
            ListTile(leading: Icon(Icons.earbuds), title: const Text('Music')),
          
          ],
        ),
      ),
    );
  }
}
