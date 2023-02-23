//
//  AlbumDetailViewModel.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import Foundation
import AVFoundation

class AlbumDetailViewModel: ObservableObject {
    
    static func mock() -> AlbumDetailViewModel {
        AlbumDetailViewModel(topAlbumsViewModel: TopAlbumsViewModel.mock(), albumResult: DatabaseAlbum.mock())
    }
    let topAlbumsViewModel: TopAlbumsViewModel
    let albumResult: DatabaseAlbum
    
    
    init(topAlbumsViewModel: TopAlbumsViewModel, albumResult: DatabaseAlbum) {
        self.topAlbumsViewModel = topAlbumsViewModel
        self.albumResult = albumResult
        
        print("\(self.albumResult.name.capitalized) Album detail view model created!")
    }
    
    deinit {
        print("\(self.albumResult.name.capitalized) Album detail view model destroyed")
    }
    
}

extension AlbumDetailViewModel: Hashable {
    static func == (lhs: AlbumDetailViewModel, rhs: AlbumDetailViewModel) -> Bool {
        lhs.albumResult.id == rhs.albumResult.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(albumResult.id)
    }
}
