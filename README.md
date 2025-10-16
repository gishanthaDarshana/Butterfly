
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

## ScreenShots

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 16 - 2025-10-17 at 01 43 05" src="https://github.com/user-attachments/assets/b581c325-8987-4070-ba5b-16ea1eee79f8" />

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 16 - 2025-10-17 at 01 43 13" src="https://github.com/user-attachments/assets/cfb1a37e-53af-46a9-9261-5e4df7ab66b0" />

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 16 - 2025-10-17 at 01 44 00" src="https://github.com/user-attachments/assets/53feb9fb-9167-4c2d-ab23-1ea9f04979f4" />

<img width="1179" height="2556" alt="Simulator Screenshot - iPhone 16 - 2025-10-17 at 01 44 15" src="https://github.com/user-attachments/assets/7b2bb485-f14e-48bd-8fc2-8cea18d01225" />

