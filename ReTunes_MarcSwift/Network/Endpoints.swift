//
//  Endpoints.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import Foundation

struct iTunesEndpoint<Response: Decodable> {
    let url: URL
    let responseType: Response.Type
}

class Endpoints {
    
    static func iTunesTop100() -> iTunesEndpoint<AlbumFeed>{
        iTunesEndpoint(url: URL(string: "https://rss.applemarketingtools.com/api/v2/us/music/most-played/100/albums.json")!, responseType: AlbumFeed.self)
    }
}
