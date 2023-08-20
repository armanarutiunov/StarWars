# StarWars

iOS client app for [StarWars API](https://swapi.dev). Built as a code challenge assignment for Busuu.

## RepoStructure
This repo has 2 branches: `main` and `unit-tests-and-caching`. Whatever you see in the `main` branch is what I've managed to finish in time.

There were some important parts that I couldn't finish in time, such as caching and unit testing. Instead of describing how I would have approached them, I decided to actually implement them in a separate branch so that you could have a look at them if you wish.

To review the main part of the project, feel free to clone the repo and just review the `main` branch. To review the complete project, feel free either to checkout the `unit-tests-and-caching` branch or have a look at [the PR I opened](https://github.com/armanarutiunov/StarWars/pull/1).

## Technologies used
- Xcode v14.3.1
- Minimum deployment target iOS 16.4 (since it wasn't required to support older versions in the spec)
- Swift 5.8
- SPM for modularization and remote dependencies
- async / await
- Modern UICollectionView with its new-ish diffable data source and compositional layout
- UISplitViewController for iPad support
- URLSession (since required networking was very simple, I decided not to go for Alamofire)
- All the UI is implemented in code, no storyboards/xibs involved

## Architecture 
The architecture I decided to go with is MVVM. Was it a bigger project, I would have gone for an MVVM-C. However, in this specific case it didn't make sense because C (coordinator) would never be used, since there is no navigation involved in the app (besides showing/hiding splitVC columns).

## Project structure
Instead of building everything in a single Xcode target, I decided to take a modular approach with the use of Swift Package Manager.

The only Swift files the project contains in the original target are `AppDelegate` and `SceneDelegate`. Everything else is implemented in a local SPM package called `Modules`.

`Modules` structure is specified in its `Package.swift`. A more detailed description of each component of the package:

### Modules (aka Targets)
#### Built in `main` branch
- `Cloud` - a module that contains all the networking related logic + SWAPI specific networking entities (Endpoints + HTTPHeaders)
- `DesignSystem` - a module that is supposed to contains reusable UI components and UI-related extensions, but in this project only has a single UIViewController extension as nothing else was needed
- `Filmography` - a module that contains all the screen logic (VCs/Views/ViewModels/DataSources)
- `FilmographyManager` - a module that contains all the logic for film and character fetching
  - Side note: I really didn't like the options SWAPI provides for character (people) fetching. From how they designed their API, I'm suppose to fire multiple requests for each character I want to fetch (and some films have lots of characters). I decided to fetch all the characters at once on start of the screen and then filter that data based on which film is selected. At first I was requesting 9 pages of characters one after another but it was too slow, so I decided to utilise `async/await`'s `withThrowingTaskGroup()` method that allows to group multiple async tasks and fire them all at once. In the end 9 pages of characters are now fetched quicker than a single `/films` endpoint.
- `Utilities` - a module that contains all the non-UI extensions and utilities needed for any of the modules

#### Built in `unit-tests-and-caching` branch
- `Datastore` - a module that contains logic that saves/loads/deletes data on disk to cache films and characters (SWAPI networking requests are very heavy)
- `FilmographyManagerTests` - a module that contains all the unit tests for logic in the `FilmographyManager` module (decoding/encoding of the Film & Character models & FilmpographyManager tests)
- `Datastore` - a module that contains unit tests for the Datastore logic (saving/loading/deleting of objects on and from disk)

### Libraries (aka Products)
- `Filmography` - needed to be imported in SceneDelegate to set FilmographySplitViewController as the root of the project's window

## What I could have improved even further the `unit-tests-and-caching` branch
- `Datastore` could have an additional way to save/load/delete objects without a key based on their `id`s (would have to be `Identifiable`)
- `Datastore` could have more logic to not only save on disk but also on RAM for a more efficient usage of cache data throughout app's life cycle (an overkill for this project though)
- Could have built a more sophisticated CloudManager that would parse errors into different types etc. (an overkill for this project)
- Could have tested more logic such as CloudManager, DataSources & ViewModels etc.
