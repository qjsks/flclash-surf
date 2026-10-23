import 'dart:ui' as ui;

import 'package:fl_clash/ui/shape.dart';
import 'package:fl_clash/views/dashboard/style.dart';
import 'package:flutter/rendering.dart' show CustomPainter;
import 'package:flutter/widgets.dart' show CustomPaint;
import 'package:material_ui/material_ui.dart';

class SurfDashboardView extends StatelessWidget {
  const SurfDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = DashboardColors.of(context);
    final main = scheme.onSurface;
    final dim = scheme.onSurfaceVariant;
    return Container(
      color: colors.page,
      child: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          16 + MediaQuery.paddingOf(context).top,
          16,
          28,
        ),
        children: [
          Text(
            '仪表盘',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: main,
            ),
          ),
          const SizedBox(height: 12),
          _card(
            context,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(context, '⇄', '网络速度', chevron: true),
                const SizedBox(height: 6),
                SizedBox(
                  height: 96,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _SparkPainter(scheme.primary),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(child: _speed(context, '↑ 上传速度')),
                    Expanded(child: _speed(context, '↓ 下载速度')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _modeCard(context)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    _smallCard(context, '◎', '公网 IP', '* * * *'),
                    const SizedBox(height: 12),
                    _smallCard(context, '▤', 'DNS', '202.101.173.183'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _statCard(context, '◔', '活跃连接', '0')),
              const SizedBox(width: 12),
              Expanded(child: _trafficCard(context)),
            ],
          ),
          const SizedBox(height: 12),
          _wideStatCard(context, '◔', '内网 IP', '100.90.166.41'),
        ],
      ),
    );
  }

  Widget _card(
    BuildContext context,
    Widget child, {
    EdgeInsetsGeometry padding = const EdgeInsets.all(18),
  }) {
    final colors = DashboardColors.of(context);
    return Container(
      decoration: ShapeDecoration(color: colors.card, shape: AppShape.all(20)),
      padding: padding,
      child: child,
    );
  }

  Widget _header(
    BuildContext context,
    String glyph,
    String title, {
    bool chevron = false,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Text(glyph, style: TextStyle(fontSize: 16, color: scheme.onSurface)),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: scheme.onSurface,
          ),
        ),
        const Spacer(),
        if (chevron)
          Text(
            '›',
            style: TextStyle(fontSize: 22, color: scheme.onSurfaceVariant),
          ),
      ],
    );
  }

  Widget _speed(BuildContext context, String label) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '0',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                'B/s',
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _modeCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context, '⤢', '出站模式'),
          const SizedBox(height: 8),
          _modeRow(context, '规则模式', true),
          _modeRow(context, '直连模式', false),
          _modeRow(context, '全局模式', false),
        ],
      ),
    );
  }

  Widget _modeRow(BuildContext context, String label, bool selected) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? scheme.primary : scheme.onSurfaceVariant,
                width: selected ? 6 : 2,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallCard(
    BuildContext context,
    String glyph,
    String title,
    String value,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return _card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                glyph,
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 17, color: scheme.onSurface),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    BuildContext context,
    String glyph,
    String title,
    String value,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return _card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                glyph,
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _trafficCard(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return _card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '◔',
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '流量使用',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '↑ 0',
                style: TextStyle(fontSize: 15, color: scheme.onSurface),
              ),
              Text(
                'B',
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '↓ 0',
                style: TextStyle(fontSize: 15, color: scheme.onSurface),
              ),
              Text(
                'B',
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _wideStatCard(
    BuildContext context,
    String glyph,
    String title,
    String value,
  ) {
    final scheme = Theme.of(context).colorScheme;
    return _card(
      context,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                glyph,
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _SparkPainter extends CustomPainter {
  const _SparkPainter(this.color);

  final ui.Color color;

  static const _points = <double>[
    0.01, 0.012, 0.01, 0.013, 0.011, 0.012, 0.01, 0.012,
    0.01, 0.011, 0.012, 0.01, 0.012, 0.011, 0.012, 0.01,
    0.012, 0.75, 0.45, 0.28, 0.22, 0.18, 0.16, 0.13,
    0.14, 0.12, 0.10, 0.11, 0.095, 0.10, 0.09, 0.085,
    0.09, 0.08,
  ];

  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    if (_points.length < 2) {
      return;
    }
    final path = ui.Path();
    final step = size.width / (_points.length - 1);
    for (var i = 0; i < _points.length; i++) {
      final x = i * step;
      final y = size.height - _points[i] * size.height * 0.92;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final paint = ui.Paint()
      ..color = color
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = ui.StrokeCap.round
      ..strokeJoin = ui.StrokeJoin.round;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparkPainter oldDelegate) =>
      oldDelegate.color != color;
}
