//
//  MVTableViewCell.swift
//  Pro Search for iTune
//
//  Created by surendra kumar on 2/20/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit
import SDWebImage
class MVTableViewCell: UITableViewCell {

    var musicVideo : MusicAndVideo?{
        didSet{
            updateCell()
        }
    }
    
   
    @IBOutlet var artistName: UILabel!
    @IBOutlet var trackName: UILabel!
    @IBOutlet var imgView: UIImageView!

    
    func updateCell(){
        artistName.text = musicVideo?.artistName
        trackName.text = musicVideo?.trackName
        getImage()
           
        
    }
    
    func getImage(){
        DispatchQueue.main.async {
            
            
            if let a = self.musicVideo?.imageURL{
                let modified = a.replacingOccurrences(of: "100x100", with: "200x200")

                self.imgView.sd_setImage(with:URL(string: modified) , placeholderImage: UIImage(named: "Placeholder"))
            }
           
        
            
        }
        
    }

}
