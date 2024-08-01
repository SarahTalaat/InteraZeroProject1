*Project Screen Record Video Link:
----------------------------------
https://drive.google.com/file/d/1v2s0HRB_nTlgna63VtrwMHQ03iXuLu6T/view?usp=drive_link

*InteraZeroProject1:
---------------------
InteraZeroProject1 is an iOS application that allows users to browse and manage their favorite Star Wars characters and starships.
The app uses the Star Wars API (SWAPI) to fetch data and Core Data for local storage of favorites.

*Features:
-----------
-Browse Characters and Starships: View a list of characters and starships from the Star Wars universe.
-Search Functionality: Search for specific characters or starships.
-Favorites Management: Add or remove characters and starships from your favorites list.
-Custom Animations: Smooth push and pop transitions between view controllers.
-Offline Support: Store favorite characters and starships locally using Core Data.
-Detail Views: View detailed information about selected characters and starships.

*Technologies Used:
-------------------
-Swift: The primary programming language used.
-MVVM Architecture: Implements the Model-View-ViewModel pattern for better separation of concerns and code organization.
-Alamofire: For making network requests to the SWAPI.
-Core Data: For local storage of favorite characters and starships.
-JGProgressHUD: For displaying progress and success indicators.
-Custom Animations: Custom push and pop animations for transitioning between view controllers.
-Singleton
-Delegation
-Lottie
-Dependency Injection

Project Structure:
------------------

*View Controllers:
------------------
-CharactersVC: Displays a list of characters fetched from the SWAPI and search functionality.
-StarshipsVC: Displays a list of starships fetched from the SWAPI and search functionality.
-FavouriteVC: Manages and displays favorite characters and starships.
-CharacterDetailsVC: Shows detailed information about a selected character.
-StarshipDetailsVC: Shows detailed information about a selected starship.

*View Models:
-------------
-CharactersViewModel: Handles data fetching (including pagination) and binding for characters.
-StarshipViewModel: Handles data fetching (including pagination) and binding for starships.
-FavouritesViewModel: Manages the list of favorite characters and starships, including retrieval and deletion from Core Data.
-CharactersDetailsViewModel: Manages the detailed information and data binding for a selected character.
-StarshipDetailsViewModel: Manages the detailed information and data binding for a selected starship.

*Models:
---------
-StarshipModel: Represents a starship fetched from the SWAPI.
-CharactersModel: Represents a character fetched from the SWAPI.
-LocalCharacter: Represents a character stored in Core Data.
-LocalStarship: Represents a starship stored in Core Data.

*Services:
----------
-DatabaseService: Handles all Core Data interactions, including saving, retrieving, and deleting data.
-NetworkService: Manages network requests using Alamofire.

*Utilities:
------------
-Constants: Contains the API configuration for SWAPI.
-DependencyProvider: Provides instances of view models.
-SharedDataModel: Singleton for sharing data across the app.
-CustomAnimator and CustomTransitioningDelegate: Handle custom push and pop animations.
-UIViewController+Extensions: Adds a method for displaying alerts in view controllers.

*Instructions on how to run the project:
-----------------------------------------
-Download the application from the following link :
https://github.com/SarahTalaat/InteraZeroProject1.git 
and run it through the workspace 

*Personal Contact Info.:
-------------------------
-Email: sarahtalaatammar.work@gmail.com
