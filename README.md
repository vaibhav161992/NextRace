Overview


NextRace is an iOS application built using SwiftUI and Combine/Concurrency that fetches and displays a list of upcoming races. Users can:

View a list of races sorted by start time.
Filter races by category (Horse Racing, Harness Racing, Greyhound Racing).
Automatically refresh race data periodically.



Tech Stack

Swift: Programming language.
SwiftUI: Declarative UI framework for building the app's user interface.
Concurrency (async/await): For handling asynchronous tasks like fetching race data.
MVVM Architecture: Ensures scalability and testability.


Requirements
iOS 17.5+
Xcode 16.2
Swift 5.5+


Key Components

(1) RacingListViewModel:

Handles data fetching, filtering, sorting, and periodic updates.
Implements fetchRaces() using async/await for clean asynchronous operations.

(2) RaceRow:

Displays race details including meeting name, race number.


(3)FilterView:

Allows users to filter races by category.


(4)APIService:

Fetches race data from the API and parses JSON responses.
