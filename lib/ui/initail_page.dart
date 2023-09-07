import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_service_is_yours/bloc/bottom_bloc.dart';
import 'package:movie_service_is_yours/ui/catalog_page.dart';
import 'package:movie_service_is_yours/ui/favorites_page.dart';
import 'package:movie_service_is_yours/ui/home_page.dart';
import 'package:movie_service_is_yours/ui/profile_page.dart';
import 'package:movie_service_is_yours/ui/tv_channels_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomBloc, BottomState> (
        builder: (context, state) {
          if(state is ViewLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if(state is HomeLoaded) {
            return const MyHomePage();
          }
          if(state is CatalogLoaded) {
            return const CatalogPage();
          }
          if(state is FavoritesLoaded) {
            return const FavoritesPage();
          }
          if(state is TVLoaded) {
            return const TVChannelsPage();
          }
          if(state is ProfileLoaded) {
            return const ProfilePage();
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomBloc, BottomState> (
        builder: (context, state) {
          return NeonBottomNavigationBar(
            currentIndex: context.select((BottomBloc bloc) => bloc.currentIndex),
            onTap: (index) => context.read<BottomBloc>().add(ViewTapped(index: index)),
          );
        },
      ),
    );
  }
}



class NeonBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NeonBottomNavigationBar({super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTabBar(
      currentIndex: currentIndex,
      onTap: onTap,
      activeColor: Colors.white,
      inactiveColor: Colors.grey,
      backgroundColor: const Color.fromRGBO(35, 35, 38, 1),
      items: [
        buildBottomNavigationBarItem(Icons.home_outlined, 'Главная', 0),
        buildBottomNavigationBarItem(Icons.movie_filter_outlined, 'Каталог', 1),
        buildBottomNavigationBarItem(Icons.favorite_border_outlined, 'Мое', 2),
        buildBottomNavigationBarItem(Icons.tv_outlined, 'ТВ-каналы', 3),
        buildBottomNavigationBarItem(Icons.person_outlined, 'Профиль', 4),
      ],
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(IconData icon, String label, int index) {
    final isActive = currentIndex == index;
    final iconColor = isActive ? Colors.white : Colors.grey;

    return BottomNavigationBarItem(
      icon: Stack(
        children: [
          if (isActive)
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent,
                    blurRadius: 25.0,
                    spreadRadius: 2.0,
                  ),
                ],
                shape: BoxShape.circle,
              ),
            ),
          Icon(
            icon,
            size: 30,
            color: iconColor,
          ),
        ],
      ),
      label: label,
    );
  }
}


