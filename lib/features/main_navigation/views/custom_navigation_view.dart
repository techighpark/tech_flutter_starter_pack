import 'package:dev_app_1/constants/gaps.dart';
import 'package:dev_app_1/constants/sizes.dart';
import 'package:dev_app_1/features/main_navigation/views/stfScreen.dart';
import 'package:dev_app_1/features/main_navigation/widgets/nav_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// [Offstage]
class CustomNavigationView extends StatefulWidget {
  static String routeUrl = '/customNav';
  static String routeName = 'customNav';
  const CustomNavigationView({Key? key}) : super(key: key);
  @override
  State<CustomNavigationView> createState() => _CustomNavigationViewState();
}

class _CustomNavigationViewState extends State<CustomNavigationView> {
  int _selectedIndex = 0;

  /// 화면 이동시 dispose 된다
  /// GlobalKey() 없으면 모든 페이지가 동일
  /// 1번 페이지 보다가 다른 페이지 다녀오면 초기화되어 있음
  /// 내가 만들고자 하는 view에 따라 문제가 될 수도 있고 아닐 수도 있음
  /// 다른 view를 보더라도 kill 시키지는 않아야 한다 -> [Offstage]
  final stlViews = [
    StfScreen(key: GlobalKey()),
    StfScreen(key: GlobalKey()),
    Container(),
    StfScreen(key: GlobalKey()),
    StfScreen(key: GlobalKey()),
  ];

  final views = [
    const Center(
      child: Text('First'),
    ),
    const Center(
      child: Text('Second'),
    ),
    const Center(
      child: Text('XXX'),
    ),
    const Center(
      child: Text('Fourth'),
    ),
    const Center(
      child: Text('Fifth'),
    ),
  ];

  void _onTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  /// [Scaffold] 한번에 한 화면만 그림
  /// 우리가 원하는 건 화면을 그리지만 사용자에게 시각적으로 보이지 않게 하는 것(화면은 alive~) -> [Stack] + [Offstage]
  /// [Offstage] = Creates a widget that visually hides its child.
  /// [Offstage]->[offstage] = false => visible
  /// [Offstage]->[offstage] = true => invisible
  /// [Offstage] -> [children] 너무 많이 사용하면 안된다!!
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Navigation'),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: StfScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: StfScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        padding: const EdgeInsets.all(Sizes.size12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavTab(
              text: 'Home',
              isSelected: _selectedIndex == 0,
              icon: CupertinoIcons.camera_on_rectangle,
              onTap: () => _onTap(0),
            ),
            NavTab(
              text: 'device_phone',
              isSelected: _selectedIndex == 1,
              onTap: () => _onTap(1),
              icon: CupertinoIcons.device_phone_portrait,
            ),
            NavTab(
              text: 'option',
              isSelected: _selectedIndex == 3,
              onTap: () => _onTap(3),
              icon: CupertinoIcons.option,
            ),
            NavTab(
              text: 'keyboard',
              isSelected: _selectedIndex == 4,
              onTap: () => _onTap(4),
              icon: CupertinoIcons.keyboard,
            )
          ],
        ),
      ),
    );
  }
}
