//
//  TestData.swift
//  Movies
//
//  Created by Justin Topham on 24/04/2020.
//  Copyright © 2020 Justin Topham. All rights reserved.
//

import Foundation
import UIKit

struct TestData {
    static var movies: [Movie] = []
    
    static func LoadTestData() {
        guard let url = Bundle.main.url(forResource: "Movies", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                print("Data object could not be created from JSON file!")
                return
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let movies = try? decoder.decode([Movie].self, from: data) else {
            print("Movies could not be decoded!")
            return
        }
        self.movies = movies
    }
}
