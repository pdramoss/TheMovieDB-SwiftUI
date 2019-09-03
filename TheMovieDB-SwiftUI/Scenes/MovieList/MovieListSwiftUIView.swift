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
    @State private var movies: [PreviewMovie] = popularInformation.results
    
    var body: some View {
        self.getList()
        
        return NavigationView  {
            list
        }
    }
    
    var list: some View {
        List {
            ForEach(movies) { movie  in
                Text(movie.title)
            }
        }
    }
    
    func getList() {
        networkManager.getPopularMovies(page: 2) { (result) in
            switch result {
            case .success(let movieList):
                self.movies = movieList.results
                print(movieList)
            case .failure(let error):
                print(error)
            }
        }
    }
}
