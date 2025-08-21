# Ultimate Tic Tac Toe Flutter App

## Overview
This project is a digital version of Ultimate Tic Tac Toe, built using Flutter for cross-platform compatibility (Android, iOS, and Web). The game expands the classic tic-tac-toe into a grid of smaller boards, enforcing strategic depth.

## Features
- **Local Multiplayer**: Play with a friend on the same device.
- **Responsive Design**: Smooth UI/UX that adapts to different screen sizes.
- **Game Mechanics**: 
  - 3x3 grid of smaller 3x3 tic-tac-toe boards.
  - Players alternate turns as ❌ (X) and ⭕ (O).
  - Highlighting of active boards and won boards.
  
## Installation
1. Clone the repository:
   ```
   git clone https://github.com/yourusername/ultimate_tic_tac_toe_flutter.git
   ```
2. Navigate to the project directory:
   ```
   cd ultimate_tic_tac_toe_flutter
   ```
3. Install dependencies:
   ```
   flutter pub get
   ```

## Running the App
To run the app, use the following command:
```
flutter run
```

## Directory Structure
- **lib/**: Contains the main application code.
  - **screens/**: UI screens for the app.
  - **widgets/**: Reusable UI components.
  - **models/**: Data models for the game.
  - **providers/**: State management using Provider.
  - **utils/**: Utility constants and functions.
  - **services/**: Services for persistence and other functionalities.
  
- **test/**: Contains tests for the application.

## Future Enhancements
- AI Opponent with difficulty levels.
- Online multiplayer functionality.
- Game history and statistics.
- Custom themes and skins.
- Leaderboards and achievements.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.