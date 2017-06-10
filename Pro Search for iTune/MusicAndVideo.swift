//
//  ItuneData.swift
//  Pro Search for iTune
//
//  Created by surendra kumar on 2/19/17.
//  Copyright © 2017 weza. All rights reserved.
//

import Foundation

class MusicAndVideo: NSObject {
    
    var kind = ""
    var artistName = ""
    var trackName = ""
    var trackViewURL = ""
    var previewURL = ""
    var imageURL  = ""
    var trackPrice = ""
    var releaseDate = ""
    var trackTime = 0
    var country = ""
    var currency = ""
    
    var imageData : NSData?
    init(artistName : String?,trackName
        :String?,trackViewURL: String?,preViewURL : String?,imageURL: String?,trackPrice: String?,releaseDate : String?,trackTime : Int?,country : String?,currency: String?,kind: String?) {
        
        if let data  = artistName{
            self.artistName = data
        }else{
            self.artistName = ""
        }
        
        if let data  = trackName{
           self.trackName = data
        }else{
        self.trackName = ""
        }
        
        if let data  = trackViewURL{
            self.trackViewURL = data
        }else{
            self.trackViewURL = ""
        }
        if let data = preViewURL{
            self.previewURL = data
        }else{
            self.previewURL = ""
        }
        if let data = imageURL{
            self.imageURL = data
        }else{
            self.imageURL = ""
        }
        if let data = trackPrice{
            self.trackPrice = data
        }else{
            self.trackPrice = ""
        }
        
        if let data = releaseDate{
            self.releaseDate = data
        }else{
            self.releaseDate = ""
        }
        
        if let data = trackTime{
            self.trackTime = data
        }else{
            self.trackTime = 0
        }
        
        if let data = country {
            self.country = data
        }else{
            self.country = ""
        }
        if let data = currency{
            self.currency = data
        }else{
            self.currency = ""
        }
        if let data = kind{
            self.kind = data
        }else{
            self.kind = ""
        }
        
    }
    
}
