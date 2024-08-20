import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/responsive.dart';
import 'package:shophimikat/common/widgets/app_text.dart';
import 'package:sizer/sizer.dart';

class Accordion extends StatefulWidget {
  const Accordion({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((value) {
          if (!mounted) return;
          setState(() {});
        });
      }
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 150,
      ),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller.view,
        builder: (_, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              !_isExpanded
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _handleTap,
                      child: Row(
                        children: [
                          Flexible(
                            child: AppText(
                              text: widget.title,
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile(context) ? 11.sp : 3.sp,
                                  color: AppColors.textRed),
                            ),
                          ),
                          SizedBox(
                            width: isMobile(context) ? 3.w : 1.w,
                          ),
                          Transform.rotate(
                            angle: pi * _heightFactor.value * 0.5,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textRed,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  heightFactor: _heightFactor.value,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: widget.child,
                  ),
                ),
              ),
              _isExpanded
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _handleTap,
                      child: Row(
                        children: [
                          Flexible(
                            child: AppText(
                              text: 'Свернуть',
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isMobile(context) ? 11.sp : 3.sp,
                                  color: AppColors.textRed),
                            ),
                          ),
                          SizedBox(
                            width: isMobile(context) ? 3.w : 1.w,
                          ),
                          Transform.rotate(
                            angle: pi * _heightFactor.value * 1.5,
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.textRed,
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        });
  }
}
