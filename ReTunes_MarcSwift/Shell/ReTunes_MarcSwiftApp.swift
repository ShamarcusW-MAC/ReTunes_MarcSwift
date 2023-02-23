//
//  ReTunes_MarcSwiftApp.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import SwiftUI

@main
struct ReTunes_MarcSwiftApp: App {
    
    let app = ApplicationController()
    var body: some Scene {
        WindowGroup {
            RootView(topAlbumsViewModel: app.topAlbumsViewModel)
        }
    }
}
