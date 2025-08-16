import 'package:flutter/material.dart';
import 'ui/sparkle_pin.dart';

class SparkleDemoPage extends StatefulWidget {
  const SparkleDemoPage({super.key});

  @override
  State<SparkleDemoPage> createState() => _SparkleDemoPageState();
}

class _SparkleDemoPageState extends State<SparkleDemoPage> {
  double _progress = 0.5;
  bool _pulse = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SparklePin Demo')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SparklePin(
              baseSize: 24,
              progress: _progress, // 0..1
              pulse: _pulse,
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Size progress'),
                    Expanded(
                      child: Slider(
                        value: _progress,
                        min: 0,
                        max: 1,
                        onChanged: (v) => setState(() => _progress = v),
                      ),
                    ),
                    Text(_progress.toStringAsFixed(2)),
                  ],
                ),
                SwitchListTile(
                  title: const Text('Pulse (鼓動アニメ)'),
                  value: _pulse,
                  onChanged: (v) => setState(() => _pulse = v),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
