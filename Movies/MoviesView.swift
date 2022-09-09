//
//  ContentView.swift
//  Movies
//
//  Created by Justin Topham on 24/04/2020.
//  Copyright © 2020 Justin Topham. All rights reserved.
//

import SwiftUI

// MARK: - MoviesView
struct MoviesView: View {
    @Binding var movies: [Movie]
    let showAll: Bool
    @State var showConfirmDeleteMessage: Bool = false
    @State var deletionOffsets: IndexSet = []
    @State var deletionMessage: String = ""
    
    var body: some View {
        List {
           ForEach (favoritesFilter(on: movies)) { movie in
                NavigationLink(destination: self.prepareDetailsView(for: movie)) {
                        Row(movie: movie)
                }
            }
            .onDelete(perform: deleteItems(atOffsets:))
            .onMove(perform: move(fromOffsets:toOffset:))
            .actionSheet(isPresented: $showConfirmDeleteMessage) {
                ActionSheet(title: Text(""), message: Text(deletionMessage), buttons: [
                    .default(Text("Confirm"), action: { self.movies.remove(atOffsets: self.deletionOffsets) } ),
                    .cancel()
                ])
            }
        }
        .navigationBarTitle(showAll ? "All Movies" : "Favorites")
        .navigationBarItems(trailing: showAll ? EditButton() : nil)
    }
}

private extension MoviesView {
    
    func favoritesFilter(on movies: [Movie])  -> [Movie]
    {
        if showAll {
            return movies
        }
        var movies = movies
        movies.removeAll { !$0.isFavorite }
        return movies
    }
    
    func prepareDetailsView(for movie: Movie) -> AnyView
    {
        guard let index = index(for: movie) else {
            return AnyView(EmptyView())
        }
        return AnyView(DetailsView(selectedMovie: $movies[index]))
    }
    
    func index(for movie: Movie) -> Int? {
        movies.firstIndex(where: { $0.id == movie.id })
    }
    
    func deleteItems(atOffsets offsets: IndexSet) {
        guard let offset = offsets.first else {
            return
        }
        self.deletionOffsets = offsets
        self.showConfirmDeleteMessage = true
        self.deletionMessage = "Delete \"" + self.movies[offset].title + "\"?"
    }
    
    func move(fromOffsets source: IndexSet, toOffset destination: Int) {
        movies.move(fromOffsets: source, toOffset: destination)
    }
}

// MARK: - Row
fileprivate typealias Row = MoviesView.Row

extension MoviesView {
    struct Row: View {
        let movie: Movie
        
        var body: some View {
            HStack(alignment: .top, spacing: 24.0) {
                Poster(uiImage: movie.poster, width: 69.0, height: 109.0, shadowX: 4, shadowY: 4)
                Info(movie: movie)
                Spacer()
                if movie.isFavorite {
                    HeartSymbol(filled: true, font: .headline)
                        .padding(.top, 12)
                }
            }
            .padding(.top, 18)
            .padding(.bottom, 18)
        }
    }
}

// MARK: - Info
fileprivate typealias Info = MoviesView.Row.Info

extension Row {
    struct Info: View {
        let title: String
        let runtime: String
        let genre: String
        let director: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(director)
                    .font(.subheadline)
                Text(genre)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(runtime)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.top, 12)
        }
    }
}

extension Row.Info {
    init(movie: Movie) {
        self.init(
            title: movie.title,
            runtime: movie.runtime,
            genre: movie.genre,
            director: movie.director)
    }
}

// MARK: - Previews
struct MoviesView_Previews: PreviewProvider {
    static let movies = TestData.movies
    
    static var previews: some View {
        Group {
            NavigationView {
                MoviesView(movies: .constant(movies), showAll: true)
            }
            Row(movie: movies[0])
                .previewWithName("Row")
            Info(movie: movies[0])
                .namedPreview()
        }
    }
}

