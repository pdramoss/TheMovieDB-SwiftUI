//
//  MovieListSwiftUIView.swift
//  TheMovieDB-SwiftUI
//
//  Created by Pedro Ramos on 1/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import SwiftUI

struct MovieListSwiftUIView: View {
    
    @State private var movies: [PreviewMovie] = popularInformation.results
    
    var body: some View {
        self.getList()
        return list
    }
    
    var list: some View {
        NavigationView {
            List (movies) { movie in
                NavigationLink(destination: MovieDetailSwiftUIView()) {
                    MovieRowSwiftUIView(previewMovie: movie)
                }
            }
            .padding()
            .navigationBarTitle("THE MOVIE DB")
        }
    }
    
    func getList() {
        NetworkManager().getPopularMovies(page: 2) { (result) in
            switch result {
            case .success(let movieList):
                self.movies = movieList.results
            case .failure(let error):
                print(error)
            }
        }
    }
}
