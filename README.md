# Ruby Tic Tac Toe
- This will be my first project incorporating the lessons I learned
about object-oriented programming. 
- The program will play a game in the command line interface.
- **DISCLAIMER:** The game doesn't currently support intelligent players i.e. CPU, so you must play with another person, perhaps your friend, to maximize the experience for this game.

# How to play?
- Make sure you are inside the folder for this game. i.e. `path/to/ruby-tic-tac-toe` and make sure `ruby 3.4.2` is installed on your machine.
- Clone this repository to your current working directory i.e.
```
git clone https://github.com/xtiancosca001-dot/ruby-tic-tac-toe.git (for https - Personal Access Token is required)
git@github.com:xtiancosca001-dot/ruby-tic-tac-toe.git (for ssh - your device public key (ssh-rsa) is required)
```
- To start playing, run the following on your terminal:
```
ruby main.rb
```
- The program first prompts you to ask for the name for player 1 and 2. If only entered twice, default values are `PLAYER 1` and `PLAYER 2`.
- Afterwards, you must choose a move profile for player 1 (`x` or `o`) and player 2 will automatically assign the opposing move profile (i.e. `x vs o` and `o vs x`).

# The Game
- To move, you must enter numbers between `1` and `9` and press `enter` until the game ends. The layout for the interface is as follows:
```
+---+---+---+
| 1 | 2 | 3 |
+---+---+---+
| 4 | 5 | 6 |
+---+---+---+
| 7 | 8 | 9 |
+---+---+---+
```

# How to win?
- You must match any of your three moves such that:
  - a diagonal / vertical / horizontal line is formed with your 3 moves i.e.
```
+---+---+---+ +---+---+---+ +---+---+---+ +---+---+---+
| x |   |   | |   |   | x | | x |   |   | | x | x | x |
+---+---+---+ +---+---+---+ +---+---+---+ +---+---+---+
|   | x |   | |   | x |   | | x |   |   | |   |   |   |
+---+---+---+ +---+---+---+ +---+---+---+ +---+---+---+
|   |   | x | | x |   |   | | x |   |   | |   |   |   |
+---+---+---+ +---+---+---+ +---+---+---+ +---+---+---+
```
- But if your opponent first creates the patterns above, you lose the game.
- If there are no patterns at the end of the game (let's say at move `9`), the game is considered a `DRAW`.