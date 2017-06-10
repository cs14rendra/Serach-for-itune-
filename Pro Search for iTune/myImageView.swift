//
//  myImageView.swift
//  Pro Search for iTune
//
//  Created by surendra kumar on 2/21/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit

class myImageView: UIImage {
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required convenience init(imageLiteralResourceName name: String) {
        fatalError("init(imageLiteralResourceName:) has not been implemented")
    }
    
    override func draw(in rect: CGRect) {
        
        
    }
}
