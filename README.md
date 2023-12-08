# Flutter Movie App

## Overview
This Flutter Native App showcases movies fetched from an external API and allows users to browse, search, and view details about different movies.

## App Logo
<img src="https://github.com/BluHunt/Flutter-Movie-App/blob/main/App%20Logo.jpg" alt="App Logo" width="200"/>

### Screens Included
- Splash Screen
- Home Screen
- Search Screen
- Details Screen

## Screens Details

### Splash Screen
The app displays an engaging splash screen with an appropriate image related to movies or entertainment.

<img src="https://github.com/BluHunt/Flutter-Movie-App/blob/main/Splash%20Screen.jpg" alt="Splash Screen" width="200"/>

### Home Screen
- Displays a list of movies obtained from [TVMaze API - All Shows Endpoint](https://api.tvmaze.com/search/shows?q=all)
- Each movie is represented with a thumbnail, title, and summary.
- Tapping on a movie navigates to the Details Screen.
  
<img src="https://github.com/BluHunt/Flutter-Movie-App/blob/main/Home%20Screen.jpg" alt="Home Screen" width="200"/>

### Search Screen
- Includes a search bar to input search terms.
- Queries the [TVMaze API Search Endpoint](https://api.tvmaze.com/search/shows?q=${search_term}) based on the user's input.
- Displays the API response similar to the Home Screen.
 
<img src="https://github.com/BluHunt/Flutter-Movie-App/blob/main/Movie%20Search.jpg" alt="Search Screen" width="200"/>

<img src="https://github.com/BluHunt/Flutter-Movie-App/blob/main/Search%20Movie%20View.jpg" alt="Search Screen" width="200"/>


### Details Screen
- Shows detailed information about a selected movie.
- Includes the movie's image, summary, title, and more.
<img src="https://github.com/BluHunt/Flutter-Movie-App/blob/main/Movie%20Details.jpg" alt="Details Screen" width="200"/>

### Other Features
- Bottom navigation for easy navigation between Home and Search screens.
- The UI design is inspired by Netflix for a sleek and user-friendly experience.

## App Design
The app's design aims to provide a visually appealing and intuitive interface, resembling the style of popular streaming platforms like Netflix.

### Tech Stack
- Flutter for cross-platform mobile development.
- API Integration to fetch movie data.
- UI/UX design inspired by Netflix's interface.

### Installation
- Clone the repository.
- Run `flutter pub get` to install dependencies.
- Connect a device/emulator and run `flutter run` to launch the app.

Feel free to contribute or suggest improvements via pull requests!
