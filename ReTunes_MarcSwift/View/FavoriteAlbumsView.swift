//
//  FavoriteAlbumsView.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import SwiftUI

struct FavoriteAlbumsView: View {
    
    @ObservedObject var topAlbumsViewModel: TopAlbumsViewModel

    private let gridColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State var isLiked = true

    var body: some View {
        
        GeometryReader { albumGeometry in
            VStack {
                Text("Liked Albums")
                    .frame(width: albumGeometry.size.width, height: albumGeometry.size.height / 20)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .background(RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(Color(uiColor: UIColor.lightGray)))
                
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 24) {
                        ForEach(topAlbumsViewModel.favoriteAlbums, id: \.self) { album in
                            Button {
                                //code to fetch album detail
                                topAlbumsViewModel.fetchAlbumDetail(album: album)
                            } label: {
                                
                                    VStack {
                                        AsyncImage(url: URL(string: album.artworkUrl100)) { image in
                                            
                                            image
                                                .resizable()
                                                .scaledToFill()

                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: albumGeometry.size.width / 3, height: albumGeometry.size.height / 5)
                                        
                                        
                                        Text(album.name)
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                        Text(album.artistName)
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                            .padding(.bottom, 16)
                                    }
                                    .frame(width: albumGeometry.size.width / 2, height: albumGeometry.size.height / 3)
                                    .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color("Cell_Blue"))
                                        .shadow(radius: 3)
                                    )
                                    .overlay(alignment: .bottomTrailing) {
                                        ZStack {
                                            Button {
                                                //code to like album
                                                if album.favorite {
                                                    topAlbumsViewModel.unlikeAlbum(album: album)
                                                } else {
                                                    topAlbumsViewModel.likeAlbum(album: album)
                                                }
                                                
                                            } label: {
                                                
                                                Image(systemName: album.favorite ? "heart.fill" : "heart")
                                                    .foregroundColor(album.favorite ? .gray: .white)
                                                    .padding(.bottom, 8)
                                                    .padding(.trailing, 16)
                                            }
                                            
                                        }
                                        .disabled(true)
                                    }
                            }
                            
                        }
                    }
                }
                .navigationDestination(for: AlbumDetailViewModel.self) { albumDetailViewModel in
                    AlbumDetailView(albumDetailViewModel: albumDetailViewModel)
                }
            }
            .background(Color.black)
        }
    }
}

struct FavoriteAlbumsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteAlbumsView(topAlbumsViewModel: TopAlbumsViewModel.mock())
    }
}
