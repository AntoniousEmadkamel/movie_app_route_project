# Movie App Route Project

## Overview

**Movie App Route Project** is a full-featured movie browsing application built with **Flutter**. The app leverages clean architecture and the MVVM (Model-View-ViewModel) pattern to ensure scalable, maintainable, and testable code. It integrates with Firebase for backend services and interacts with The Movie Database (TMDb) API to provide users with real-time movie data, including popular, top-rated, and upcoming releases.

This documentation gives a comprehensive and professional overview of the entire project, including its main features, technical stack, architectural decisions, and implementation details. The aim is to showcase the depth and quality of engineering skills, making this project a strong portfolio addition.

---

## Table of Contents

1. [Features](#features)
2. [Architecture](#architecture)
3. [Technologies Used](#technologies-used)
4. [Project Structure](#project-structure)
5. [Core Modules](#core-modules)
6. [UI/UX Design](#uiux-design)
7. [API Integration](#api-integration)
8. [Firebase Integration](#firebase-integration)
9. [State Management & Patterns](#state-management--patterns)
10. [How to Run](#how-to-run)
11. [Screenshots](#screenshots)
12. [Future Improvements](#future-improvements)

---

## Features

### 🎬 Movie Discovery

- **Popular Movies Carousel**: Browse trending and highly-rated movies in an interactive carousel slider.
- **New Releases Section**: View the latest movie releases with detailed info.
- **Category Browsing**: Explore movies by genres/categories using dynamic filters.
- **Detailed Movie Pages**: Access in-depth details for each movie, including synopsis, rating, language, release date, production companies, and similar movies.
- **Recommended Movies**: See recommendations based on your current selection.

### 🔍 Search & Filter

- **Full-text Search**: Instantly search for movies by title or keywords.
- **Genre Filters**: Filter movies by categories for targeted discovery.

### ⭐️ Watchlist Management

- **Personal Watchlist**: Add movies to your personal watchlist, stored in the cloud.
- **Persistence with Firebase**: Watchlist data syncs across devices using Firebase Firestore.

### 📊 Ratings & Reviews

- **IMDB Integration**: Display movie ratings and popularity from TMDb and IMDB.
- **Average User Ratings**: Show average ratings visually with star icons.

### 🚀 Performance & UX

- **Image Caching**: Uses `cached_network_image` for smooth image loading and reduced network usage.
- **Responsive Design**: Seamlessly adapts to different devices and orientations.
- **Theme Customization**: Custom light theme with branded color scheme.

---

## Architecture

### Clean Architecture & MVVM

- **MVVM (Model-View-ViewModel)**: 
  - **Models**: Represent movie, category, and user data.
  - **Views**: Flutter screens/widgets that display data.
  - **ViewModels**: Handle business logic, data-fetching, and state management.

- **Clean Architecture Principles**:
  - **Separation of Concerns**: Each layer (UI, domain, data, repository) is decoupled for scalability.
  - **Dependency Injection**: (If used) allows flexible swapping of implementations for testing/mocking.
  - **Testability**: Logic is abstracted away from UI, making unit and widget testing straightforward.

**Folder Structure Example:**
```
lib/
  api/                  # API managers and network logic
  database_utils/       # Firebase Firestore helpers
  models/               # Data models for Movie, Category, etc.
  layout/               # Main app layout and navigation
  shared/styles/        # Theme and color definitions
  ui/screens/           # App screens and UI components (Home, Browse, Search, Movie Details, Watchlist)
```

---

## Technologies Used

### Frameworks & Languages

- **Flutter**: Cross-platform UI toolkit (Dart language)
- **Dart**: Modern, type-safe programming language for Flutter

### Backend & Cloud

- **Firebase**: 
  - **Firebase Core**: App initialization and configuration
  - **Cloud Firestore**: Real-time database for watchlist and user data

### Networking & Data

- **HTTP**: API requests to [The Movie Database (TMDb)](https://www.themoviedb.org/)
- **JSON Serialization**: Data parsing for movie/category models

### UI & State Management

- **Provider/SetState**: (If Provider or another package is used, mention here) For state management
- **Carousel Slider**: Interactive horizontal carousels for movie lists
- **Cached Network Image**: Efficient image loading and caching

### Utilities

- **Custom Theming**: Branded color palette and typography
- **Asset Management**: Centralized management for images and icons

---

## Project Structure

```
lib/
├── api/                       # API calls and network interfaces
│   └── api_manager.dart
├── database_utils/            # Helpers for Firestore/Firebase
├── layout/                    # Home layout and route management
├── models/                    # Data classes (movie, category, etc.)
├── shared/
│   └── styles/                # Theme, colors, typography
├── ui/
│   ├── app_assets.dart        # Image and asset paths
│   └── screens/
│       ├── Home_tab/
│       ├── browse_tab/
│       ├── search_tab/
│       └── watchlist_fragment/
├── main.dart                  # App entry point & initialization
└── firebase_options.dart      # Firebase platform options (auto-generated)
```

---

## Core Modules

### 1. Main Application (`main.dart`)

- Initializes Flutter bindings and Firebase.
- Sets up routing and injects custom theme.
- Defines available routes:
  - Home
  - Movie Details
  - Category Results

### 2. Home Layout (`layout/home_layout.dart`)

- Bottom navigation bar with 4 main tabs:
  - **Home**: Featured movies, trending, recommendations
  - **Search**: Search input and results
  - **Browse**: Browse by categories/genres
  - **Watchlist**: User's saved movies

### 3. API Manager (`api/api_manager.dart`)

- Handles all interactions with TMDb API.
- Methods for:
  - Fetching popular, top-rated, upcoming movies
  - Fetching genres/categories
  - Fetching movies by category
  - Fetching movie details and similar/recommended movies

### 4. Models (`models/`)

- **Movie Model**: Complete mapping of movie data, including genres, ratings, production info, etc.
- **Category Model**: Genres and categories for filtering.

### 5. UI Screens

- **Movie Details Screen**: Shows full info, poster, synopsis, rating, similar movies carousel.
- **Popular/Upcoming Widgets**: Carousel sliders for featured and new release movies.
- **Watchlist Fragment**: Cloud-synced user watchlist.

### 6. Theming & Styling (`shared/styles/mytheme.dart`)

- Custom color scheme, text styles, bottom navigation theme.

---

## UI/UX Design

- **Modern dark theme** with gold and blue-black accents.
- **Carousel sliders** for immersive movie browsing.
- **Responsive layouts** for both Android and iOS.
- **Visual feedback** for loading/error states.
- **Intuitive navigation** with bottom nav bar and smooth transitions.

---

## API Integration

- **TMDb API** (requires API key):  
  - Get popular, top-rated, upcoming, and genre-specific movies.
  - Fetch movie details, images, ratings, and similar movies.
- **Networking**: All requests handled asynchronously, with loading/error handling in the UI.

---

## Firebase Integration

- **Firebase Initialization**: Platform-specific options auto-configured.
- **Cloud Firestore**: 
  - Used for persistent watchlist storage.
  - Ensures user data is available across sessions/devices.

---

## State Management & Patterns

- **MVVM**: ViewModels manage logic and data, keeping UI code clean.
- **Immutability**: Models are immutable for safer, predictable state.
- **Scoped State**: Each screen manages its own state, minimizing global dependencies.

---

## How to Run

1. **Clone the repo**:
   ```bash
   git clone https://github.com/antonious-emad/movie_app_route_project.git
   cd movie_app_route_project
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Configure Firebase**:
   - Follow instructions in `firebase_options.dart` (auto-generated from FlutterFire CLI).
   - Set up your own Firebase project if needed.
4. **Get your TMDb API Key**:
   - Replace the placeholder in `api/api_manager.dart` if necessary.
5. **Run the app**:
   ```bash
   flutter run
   ```

---

## Screenshots

![image alt](https://github.com/antonious-emad/movie_app_route_project/blob/master/Movies.jpg?raw=true)

---

## Future Improvements

- User authentication (Google, email)
- User reviews and comments
- Movie trailers integration (YouTube player)
- Offline support and local caching
- Enhanced search filters (year, rating, etc.)
- Localization and multi-language support
- Advanced state management with Provider, Riverpod, or Bloc

---

## Credits

- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)
- [The Movie Database (TMDb)](https://www.themoviedb.org/)
- [Carousel Slider](https://pub.dev/packages/carousel_slider)
- [Cached Network Image](https://pub.dev/packages/cached_network_image)

---

## License

This project is for educational and portfolio purposes. For commercial use or redistribution, please contact the author.

---

## Author

**[@antonious-emad](https://github.com/antonious-emad)**

---

_This README was generated to demonstrate full-stack mobile development, clean architecture, and robust Flutter engineering skills._
