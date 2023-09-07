import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_service_is_yours/bloc/movie_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Color> _indicatorColors = List.generate(4, (index)
  => index == 0 ? const Color.fromRGBO(151, 71, 255, 1) : Colors.white.withOpacity(0.1));

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  void updateIndicatorColor() {
    for (int index = 0; index < 4; index++) {
      if (index == _currentPage) {
        _indicatorColors[index] = const Color.fromRGBO(151, 71, 255, 1);
      } else {
        _indicatorColors[index] = Colors.white.withOpacity(0.1);
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<MovieBloc>(context).add(FetchMovieEvent());
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
        updateIndicatorColor();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieBloc, MovieState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedState) {
            final data = state.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Stack(children: [
                  SizedBox(
                    height: 488,
                    child: PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return ShaderMask(
                              shaderCallback: (Rect rect) {
                                return const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [Colors.black, Colors.transparent],
                                ).createShader(rect);
                              },
                              blendMode: BlendMode.dstOut,
                              child: Image.asset(
                                  data.imageUrls,
                                  fit: BoxFit.fitHeight,
                              ));
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 334, left: 16, right: 16),
                    child: Column(
                      children: [
                        Center(child: Image.asset('assets/images/image.png')),
                        const SizedBox(height: 16),
                        Text(data.textData, style: const TextStyle(color: Colors.white, fontSize: 16), textAlign: TextAlign.center),
                        const SizedBox(height: 28),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(4, (index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _indicatorColors[index],
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 64),
                    child: InkWell(
                      onTap: () {},
                        child: Image.asset('assets/images/sound.png')),
                  ),
                ]),
                  const SizedBox(height: 43),
                  const Padding(
                    padding: EdgeInsets.only(left : 16),
                    child: Text('Продолжить просмотр', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 23),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16, right: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Stack(children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(data.filmImage)),
                                Padding(padding: const EdgeInsets.only(top: 115, left: 160),
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                            color: const Color.fromRGBO(255, 255, 255, 0.3)),
                                      ),
                                      child: const Text('12:34', style: TextStyle(color: Colors.white))),
                                ),
                              ]),
                              const SizedBox(height: 8),
                                  Stack(
                                    children: [
                                      Container(
                                      width: 225,
                                      height: 4,
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(255, 255, 255, 0.2),
                                            borderRadius: BorderRadius.circular(100)
                                        ),
                                    ),
                                      Container(
                                        width: 55,
                                        height: 4,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromRGBO(106, 17, 203, 1),
                                              Color.fromRGBO(37, 117, 252, 1),
                                              Color.fromRGBO(37, 117, 252, 1),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(100)
                                        ),
                                      ),
                                    ]),
                              const SizedBox(height: 8),
                              Text(data.movieName, style: const TextStyle(color: Colors.white)),
                                  const SizedBox(height: 4),
                              Text(data.seasonAndSeries, style: const TextStyle(color: Colors.white)),
                            ]),
                          );
                        }),
                    ),
                  ),
                  const SizedBox(height: 38),
              ]),
            );
          } else if (state is ErrorState) {
            return Text('Ошибка: ${state.error}');
          } else {
            return const Text('Загрузка данных...');
          }
        },
      ),
    );
  }
}

