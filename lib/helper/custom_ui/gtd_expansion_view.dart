import 'package:flutter/material.dart';

class GtdExpansionView extends StatefulWidget {
  const GtdExpansionView({
    super.key,
    this.child,
    required this.collapsed,
    this.axis = Axis.vertical,
    this.axisAlignment = 0.0,
    this.curve = Curves.linear,
    required this.duration,
    this.reverseDuration,
  });

  final Widget? child;

  /// Show or hide the child
  final bool collapsed;

  /// See [SizeTransition]
  final Axis axis;

  /// See [SizeTransition]
  final double axisAlignment;
  final Curve curve;
  final Duration duration;
  final Duration? reverseDuration;

  @override
  State<GtdExpansionView> createState() => _GtdExpansionViewState();
}

class _GtdExpansionViewState extends State<GtdExpansionView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (!widget.collapsed) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant GtdExpansionView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.collapsed != oldWidget.collapsed) {
      if (widget.collapsed) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axis: widget.axis,
      axisAlignment: widget.axisAlignment,
      child: widget.child,
    );
  }
}
