//
//  ReTunesDatabase.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/22/23.
//

import Foundation
import CoreData

protocol DatabaseManageable {
    func loadPersistence() async
    func fetchAlbums() async throws -> [ReTunesAlbum]
    func synchronize(albums: [Result]) async throws
    func favorite(id: String) async throws
    func unFavorite(id: String) async throws
}

class ReTunesDatabase: DatabaseManageable {
    
    let container: NSPersistentContainer
    
    required init() {
        container = NSPersistentContainer(name: "Albums")
    }
    
    func loadPersistence() async {
        await withCheckedContinuation { continuation in
            container.loadPersistentStores { description, error in
                if let error = error {
                    print("Load Persistence: \(error)")
                }
                continuation.resume()
            }
            
        }
    }
    
    func synchronize(albums: [Result]) async throws {
        let dbAlbums = try await fetchAlbums()
        
        var dbAlbumsDict = [String: ReTunesAlbum]()
                
        for album in dbAlbums {
            if let id = album.id, id.count > 0 {
                dbAlbumsDict[id] = album
            }
        }
        
        let context = container.viewContext
        
        try await context.perform {
            
            for albumResult in albums where albumResult.id.count > 0 {
                if let dbAlbum = dbAlbumsDict[albumResult.id] {
                    //Upadte existing entry
                    dbAlbum.name = albumResult.name
                    dbAlbum.artistName = albumResult.artistName
                    dbAlbum.artworkUrl100 = albumResult.artworkUrl100
                    dbAlbum.artistID = albumResult.artistID
                    dbAlbum.releaseDate = albumResult.releaseDate
                    
                    print("Existing database album before: \(dbAlbum)")
                } else {
                    //Create new entry
                    let dbAlbum = ReTunesAlbum(context: context)
                    dbAlbum.name = albumResult.name
                    dbAlbum.artistName = albumResult.artistName
                    dbAlbum.artworkUrl100 = albumResult.artworkUrl100
                    dbAlbum.id = albumResult.id
                    dbAlbum.artistID = albumResult.artistID
                    dbAlbum.releaseDate = albumResult.releaseDate
                    dbAlbum.favorite = false
                    print("Database album before: \(dbAlbum)")

                }
            }
            
            try context.save()
        }
    }
    
    func fetchAlbums() async throws -> [ReTunesAlbum] {
        
        let context = container.viewContext
        var results = [ReTunesAlbum]()
        try await context.perform {
            let fetchRequest = ReTunesAlbum.fetchRequest()
            results = try context.fetch(fetchRequest)
        }
        
        return results
    }
    
    func favorite(id: String) async throws {
        let context = container.viewContext
        try await context.perform {
            let fetchRequest = ReTunesAlbum.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let dbAlbums = try context.fetch(fetchRequest)
            if let dbAlbum = dbAlbums.first {
                dbAlbum.favorite = true
                try context.save()
            }
        }
    }
    
    func unFavorite(id: String) async throws {
        let context = container.viewContext
        try await context.perform {
            let fetchRequest = ReTunesAlbum.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let dbAlbums = try context.fetch(fetchRequest)
            if let dbAlbum = dbAlbums.first {
                dbAlbum.favorite = false
                try context.save()
            }
        }
    }
}
