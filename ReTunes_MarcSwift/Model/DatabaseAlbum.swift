//
//  DatabaseAlbum.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/22/23.
//

import Foundation

struct DatabaseAlbum: Identifiable {
    let id: String
    let name: String
    let artistName: String
    let artistID: String
    let artworkUrl100: String
    let releaseDate: String
    let genre: [TunesGenre]
    var favorite: Bool
    
    init(retunesAlbum: ReTunesAlbum) {
        self.init(id: retunesAlbum.id ?? "", name: retunesAlbum.name ?? "", artistName: retunesAlbum.artistName ?? "", artistID: retunesAlbum.artistID ?? "", artworkUrl100: retunesAlbum.artworkUrl100 ?? "", releaseDate: retunesAlbum.releaseDate ?? "1-1-1111", genre: retunesAlbum.genreArray, favorite: retunesAlbum.favorite)
    }
    
    init(id: String, name: String, artistName: String, artistID: String, artworkUrl100: String, releaseDate: String, genre: [TunesGenre], favorite: Bool) {
        self.id = id
        self.name = name
        self.artistName = artistName
        self.artistID = artistID
        self.artworkUrl100 = artworkUrl100
        self.releaseDate = releaseDate
        self.genre = genre
        self.favorite = favorite
    }
}

extension DatabaseAlbum: Hashable {
    static func == (lhs: DatabaseAlbum, rhs: DatabaseAlbum) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func mock() -> DatabaseAlbum {
        DatabaseAlbum(id: "1", name: "Best In The World", artistName: "Marcus Money", artistID: "12345", artworkUrl100: "", releaseDate: "1-1-2023",genre: [], favorite: false)

    }
}

//struct DatabaseGenre: Identifiable {
//    let id: String
//    let url: String
//    let genreID: String
//
//
//}
