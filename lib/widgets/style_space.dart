import 'package:flutter/cupertino.dart';
import 'package:neumorphism_project/widgets/style_insets.dart';


class VSpace extends StatelessWidget {
  final double size;

  const VSpace(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(height: size);

  static VSpace get xs => VSpace(Insets.xs);
  static VSpace get sm => VSpace(Insets.sm);
  static VSpace get med => VSpace(Insets.med);
  static VSpace get lg => VSpace(Insets.lg);
  static VSpace get xl => VSpace(Insets.xl);
  static VSpace get xxl => VSpace(Insets.xxl);
}

class HSpace extends StatelessWidget {
  final double size;

  const HSpace(this.size, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(width: size);

  static HSpace get xs => HSpace(Insets.xs);
  static HSpace get sm => HSpace(Insets.sm);
  static HSpace get med => HSpace(Insets.med);
  static HSpace get lg => HSpace(Insets.lg);
  static HSpace get xl => HSpace(Insets.xl);
  static HSpace get xxl => HSpace(Insets.xxl);
}