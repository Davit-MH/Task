//
//  ArticleData.swift
//  Task
//
//  Created by Davit Martirosyan on 02.02.21.
//

import Foundation



struct ArticleData : Codable{
    
    let success : Bool
    let metadata : [MetaData]
   
}

struct MetaData : Codable {
    
    let category : String
    let title : String
    let body : String
    let shareUrl : String
    let coverPhotoUrl : String
    let date : Int
    let gallery : [GalleryData]? 
    let video : [VideoData]?
    
}

struct GalleryData : Codable {
    
    let title : String
    let thumbnailUrl : String
    let contentUrl : String
    
}

struct VideoData : Codable {
    
    let title : String
    let thumbnailUrl : String
    let youtubeId : String
}
