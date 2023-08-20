//
//  JSONs.swift
//  
//
//  Created by Arman Arutiunov on 20/08/2023.
//

@testable import FilmographyManager
import Foundation

let CharacterJSON: [String: Any] = [
    Character.CodingKeys.name.rawValue: "Luke Skywalker",
    Character.CodingKeys.height.rawValue: "172",
    Character.CodingKeys.mass.rawValue: "77",
    Character.CodingKeys.hairColor.rawValue: "blond",
    Character.CodingKeys.skinColor.rawValue: "fair",
    Character.CodingKeys.eyeColor.rawValue: "blue",
    Character.CodingKeys.birthYear.rawValue: "19BBY",
    Character.CodingKeys.gender.rawValue: "male",
    Character.CodingKeys.url.rawValue: "https://swapi.dev/api/people/1/"
]

let FilmJSON: [String: Any] = [
    Film.CodingKeys.title.rawValue: "The Empire Strikes Back",
    Film.CodingKeys.url.rawValue: "https://swapi.dev/api/films/2/",
    Film.CodingKeys.characterURLs.rawValue: [
        "https://swapi.dev/api/people/1/",
        "https://swapi.dev/api/people/2/",
        "https://swapi.dev/api/people/3/",
        "https://swapi.dev/api/people/4/",
        "https://swapi.dev/api/people/5/",
        "https://swapi.dev/api/people/10/",
        "https://swapi.dev/api/people/13/",
        "https://swapi.dev/api/people/14/",
        "https://swapi.dev/api/people/18/",
        "https://swapi.dev/api/people/20/",
        "https://swapi.dev/api/people/21/",
        "https://swapi.dev/api/people/22/",
        "https://swapi.dev/api/people/23/",
        "https://swapi.dev/api/people/24/",
        "https://swapi.dev/api/people/25/",
        "https://swapi.dev/api/people/26/"
    ]
]

let FilmsResponseJSON: [String: Any] = [
    FilmsResponse.CodingKeys.films.rawValue: [FilmJSON]
]

let CharactersPageJSON: [String: Any] = [
    CharactersPage.CodingKeys.nextPageURL.rawValue: "https://swapi.dev/api/people/?page=2",
    CharactersPage.CodingKeys.characters.rawValue: [CharacterJSON]
]
