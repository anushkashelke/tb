import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timbrebells/Community/community_pageMain.dart';
import 'package:timbrebells/Screens/Add_post.dart';
import 'package:timbrebells/Home_Page/Home.dart';
import 'package:timbrebells/providers/Userprovider.dart';
import 'package:provider/provider.dart';
import 'package:timbrebells/Screens/Connect_screen.dart';

class BottombarWidget extends StatefulWidget {
  const BottombarWidget({Key? key}) : super(key: key);

  @override
  _BottombarWidgetState createState() => _BottombarWidgetState();
}

class _BottombarWidgetState extends State<BottombarWidget> {
  @override
  int current_page = 0;
  late PageController pageController;
  void initState() {
    super.initState();
    pageController = PageController();
    addUserData();
  }
  addUserData() async{
    UserProvider _userProvider= Provider.of(context,listen:false); //listen=false to use the Userprovider class only once
    //i.e. it will be called only once to store all data which is basically done in our Userprovider.dart
    await _userProvider.refreshUser(); //calling the refreshUser() function from UserProvider.dart
  }

  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigation_to_page(int page) {
    pageController.jumpToPage(page);
  }
  void whenPageChanged(int changed_page){
    setState(() {
      current_page=changed_page;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          children: [
            home_page(),
            CommunityPageMain(),
            Add_post(),
            Text('favorite'),
            ConnectScreen(),
          ],
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: whenPageChanged,
        ),
        bottomNavigationBar: CupertinoTabBar(
            //type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,

            //selectedItemColor: Colors.black,
            //showSelectedLabels: false,
            //showUnselectedLabels: false,
            iconSize: 35,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                    Icons.home,
                    color: current_page == 0 ? Colors.blue : Colors.white,
                  ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.supervisor_account_sharp,
                  color: current_page == 1 ? Colors.blue : Colors.white,
                ),
                label: 'community',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: current_page == 2 ? Colors.blue : Colors.white,
                  ),
                  label: 'add'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                    color: current_page == 3 ? Colors.blue : Colors.white,
                  ),
                  label: 'favorite'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.connect_without_contact,
                    color: current_page == 4 ? Colors.blue : Colors.white,
                  ),
                  label: 'connect'),
            ],
            onTap: navigation_to_page));
  }
}
