//
//  AlbumFeed.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import Foundation

struct AlbumFeed: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let id: String
    let author: Author
    let links: [Link]
    let copyright: String
    let country: String
    let icon: String
    let updated: String
    let results: [Result]
}

struct Author: Decodable {
    let name: String
    let url: String
}

struct Link: Decodable {
    let linkSelf: String
    
    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

struct Result: Decodable, Identifiable, Hashable {
    let artistName: String
    let id: String
    let name: String
    let releaseDate: String
    let kind: Kind
    let artistID: String
    let artistURL: String
    let contentAdvisoryRating: ContentAdvisoryRating?
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case contentAdvisoryRating, artworkUrl100, genres, url
    }
}

enum ContentAdvisoryRating: String, Decodable {
    case explict = "Explict"
}

enum Kind: String, Decodable {
    case albums = "albums"
}

class Genre: Decodable {
    let genreID: String
    let name: Name
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

enum Name: String, Decodable {
    case alternative = "Alternative"
    case childrenSMusic = "Children's Music"
    case christian = "Christian"
    case classical = "Classical"
    case country = "Country"
    case dance = "Dance"
    case electronic = "Electronic"
    case hipHopRap = "Hip-Hop/Rap"
    case latin = "Latin"
    case metal = "Metal"
    case music = "Music"
    case pop = "Pop"
    case rBSoul = "R&B/Soul"
    case rock = "Rock"
    case soundtrack = "Soundtrack"
    case worldwide = "Worldwide"
}

extension Result {
    static func == (lhs: Result, rhs: Result) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func mock() -> Result {
        Result(artistName: "", id: "", name: "", releaseDate: "", kind: Kind(rawValue: "albums")!, artistID: "", artistURL: "", contentAdvisoryRating: ContentAdvisoryRating(rawValue: "Explicit"), artworkUrl100: "", genres: [], url: "")
    }
}
