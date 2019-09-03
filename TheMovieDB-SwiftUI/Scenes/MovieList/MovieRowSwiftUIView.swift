//
//  MovieListRowSwiftUIView.swift
//  TheMovieDB-SwiftUI
//
//  Created by Pedro Ramos on 2/09/19.
//  Copyright © 2019 Pedro Ramos. All rights reserved.
//

import SwiftUI

struct MovieRowSwiftUIView: View {
    
    var previewMovie: PreviewMovie
    @State private var image: Image = Image("startAverage")
    @State private var imageSuccess: Bool = false
    
    private var transition: AnyTransition {
        AnyTransition.asymmetric(insertion: .move(edge: .leading),
                                 removal: .scale(scale: 1.0))
    }
    
    var body: some View {
        loadImage()
        return HStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 130, alignment: .center)
            VStack {
                Text(previewMovie.title)
                    .font(.headline)
                    .lineLimit(nil)
                HStack {
                    Image(systemName: "star.circle.fill")
                        .foregroundColor(.primaryVariant)
                    Text("\(previewMovie.vote_average) / 10.0")
                }.font(.headline)
            }
        }.transition(transition)
    }
    
    func loadImage() {
        guard let path = previewMovie.poster_path else {
            return
        }
        if !imageSuccess {
            NetworkManager().getImage(path: path) { (result) in
                switch result {
                case .success(let uiImage):
                    self.image = Image(uiImage: uiImage)
                    self.imageSuccess = true
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

struct MovieListRowSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRowSwiftUIView(previewMovie: popularInformation.results[5])
    }
}
