//
//  MainView.swift
//  Movies
//
//  Created by Justin Topham on 24/04/2020.
//  Copyright © 2020 Justin Topham. All rights reserved.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
    @State var movies: [Movie]
    
    var body: some View {
        TabView {
            NavigationView {
                MoviesView(movies: $movies, showAll: true)
            }
            .tab(title: "All movies", imageName: "list.bullet")
            NavigationView {
                MoviesView(movies: $movies, showAll: false)
            }
            .tab(title: "Favorites", imageName: "heart")
        }
    }
}

// MARK: - View
extension View {
    func tab(title: String, imageName: String) -> some View {
        self
            .tabItem {
                Image(systemName: imageName)
                    .font(.system(size: 26))
                Text(title)
        }
    }
}


// MARK: - Previews
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(movies: TestData.movies)
    }
}
