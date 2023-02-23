//
//  AlbumTabView.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import SwiftUI

struct AlbumTabView: View {
    
    @ObservedObject var topAlbumsViewModel: TopAlbumsViewModel

    private let gridColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    
    init(topAlbumsViewModel: TopAlbumsViewModel) {
        self.topAlbumsViewModel = topAlbumsViewModel
        UITabBar.appearance().backgroundColor = UIColor.lightGray
    }
    
    var body: some View {
        
        TabView {
            TopAlbumsView(topAlbumsViewModel: topAlbumsViewModel)
            .tabItem {
                Label("Home", systemImage: "house")
            }
            FavoriteAlbumsView(topAlbumsViewModel: topAlbumsViewModel)
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }
        }
        .accentColor(Color("Cell_Blue"))
    }
}

struct AlbumTabView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumTabView(topAlbumsViewModel: TopAlbumsViewModel.mock())
    }
}
