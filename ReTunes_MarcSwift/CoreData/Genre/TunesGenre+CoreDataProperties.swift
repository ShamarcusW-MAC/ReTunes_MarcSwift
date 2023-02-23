//
//  TunesGenre+CoreDataProperties.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/23/23.
//
//

import Foundation
import CoreData


extension TunesGenre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TunesGenre> {
        return NSFetchRequest<TunesGenre>(entityName: "TunesGenre")
    }

    @NSManaged public var genreID: String?
    @NSManaged public var genreUrl: String?
    @NSManaged public var album: ReTunesAlbum?

    
    public var wrappedGenreID: String {
        genreID ?? "Unknown genre id"
    }
    
    public var wrappedGenreUrl: String {
        genreUrl ?? "Unknown genre url"
    }
}
