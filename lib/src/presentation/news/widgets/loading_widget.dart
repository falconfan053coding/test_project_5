import 'package:flutter/material.dart';
import 'package:latest_news/app/theme.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>  with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller1,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller3,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller1.repeat(reverse: true);
    _controller2.repeat(reverse: true, period: const Duration(milliseconds: 900));
    _controller3.repeat(reverse: true, period: const Duration(milliseconds: 800));
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Bounce(animation: _animation1),
          const SizedBox(width: 8.0),
          Bounce(animation: _animation2),
          const SizedBox(width: 8.0),
          Bounce(animation: _animation3),
        ],
      ),
    );
  }
}

class Bounce extends AnimatedWidget {
  const Bounce({super.key, required Animation<double> animation})
      : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Container(
        width: 18.0,
        height: 18.0,
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.circular(9.0),
        ),
      ),
    );
  }
}
