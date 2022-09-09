//
//  Previews.swift
//  Movies
//
//  Created by Justin Topham on 11/05/2020.
//  Copyright © 2020 Justin Topham. All rights reserved.
//

import SwiftUI

// MARK: - View
extension View {
    func previewWithName(_ name: String) -> some View {
        self
            .padding()
            .previewLayout(.sizeThatFits)
            .previewDisplayName(name)
    }
    
    func namedPreview() -> some View {
        let name = String.name(for: type(of: self))
        return self.previewWithName(name)
    }
}
    
// MARK: - String
extension String {
    static func name<T>(for type: T) -> String {
        String(reflecting: type)
            .components(separatedBy: ".")
            .last ?? ""
    }
}
