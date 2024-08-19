# MSIG Life - Mobile Developer Assignment Test

This is a Flutter application with a food theme, created as part of the Mobile Developer Assignment Test. The app fetches food data from [TheMealDB API](https://www.themealdb.com/api.php) and includes features such as listing food items, managing favorites, and viewing food details.

## Features

1. **Food List**
   - Displays a list of foods fetched from the API.

2. **Favorite Food List**
   - Allows users to view their favorite foods.

3. **Food Detail Page**
   - View details of selected food items from either the API or the favorite list.
   - Add or remove food items from the favorite list.

## Tech Stack

The following technologies and tools were used in the development of this application:

- **BLoC (Business Logic Component)** - State management (Mandatory)
- **Drift** - Local database for storing favorites (Mandatory)
- **Dio** - HTTP client for API interactions (Mandatory)
- **Clean Architecture** - Organized and scalable code structure
- **Unit Testing** - Ensure code quality and functionality

## Installation and Setup

To run this application locally:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-repo/msiglife_test.git
2. Open the project in your IDE (Android studio or VS Code)
3. Get all packages using
   ```bash
   flutter pub run
   ```
4. Generate files that depend on generated files. You may run this command in your CLI
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
## Video Demo

https://github.com/user-attachments/assets/c78fac00-d783-46fc-aeef-b92c9635691b
