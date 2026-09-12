# TriPeaks Solitaire

A 10-card pyramid TriPeaks variant built in Godot. Clear the pyramid by playing cards one higher or one lower than the discard pile.

## Screenshot

![Gameplay](Screenshot2026-09-12105735.png)
<!-- Add a gameplay capture as `screenshot.png` in the project root -->

## How to Play

- **Goal:** Clear all 10 pyramid cards to win (`YOU WIN!!`).
- Click a card that is 1 higher or 1 lower than the discard card (e.g. 7 on 6 or 8). King to Ace wrapping is not allowed.
- **Blocked cards:** The top 6 cards cannot be played until the 2 cards covering them are removed. Bottom row cards are always playable if the rank matches.
- Press `Deal` when no valid moves are available to get a new random discard (1-13). You start with 10 deals.
  - If a move is still available, Deal is blocked and shows `MOVE AVAILABLE!`
- **Lose condition:** 0 deals left with no valid moves shows `YOU LOSE!`
- Press `New Game` to restart with a fresh random deal.

## Controls

- Left-click card to play
- `Deal` button for new discard
- `New Game` button to restart

## Running the Game

1. Open this folder in Godot 4.x
2. Open `main.tscn` and press Play
