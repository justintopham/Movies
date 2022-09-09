//
//  DetailsView.swift
//  Movies
//
//  Created by Justin Topham on 24/04/2020.
//  Copyright © 2020 Justin Topham. All rights reserved.
//

import SwiftUI

// MARK: - DetailsView
struct DetailsView: View {
    @Binding var selectedMovie: Movie
    var test: Int = 0
        
    var body: some View {
        VStack(alignment: .leading, spacing: 36.0) {
            HStack (alignment: .top, spacing: 24.0) {
                Poster(uiImage: selectedMovie.poster, width: 151.0, height: 239.0, shadowX: 8, shadowY: 10)
                    .padding(.top, 6)
                RightInfo(movie: selectedMovie, favoriteButtonAction:  {
                    selectedMovie.toggleIsFavorite()
                    print(test)
                })
            }
            BottomInfo(movie: selectedMovie)
            Spacer()
        }
        .padding(.top, 18)
        .padding(.horizontal, 20)
        .navigationBarTitle(selectedMovie.title)
    }
}

// MARK: - RightInfo
fileprivate typealias RightInfo = DetailsView.RightInfo

extension DetailsView {
    struct RightInfo: View {
        let year: String
        let country: String
        let genre: String
        let runtime : String
        let isFavorite: Bool
        let awards : String
        let favoriteButtonAction: () -> Void
        
        var body: some View {
            VStack (alignment: .leading, spacing: 8.0) {
                HStack (alignment: .top) {
                    VStack (alignment: .leading, spacing: 8.0) {
                        Text(year + " , " + country)
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Text(genre)
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Text(runtime)
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 6)
                    Spacer()
                    FavoriteButton(isFavorite: isFavorite, action: favoriteButtonAction)
                }
                Text(awards)
                    .font(.callout)
                    .foregroundColor(.secondary)
            }
        }
    }
}

extension DetailsView.RightInfo {
    init(movie: Movie, favoriteButtonAction: @escaping () -> Void) {
        self.init(
            year: movie.year,
            country: movie.country,
            genre: movie.genre,
            runtime : movie.runtime,
            isFavorite: movie.isFavorite,
            awards : movie.awards,
            favoriteButtonAction: favoriteButtonAction)
    }
}

// MARK: - FavoriteButton
extension DetailsView.RightInfo {
    struct FavoriteButton: View {
        let isFavorite: Bool
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                if isFavorite {
                    HeartSymbol(filled: true, font: .title)
                } else {
                    HeartSymbol(filled: false, font: .title)
                }
            }
        }
    }
}

// MARK: - BottomInfo
fileprivate typealias BottomInfo = DetailsView.BottomInfo

extension DetailsView {
    struct BottomInfo: View {
        let director: String
        let actors: String
        let plot: String
        
        var body: some View {
            VStack (alignment: .leading, spacing: 0.0) {
                Text("Directed by:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(director)
                    .font(.headline)
                Text("Actors:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.top, 16)
                Text(actors)
                    .font(.headline)
                Divider()
                    .padding(.vertical, 16)
                Text(plot)
                    .font(.body)
            }
        }
    }
}

extension DetailsView.BottomInfo {
    init(movie: Movie) {
        self.init(
            director: movie.director,
            actors: movie.actors,
            plot : movie.plot)
    }
}

// MARK: - Previews
struct DetailsView_Previews: PreviewProvider {
    static let movie = TestData.movies[0]
    
    static var previews: some View {
        Group {
            DetailsView(selectedMovie: .constant(movie))
            RightInfo(movie: movie, favoriteButtonAction: { })
                .namedPreview()
            BottomInfo(movie: movie)
                .namedPreview()
        }
    }
}
