import 'package:flutter_test/flutter_test.dart';
import 'package:qavexfreecellelite/game/logic.dart';

SolitaireEngine fresh({int seed = 42}) {
  final e = SolitaireEngine(gameConfig());
  e.newGame(seed: seed);
  return e;
}

SolitaireEngine rigged() {
  final e = SolitaireEngine(gameConfig());
  e.tableau = List.generate(gameConfig().piles, (_) => <SolCard>[]);
  e.foundation = List.generate(gameConfig().foundations, (_) => <SolCard>[]);
  e.stock = <SolCard>[];
  e.waste = <SolCard>[];
  e.reserve = List<SolCard?>.filled(gameConfig().reserves, null);
  e.reservePile = <SolCard>[];
  return e;
}
void main() {
  test('freecell deal: 8 piles, all face up, 4 free cells, no stock', () {
    final e = fresh();
    expect(e.tableau.length, 8);
    const want = [7, 7, 7, 7, 6, 6, 6, 6];
    for (int i = 0; i < 8; i++) {
      expect(e.tableau[i].length, want[i]);
      for (final c in e.tableau[i]) {
        expect(c.faceUp, isTrue);
      }
    }
    expect(e.stock, isEmpty);
    expect(e.reserve.length, 4);
    expect(e.isWon, isFalse);
  });

  test('alternating-color descending build is accepted', () {
    final e = rigged();
    e.tableau[0].add(SolCard(1, 6, faceUp: true)); // 6H red
    e.tableau[1].add(SolCard(0, 5, faceUp: true)); // 5S black
    expect(e.moveTableauToTableau(1, 0, 0), isTrue);
    expect(e.tableau[0].length, 2);
    expect(e.tableau[1], isEmpty);
  });

  test('same-color build is rejected', () {
    final e = rigged();
    e.tableau[0].add(SolCard(1, 6, faceUp: true)); // 6H red
    e.tableau[1].add(SolCard(2, 5, faceUp: true)); // 5D red
    expect(e.moveTableauToTableau(1, 0, 0), isFalse);
    expect(e.tableau[1].length, 1);
  });

  test('a free cell parks the top card and undo restores it', () {
    final e = rigged();
    e.tableau[0].add(SolCard(0, 1, faceUp: true)); // AS
    expect(e.moveTableauToReserve(0), isTrue);
    expect(e.reserve[0], isNotNull);
    expect(e.tableau[0], isEmpty);
    expect(e.canUndo, isTrue);
    e.undo();
    expect(e.reserve[0], isNull);
    expect(e.tableau[0].length, 1);
  });

  test('hint spots the ace', () {
    final e = rigged();
    e.tableau[2].add(SolCard(2, 1, faceUp: true)); // AD
    expect(e.hint(), isNotEmpty);
  });
}
