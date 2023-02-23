//
//  TopAlbumsViewModel.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import Foundation
import SwiftUI

class TopAlbumsViewModel: ObservableObject {

    let app: ApplicationController
    let network: iTunesNetworkManager
    let database: DatabaseManageable
    
    @Published var navigationPath = NavigationPath()
    
    @Published var albums = [DatabaseAlbum]()
    
    @Published var favoriteAlbums = [DatabaseAlbum]()
    @Published var resultDetail: Result?
    private (set) var albumDetailViewModel: AlbumDetailViewModel?

    
    static func mock() -> TopAlbumsViewModel {
        return ApplicationController().topAlbumsViewModel
    }
    
    init(app: ApplicationController, network: iTunesNetworkManager, database: DatabaseManageable) {
        self.app = app
        self.network = network
        self.database = database
        initializationSequence()
    }
    
    
    private func initializationSequence() {
        Task {
            do {
                try await initializationSequenceAsync()
            } catch let error {
                print("Error initializing sequence: \(error)")
            }
        }
    }
    
    private func initializationSequenceAsync() async throws {
        await database.loadPersistence()
        await fetchData()
    }
    
    func fetchData() async {
        let manager = iTunesNetworkManager()
        
        var resultAlbums = [Result]()
            do {
                let feed = try await manager.fetch(endpoint: Endpoints.iTunesTop100())
                resultAlbums = feed.feed.results
                
            } catch let error {
                print("Network Failure: \(error)")
            }
        
        if resultAlbums.count > 0 {
            do {
                try await database.synchronize(albums: resultAlbums)
            } catch let error {
                print("Database Failure 1 \(error)")
            }
        }
        
        
        var dbAlbums = [ReTunesAlbum]()
        
        do {
            let _dbAlbums = try await database.fetchAlbums()

            dbAlbums.append(contentsOf: _dbAlbums)
            
        } catch let error {
            print("Fetch Albums Database Error 2: \(error)")
        }
            
        let _albums = dbAlbums.map { DatabaseAlbum(retunesAlbum: $0) }
        
        await MainActor.run {
            self.albums = _albums
            print(self.albums)
            updateFavoriteAlbums()
        }

    }
    
    private var fetchAlbumDetailTask: Task<Void, Never>?
    
    func fetchAlbumDetail(album: DatabaseAlbum) {
        
        fetchAlbumDetailTask = Task {
            await MainActor.run {
                self.albumDetailViewModelSpawn(album: album)
                
                if let albumDetailViewModel = self.albumDetailViewModel {
                    navigationPath.append(albumDetailViewModel)
                }
            }
        }
    }
    
    private func albumDetailViewModelSpawn(album: DatabaseAlbum) {
        
        albumDetailViewModel = AlbumDetailViewModel(topAlbumsViewModel: self, albumResult: album)
        print("Database Album: \(album)")
        
    }
    
    private func albumDetailViewModelDispose() {
        self.albumDetailViewModel = nil
    }
    
    func likeAlbum(album: DatabaseAlbum) {
        Task {
            do {
                try await database.favorite(id: album.id)
            } catch let error {
                print("Favorite Album Error: \(error)")
            }
            
            await MainActor.run {
                if let index = index(album: album) {
                    albums[index].favorite = true
                    updateFavoriteAlbums()
                }
            }
        }
    }
    
    func unlikeAlbum(album: DatabaseAlbum) {
        Task {
            do {
                try await database.unFavorite(id: album.id)
            } catch let error {
                print("UnFavorite Album Error: \(error)")
            }
          
            await MainActor.run {
                if let index = index(album: album) {
                    albums[index].favorite = false
                    updateFavoriteAlbums()
                }
            }
        }
    }
    
    func index(album: DatabaseAlbum) -> Int? {
        for index in 0..<albums.count {
            if albums[index].id == album.id {
                return index
            }
        }
        return nil
    }
    
    func updateFavoriteAlbums() {
        Task {
            await MainActor.run {
                favoriteAlbums = self.albums.filter {$0.favorite == true}
            }
        }
    }
}
