//
//  ApplicationController.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import Foundation

class ApplicationController {
    lazy var database: ReTunesDatabase = {
        ReTunesDatabase()
    }()
    
    
    lazy var networkManager: iTunesNetworkManager = {
        iTunesNetworkManager()
    }()
        
    static func mock() -> ApplicationController {
        ApplicationController()
    }
    
    lazy var topAlbumsViewModel: TopAlbumsViewModel = {
        
        TopAlbumsViewModel(app: self, network: networkManager, database: database)
        
    }()
}
