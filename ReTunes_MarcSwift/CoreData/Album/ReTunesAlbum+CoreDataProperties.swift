//
//  ReTunesAlbum+CoreDataProperties.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/23/23.
//
//

import Foundation
import CoreData


extension ReTunesAlbum {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReTunesAlbum> {
        return NSFetchRequest<ReTunesAlbum>(entityName: "ReTunesAlbum")
    }

    @NSManaged public var artistID: String?
    @NSManaged public var artistName: String?
    @NSManaged public var artistURL: String?
    @NSManaged public var artworkUrl100: String?
    @NSManaged public var favorite: Bool
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var url: String?
    @NSManaged public var genre: NSSet?
    
    var genreArray: [TunesGenre] {
        let set = genre as? Set<TunesGenre> ?? []
        
        return set.sorted {
            $0.wrappedGenreID < $1.wrappedGenreID
        }
    }

}

// MARK: Generated accessors for genre
extension ReTunesAlbum {

    @objc(addGenreObject:)
    @NSManaged public func addToGenre(_ value: TunesGenre)

    @objc(removeGenreObject:)
    @NSManaged public func removeFromGenre(_ value: TunesGenre)

    @objc(addGenre:)
    @NSManaged public func addToGenre(_ values: NSSet)

    @objc(removeGenre:)
    @NSManaged public func removeFromGenre(_ values: NSSet)

}

extension ReTunesAlbum : Identifiable {

}
