import 'package:flutter/material.dart';
import 'package:qavexfreecellelite/core/app_state.dart';
import 'package:qavexfreecellelite/widgets/ui.dart';

class HowToScreen extends StatelessWidget {
  const HowToScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBuilder(
      builder: (context, s) => QxScaffold(
        title: 'How to Play',
        body: ListView(
          children: const [
            QxCard(
              child: Text('HOW TO PLAY\n\nGoal: move all 52 cards to the four foundations, each suit Ace to King.\n\n- All 52 cards are dealt face up into 8 columns. There is NO stock.\n- Four free cells each hold exactly one card; use them as parking spots.\n- Build columns downward in alternating colors (red 6 on black 7).\n- Only a King (or a stack led by a King) may fill an empty column.\n- Tap a card, then a free cell, a foundation or a glowing column to move it. Double-tap a card to send it home.\n\nMODES\n- Classic: the pure game, no timer.\n- Timed Run: 10 minutes; finish fast for a time bonus.\n- Daily Challenge: one seeded vault per day; streaks earn bonus Cell Coins.\n- Zen Table: no timer, free hints and undo.\n- Puzzle Levels: 24 curated vaults with par scores; clear one to unlock the next.\n- Kids Mode: extra hints and friendly guidance.\n- Practice: free play with auto-hints.',
                  style: TextStyle(fontSize: 15, height: 1.5)),
            ),
          ],
        ),
      ),
    );
  }
}
