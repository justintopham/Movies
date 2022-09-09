//
//  Poster.swift
//  Movies
//
//  Created by Justin Topham on 11/05/2020.
//  Copyright © 2020 Justin Topham. All rights reserved.
//

import SwiftUI
import UIKit

// MARK: - Poster
struct Poster: View {
    let uiImage: UIImage
    let width: CGFloat
    let height: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat

    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .frame(width: width, height: height)
            .shadow(color: .shadowGrey, radius: 10, x: shadowX, y: shadowY)
    }
}

// MARK: - Сolor
private extension Color {
    static let shadowGrey: Color = Color(red: 0.608, green:  0.608, blue:  0.608)
}


// MARK: - Previews
struct Poster_Previews: PreviewProvider {
    static let movie = TestData.movies[0]

    static var previews: some View {
        return Poster(uiImage: movie.poster, width: 69.0, height: 109.0, shadowX: 4, shadowY: 4).namedPreview()
    }
}
