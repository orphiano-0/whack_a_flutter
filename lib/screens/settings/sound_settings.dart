import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  final double brightness;
  final double volume;
  final ValueChanged<double> onBrightnessChanged;
  final ValueChanged<double> onVolumeChanged;

  const SettingsDialog({
    super.key,
    required this.brightness,
    required this.volume,
    required this.onBrightnessChanged,
    required this.onVolumeChanged,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late double _currentBrightness;
  late double _currentVolume;

  @override
  void initState() {
    super.initState();
    _currentBrightness = widget.brightness;
    _currentVolume = widget.volume;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blueGrey.shade900,
          border: Border.all(color: Colors.white, width: 4),
          borderRadius: BorderRadius.circular(0), // square corners
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'SETTINGS',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pixel',
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              ),
            ),

            // Brightness
            _buildSliderLabel('Brightness'),
            _buildPixelSlider(
              value: _currentBrightness,
              onChanged: (value) {
                setState(() => _currentBrightness = value);
                widget.onBrightnessChanged(value);
              },
              activeColor: Colors.amberAccent,
            ),

            SizedBox(height: 10),

            // Volume
            _buildSliderLabel('Volume'),
            _buildPixelSlider(
              value: _currentVolume,
              onChanged: (value) {
                setState(() => _currentVolume = value);
                widget.onVolumeChanged(value);
              },
              activeColor: Colors.cyanAccent,
            ),

            const SizedBox(height: 20),

            // Close button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Text(
                  'CLOSE',
                  style: TextStyle(
                    fontFamily: 'Pixel',
                    fontSize: 16,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white70,
          fontFamily: 'Pixel',
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildPixelSlider({
    required double value,
    required ValueChanged<double> onChanged,
    required Color activeColor,
  }) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 4,
        activeTrackColor: activeColor,
        inactiveTrackColor: Colors.white24,
        thumbColor: Colors.white,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayColor: activeColor.withOpacity(0.2),
      ),
      child: Slider(
        value: value,
        min: 0,
        max: 1,
        divisions: 10,
        onChanged: onChanged,
      ),
    );
  }
}
