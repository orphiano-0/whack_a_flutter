import 'package:flutter/material.dart';

class GameSettingsDialog extends StatefulWidget {
  final ImageProvider backgroundImage;
  final int lives;
  final double timerSeconds;
  final ValueChanged<ImageProvider> onBackgroundChanged;
  final ValueChanged<int> onLivesChanged;
  final ValueChanged<double> onTimerChanged;

  const GameSettingsDialog({
    super.key,
    required this.backgroundImage,
    required this.lives,
    required this.timerSeconds,
    required this.onBackgroundChanged,
    required this.onLivesChanged,
    required this.onTimerChanged,
  });

  @override
  State<GameSettingsDialog> createState() => _GameSettingsDialogState();
}

class _GameSettingsDialogState extends State<GameSettingsDialog> {
  late ImageProvider _selectedBackground;
  late int _currentLives;
  late double _currentTimer;

  final List<ImageProvider> _backgroundImages = [
    AssetImage('assets/images/mole_background.png'),
    AssetImage('assets/images/jungle_background.png'),
    AssetImage('assets/images/farm_background.png'),
    AssetImage('assets/images/lake_background.png'),
    AssetImage('assets/images/night_background.png'),
    AssetImage('assets/images/wither.png'),
    AssetImage('assets/images/sky_island.png'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedBackground = widget.backgroundImage;
    _currentLives = widget.lives;
    _currentTimer = widget.timerSeconds;
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
          borderRadius: BorderRadius.circular(0),
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

            _buildSliderLabel('Background'),
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _backgroundImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final img = _backgroundImages[index];
                  final isSelected = img == _selectedBackground;
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedBackground = img);
                      widget.onBackgroundChanged(img);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.amber : Colors.white,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                      child: Image(
                        image: img,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            _buildSliderLabel('Lives'),
            _buildPixelSlider(
              value: _currentLives.toDouble(),
              min: 1,
              max: 8,
              divisions: 7,
              activeColor: Colors.redAccent,
              onChanged: (value) {
                setState(() => _currentLives = value.toInt());
                widget.onLivesChanged(_currentLives);
              },
            ),

            const SizedBox(height: 10),

            // Timer selector
            _buildSliderLabel('Timer (Seconds)'),
            _buildPixelSlider(
              value: _currentTimer,
              min: 10,
              max: 120,
              divisions: 11,
              activeColor: Colors.greenAccent,
              onChanged: (value) {
                setState(() => _currentTimer = value);
                widget.onTimerChanged(_currentTimer);
              },
            ),

            const SizedBox(height: 20),

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
    required double min,
    required double max,
    required int divisions,
    required Color activeColor,
    required ValueChanged<double> onChanged,
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
        min: min,
        max: max,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}
