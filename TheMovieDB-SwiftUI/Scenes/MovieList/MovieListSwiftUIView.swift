//
//  MovieListSwiftUIView.swift
//  TheMovieDB-SwiftUI
//
//  Created by Pedro Ramos on 1/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import SwiftUI

struct MovieListSwiftUIView: View {
    
    private var networkManager: NetworkManager = NetworkManager()
    
    var movies: [PreviewMovie] = popularInformation.results
    var body: some View {
        return list
    }
    
    var list: some View {
        List {
            ForEach(movies) { movie  in
                Text(movie.title)
            }
        }
    }
}
