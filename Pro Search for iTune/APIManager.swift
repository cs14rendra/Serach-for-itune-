//
//  APIManager.swift
//  Pro Search for iTune
//
//  Created by surendra kumar on 2/19/17.
//  Copyright © 2017 weza. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIManagerdelegate {
    func dataAfterFetchFromserver(musicVideos: [MusicAndVideo])
}

class APIManager{
    
    var  delegate : APIManagerdelegate?
    
    
    func loadData(url : String){
        
            Alamofire.request(url).responseJSON { (response) in
            
            self.parseData(JsonData: response.data!)
            
        }
    }
    
    func parseData(JsonData : Data){
       
        do{
            var trackP : String?
            var trackT : Int?
            var MusicandVideos = [MusicAndVideo]()
            let readableJson = JSON(JsonData)
            let endpointArray = readableJson["results"]
            for index in 0..<endpointArray.count{
               
                if let trackPrice = endpointArray[index]["trackPrice"].number{
                    trackP = String(describing: trackPrice)
                }else{
                    trackP = ""
                }
                
                if let trackTime = endpointArray[index]["trackTimeMillis"].number{
                    trackT = trackTime as Int?
                }else{
                    trackT = 0
                }
                
                MusicandVideos.append(MusicAndVideo(
                    artistName: endpointArray[index]["artistName"].string,
                    trackName: endpointArray[index]["trackName"].string,
                    trackViewURL: endpointArray[index]["trackViewUrl"].string,
                    preViewURL: endpointArray[index]["previewUrl"].string,
                    imageURL: endpointArray[index]["artworkUrl100"].string,
                    trackPrice: trackP,
                    releaseDate: endpointArray[index]["releaseDate"].string,
                    trackTime: trackT,
                    //putting sting here ,was returning null, that was the major error
                    //so i jSON file if there is number and then use number not 
                    //string it took 4 hour of mine huh
                    country: endpointArray[index]["country"].string,
                    currency: endpointArray[index]["currency"].string,kind:endpointArray[index]["kind"].string ))
                
                

                
                
            }
            DispatchQueue.main.async {
               self.delegate?.dataAfterFetchFromserver(musicVideos: MusicandVideos)
            }
            
            
        }catch{
            print(error)
        }
    }
    
    
}
