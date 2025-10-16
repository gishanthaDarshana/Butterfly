# Butterfly
MovieSearchApp Assessment
# Butterfly
MovieSearchApp Assessment

# Movie Search App

A SwiftUI-based iOS app using SwiftData for offline support, MVVM architecture, and a generic network layer.

## Features

- SwiftData integration for offline data storage and sync
- MVVM architecture for clean separation of concerns
- Repository layer decides data source based on network connectivity
- Utility class for monitoring connectivity
- Generic network layer for all HTTP calls
- Unit tests for Repository, Service, and DB layers

## Structure

- `/Models` — Data models  
- `/ViewModels` — MVVM view models  
- `/Views` — UI components  
- `/Repository` — Data source logic  
- `/Services` — Network and DB services  
- `/Utilities` — Connectivity monitor and helpers  
- `/Tests` — Unit tests  

## Getting Started

1. Clone the repo:  
   `git clone https://github.com/gishanthaDarshana/Butterfly.git`
2. Open in Xcode:  
   Open the `.xcodeproj` or `.xcworkspace` file.
3. Install dependencies:  
   Use Swift Package Manager if required.
4. Run the app:  
   Select a simulator or device and hit Run.

## Testing

- Run unit tests via Xcode (`Cmd+U`)
- Tests cover Repository, Service, and DB layers

## Usage

- App switches between local and remote data sources based on network status
- All network calls use the generic network layer
