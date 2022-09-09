//
//  Model.swift
//  Movies
//
//  Created by Justin Topham on 24/04/2020.
//  Copyright © 2020 Justin Topham. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Identifiable{
    let id: UUID
    let title: String
    let year: String
    let runtime: String
    let genre: String
    let director: String
    let actors: String
    let plot: String
    let country: String
    let awards: String
    let poster: UIImage
    var isFavorite: Bool
    
    mutating func toggleIsFavorite() {
        isFavorite = !isFavorite
    }
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
    }
    
    init(from decoder: Decoder) throws {
        id = UUID()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        self.title = title
        year = try container.decode(String.self, forKey: .year)
        runtime = try container.decode(String.self, forKey: .runtime)
        genre = try container.decode(String.self, forKey: .genre)
        director = try container.decode(String.self, forKey: .director)
        actors = try container.decode(String.self, forKey: .actors)
        plot = try container.decode(String.self, forKey: .plot)
        country = try container.decode(String.self, forKey: .country)
        awards = try container.decode(String.self, forKey: .awards)
        let posterUrl = try container.decode(String.self, forKey: .poster)
        let assetName: String = {
            switch posterUrl {
            case "https://m.media-amazon.com/images/M/MV5BNzVhMjcxYjYtOTVhOS00MzQ1LWFiNTAtZmY2ZmJjNjIxMjllXkEyXkFqcGdeQXVyNTc5OTMwOTQ@._V1_SX300.jpg":
                    return "Alita"
            case "https://m.media-amazon.com/images/M/MV5BMTc5OTk4MTM3M15BMl5BanBnXkFtZTgwODcxNjg3MDE@._V1_SX300.jpg":
                    return "Edge of Tomorrow"
            case "https://m.media-amazon.com/images/M/MV5BNzA1Njg4NzYxOV5BMl5BanBnXkFtZTgwODk5NjU3MzI@._V1_SX300.jpg":
                    return "Blade Runner 2049"
            case "https://m.media-amazon.com/images/M/MV5BMjAxMzY3NjcxNF5BMl5BanBnXkFtZTcwNTI5OTM0Mw@@._V1_SX300.jpg":
                    return "Inception"
            case "https://m.media-amazon.com/images/M/MV5BNzQzOTk3OTAtNDQ0Zi00ZTVkLWI0MTEtMDllZjNkYzNjNTc4L2ltYWdlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg":
                    return "The Matrix"
            default:
                print("URL did not match asset! Defaulting image to Alita")
                return "Alita"
            }
        }()
        poster = UIImage(imageLiteralResourceName: assetName)
        if (title == "Alita: Battle Angel" || title == "Inception") {
           isFavorite = true
        } else {
            isFavorite = false
        }
    }
}

