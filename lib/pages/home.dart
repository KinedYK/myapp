import 'package:flutter/material.dart';
import 'package:myapp/widgets/page_view_scroll_utils.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {

  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffff7f7f7),
      appBar: AppBar(
        backgroundColor: Color(0xffff7f7f7),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('home', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
        },
        children: <Widget>[
          NestedTabBar(_pageController),
          NestedTabBar(_pageController),
          NestedTabBar(_pageController),
        ],
      ),
      bottomNavigationBar: TabBar(
        indicatorColor: Colors.teal,
        labelColor: Colors.teal,
        unselectedLabelColor: Colors.black54,
        controller: _tabController,
        onTap: (index) {
          _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        tabs: <Widget>[
          Tab(icon: Icon(Icons.home),),
          Tab(icon: Icon(Icons.email),),
          Tab(icon: Icon(Icons.settings),),
      ],),
    );
  }

}

class NestedTabBar extends StatefulWidget {
  final PageController pageController;

  NestedTabBar(this.pageController);

  @override
  _NestedTabBarState createState() => _NestedTabBarState();
  
}

class _NestedTabBarState extends State<NestedTabBar> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _nestedTabController;
  PageViewScrollUtils _pageViewScrollUtils;

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 5, vsync: this);
    _pageViewScrollUtils = PageViewScrollUtils(widget.pageController, _nestedTabController);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: Colors.teal,
          labelColor: Colors.teal,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: "One",
            ),
            Tab(
              text: "Two",
            ),
            Tab(
              text: "Three",
            ),
            Tab(
              text: "Four",
            ),
            Tab(
              text: "Five",
            ),
          ],
        ),
        Expanded (
          child: NotificationListener<ScrollNotification>(
            onNotification: _pageViewScrollUtils.handleNotification,
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.orangeAccent,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.greenAccent,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.indigoAccent,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}