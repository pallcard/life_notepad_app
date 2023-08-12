import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provide/current_index.dart';
import 'nav/calendar_page.dart';
import 'nav/home_page.dart';
import 'nav/message_page.dart';
import 'nav/my_page.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  final bottomNavigationBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "首页",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: "日历",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.mail),
      label: "消息",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      label: "我的",
    ),
  ];

  final navigationItems = <Widget>[
    const HomaPage(),
    const CalendarPage(),
    const MessagePage(),
    const MyPage(),
  ];

  final navigationNames = ["首页", "日历", "消息", "我的"];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Consumer<CurrentIndexProvide>(
        builder: (ctx, currentIndex, child) => Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(navigationNames[currentIndex.currentIndex]),
              ),
              body: Center(
                child: PageTransitionSwitcher(
                  transitionBuilder: (child, animation, secondaryAnimation) {
                    return FadeThroughTransition(
                      animation: animation,
                      secondaryAnimation: secondaryAnimation,
                      child: child,
                    );
                  },
                  child: IndexedStack(
                    index: currentIndex.currentIndex,
                    children: navigationItems,
                  ),
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                showUnselectedLabels: true,
                items: bottomNavigationBarItems,
                currentIndex: currentIndex.currentIndex,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: textTheme.bodySmall!.fontSize!,
                unselectedFontSize: textTheme.bodySmall!.fontSize!,
                onTap: (index) {
                  currentIndex.changeIndex(index);
                },
                selectedItemColor: colorScheme.onPrimary,
                unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
                backgroundColor: colorScheme.primary,
              ),
            ));
  }
}

// class _TabInfo {
//   const _TabInfo(this.title, this.icon);
//
//   final String title;
//   final Icon icon;
// }
//
// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({
//     super.key,
//     // required this.restorationId,
//   });
//
//   // final String restorationId;
//
//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }
//
// class _BottomNavigationState extends State<BottomNavigation>
//     with RestorationMixin {
//   final RestorableInt _currentIndex = RestorableInt(0);
//
//   @override
//   // String get restorationId => widget.restorationId;
//
//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_currentIndex, 'bottom_navigation_tab_index');
//   }
//
//   @override
//   void dispose() {
//     _currentIndex.dispose();
//     super.dispose();
//   }
//
//   final tabInfo = [
//     const _TabInfo(
//       "首页",
//       Icon(Icons.home),
//     ),
//     const _TabInfo(
//       "日历",
//       Icon(Icons.calendar_today),
//     ),
//     const _TabInfo(
//       "消息",
//       Icon(Icons.mail),
//     ),
//     const _TabInfo(
//       "我的",
//       Icon(Icons.account_circle),
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//
//     var bottomNavigationBarItems = <BottomNavigationBarItem>[
//       const BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         label: "首页",
//       ),
//       const BottomNavigationBarItem(
//         icon: Icon(Icons.calendar_today),
//         label: "日历",
//       ),
//       const BottomNavigationBarItem(
//         icon: Icon(Icons.mail),
//         label: "消息",
//       ),
//       const BottomNavigationBarItem(
//         icon: Icon(Icons.account_circle),
//         label: "我的",
//       ),
//     ];
//
//     var navigationItems = <Widget>[
//       const HomaPage(),
//       const CalendarPage(),
//       const MessagePage(),
//       const MyPage(),
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(tabInfo[_currentIndex.value].title),
//       ),
//       body: Center(
//         child: PageTransitionSwitcher(
//           transitionBuilder: (child, animation, secondaryAnimation) {
//             return FadeThroughTransition(
//               animation: animation,
//               secondaryAnimation: secondaryAnimation,
//               child: child,
//             );
//           },
//           child: IndexedStack(
//             index: _currentIndex.value,
//             children: navigationItems,
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         showUnselectedLabels: true,
//         items: bottomNavigationBarItems,
//         currentIndex: _currentIndex.value,
//         type: BottomNavigationBarType.fixed,
//         selectedFontSize: textTheme.bodySmall!.fontSize!,
//         unselectedFontSize: textTheme.bodySmall!.fontSize!,
//         onTap: (index) {
//           setState(() {
//             _currentIndex.value = index;
//           });
//         },
//         selectedItemColor: colorScheme.onPrimary,
//         unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
//         backgroundColor: colorScheme.primary,
//       ),
//     );
//   }
// }
