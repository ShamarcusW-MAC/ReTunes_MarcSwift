//
//  RootView.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var topAlbumsViewModel: TopAlbumsViewModel
    var body: some View {
        NavigationStack(path: $topAlbumsViewModel.navigationPath) {
            AlbumTabView(topAlbumsViewModel: topAlbumsViewModel)
        }
    }
}
