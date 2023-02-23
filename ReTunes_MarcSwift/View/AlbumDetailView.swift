//
//  AlbumDetailView.swift
//  ReTunes_MarcSwift
//
//  Created by Sha'Marcus Walker on 2/20/23.
//

import SwiftUI

struct AlbumDetailView: View {
    
    @ObservedObject var albumDetailViewModel: AlbumDetailViewModel
        
    var body: some View {
        GeometryReader { albumGeometry in
            ZStack {
                AsyncImage(url: URL(string: albumDetailViewModel.albumResult.artworkUrl100)) { image in
                    
                    image
                        .resizable()
                        .scaledToFill()
                        .overlay(Material.ultraThin)
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(width: albumGeometry.size.width, height: albumGeometry.size.height)
                                
                VStack {
                    AsyncImage(url: URL(string: albumDetailViewModel.albumResult.artworkUrl100)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 56)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: albumGeometry.size.width, height: albumGeometry.size.height / 3)
                                        
                    VStack {
                        
                        Spacer()

                        HStack {

                            Text("Song Name: ")
                                .foregroundColor(Color("Cell_Blue"))
                                .padding(.leading, 32)

                            Spacer()

                            Text(albumDetailViewModel.albumResult.name)
                                .foregroundColor(Color("Cell_Blue"))
                                .padding(.trailing, 32)
                                .lineLimit(1)
                            
                        }
                        .frame(width: albumGeometry.size.width)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.gray))

                        Spacer()

                        HStack {

                            Text("Artist Name: ")
                                .foregroundColor(.gray)
                                .padding(.leading, 32)


                            Spacer()
                            
                            Text(albumDetailViewModel.albumResult.artistName)
                                .foregroundColor(.gray)
                                .padding(.trailing, 32)
                                .lineLimit(1)

                            
                        }
                        .frame(width: albumGeometry.size.width)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(Color("Cell_Blue")))
                        

                        Spacer()

                        HStack {

                            Text("Release Date: ")
                                .foregroundColor(.white)
                                .padding(.leading, 32)


                            Spacer()
                            
                            Text(albumDetailViewModel.albumResult.releaseDate)
                                .foregroundColor(.white)
                                .padding(.trailing, 32)

                            
                        }
                        .frame(width: albumGeometry.size.width)
                        .background(RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(.black))
                        
                        Spacer()
        
                        
                    }
                    .frame(width: albumGeometry.size.width)
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)

                    
                    Spacer()
                    
                    
                    Button {
                        if albumDetailViewModel.albumResult.favorite {
                            albumDetailViewModel.topAlbumsViewModel.unlikeAlbum(album: albumDetailViewModel.albumResult)
                        } else {
                            albumDetailViewModel.topAlbumsViewModel.likeAlbum(album: albumDetailViewModel.albumResult)
                        }
                    } label: {
                        Image(systemName: albumDetailViewModel.albumResult.favorite ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: albumGeometry.size.width / 15 ,height: albumGeometry.size.height / 20)
                            .foregroundColor(albumDetailViewModel.albumResult.favorite ? .red: .white)
                            .padding(.bottom, 8)
                            .padding(.trailing, 16)
                    }


                }
                
            }
            .background(Color.black)

        }
    }
}

struct AlbumDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumDetailView(albumDetailViewModel: AlbumDetailViewModel.mock())
    }
}
