//
//  HeartSymbol.swift
//  Movies
//
//  Created by Justin Topham on 11/05/2020.
//  Copyright © 2020 Justin Topham. All rights reserved.
//

import SwiftUI

// MARK: - HeartSymbol
struct HeartSymbol: View {
    let filled: Bool;
    let font: Font;
    
    var body: some View {
        Image(systemName: determineSFSymbol(filled))
            .font(font)
            .heartStyle(filled)
    }
}

private extension HeartSymbol {
    func determineSFSymbol(_ filled: Bool) -> String {
        if filled {
            return "heart.fill"
        } else {
            return "heart"
        }
    }
}

// MARK: - View
private extension View {
    func heartStyle(_ filled: Bool) -> some View {
        if filled {
            return self
                .foregroundColor(.filledHeart)
                .opacity(1)
        } else {
            return self
                .foregroundColor(.emptyHeart)
                .opacity(0.118)
        }
    }
}

// MARK: - Сolor
private extension Color {
    static let filledHeart: Color = Color(red: 1.0, green: 0.231, blue: 0.188)
    static let emptyHeart: Color = Color(red: 0.235, green: 0.235, blue: 0.263)
}

// MARK: - Previews
struct HeartSymbol_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            HeartSymbol(filled: true, font: .headline)
            HeartSymbol(filled: false, font: .headline)
            HeartSymbol(filled: true, font: .title)
            HeartSymbol(filled: false, font: .title)
        }
        .previewWithName(String.name(for: HeartSymbol.self))
    }
}

