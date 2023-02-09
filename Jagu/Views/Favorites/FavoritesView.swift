//
//  Favoritesview.swift
//  Jagu
//
//  Created by Artur Hellmann on 08.02.23.
//

import SwiftUI
import SwiftDose

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(Array(viewModel.favorites.enumerated()), id: \.element.path) { favEnum in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(favEnum.element.name)
                                .lineLimit(1)
                                .fontWeight(.bold)
                            Text(favEnum.element.path)
                                .lineLimit(1)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                        Button("delete") {
                            viewModel.delete(favorite: favEnum.element)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        viewModel.favoriteSelected(favorite: favEnum.element)
                        dismiss()
                    }
                }
            }
            .padding()
        }
        .frame(minWidth: 350, minHeight: 300)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    
    init() {
        DoseValues[FavoriteRepoServiceProvider.self] = PreviewFavoriteRepoService()
    }
    
    static var previews: some View {
        FavoritesView(
            viewModel: FavoritesViewModel(
                favoriteRepoService: PreviewFavoriteRepoService()
            )
        )
    }
}

private class PreviewFavoriteRepoService: FavoriteRepoService {
    
    override var favorites: [RepoFavorite] {
        [
            RepoFavorite(path: "repo/number/one/name is/this name"),
            RepoFavorite(path: "repo/number/two/cool name")
        ]
    }
}
