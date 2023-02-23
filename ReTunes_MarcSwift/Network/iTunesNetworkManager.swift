//
//  iTunesNetworkManager.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import Foundation

class iTunesNetworkManager {
    
    lazy var decoder: JSONDecoder = {
        JSONDecoder()
    }()
    
    
    func fetch<Response>(endpoint: iTunesEndpoint<Response>) async throws -> Response {
        let (data, response) = try await URLSession.shared.data(from: endpoint.url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard(200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(Response.self, from: data)
    }
}
