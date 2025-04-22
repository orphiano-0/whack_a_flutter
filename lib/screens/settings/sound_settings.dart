import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  final double volume;
  final bool isOn;
  final ValueChanged<double> onVolumeChanged;

  const SettingsDialog({
    super.key,
    required this.volume,
    required this.isOn,
    required this.onVolumeChanged,
  });

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  late double _currentVolume;
  late bool _soundEffectsOn;
  late bool _backgroundMusicOn;

  @override
  void initState() {
    super.initState();
    _currentVolume = widget.volume;
    _soundEffectsOn = widget.isOn;
    _backgroundMusicOn = true;
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
            _buildPixelCheckBox(
              label: 'Sound Effects',
              isMuted: _soundEffectsOn,
              onChanged: (value) {
                setState(() => _soundEffectsOn = value ?? _soundEffectsOn);
              },
            ),

            const SizedBox(height: 20),

            _buildPixelCheckBox(
              label: 'Background Music',
              isMuted: _backgroundMusicOn,
              onChanged: (value) {
                setState(
                  () => _backgroundMusicOn = value ?? _backgroundMusicOn,
                );
              },
            ),

            const SizedBox(height: 40),

            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
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

  Widget _buildPixelCheckBox({
    required String label,
    required bool isMuted,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onChanged(!isMuted),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isMuted ? Colors.white : Colors.transparent,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: isMuted
                  ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  color: Colors.black, // Pixelated check effect
                ),
              ) : null,
            ),
          ),
          const SizedBox(width: 10), // Space between checkbox and label
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              color: Colors.white70,
              fontFamily: 'Pixel',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
