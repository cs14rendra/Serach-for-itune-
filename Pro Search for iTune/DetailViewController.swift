//
//  DetailViewController.swift
//  Pro Search for iTune
//
//  Created by surendra kumar on 2/20/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var musicVideo : MusicAndVideo?
    @IBOutlet var songName: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getImage()
        self.songName.text = musicVideo?.trackName
        tableView.estimatedRowHeight = 36
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.2)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.8)
        title = self.musicVideo?.artistName
        songName.textColor = RED
    }

    @IBAction func play(_ sender: Any) {
        let url = URL(string: (self.musicVideo?.previewURL)!)
        let player = AVPlayer(url: url!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) { 
            
            playerViewController.player?.play()
        }
    }
    
    @IBAction func buy(_ sender: Any) {
        let url = URL(string: (self.musicVideo?.trackViewURL)!)!
        print(url)
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as! DetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.field.text = "Release Date"
            cell.value.text = self.musicVideo?.releaseDate
        case 1:
            cell.field.text = "Track Time"
            var  t = 0.0
            //print(self.musicVideo?.trackTime)
            if let a = self.musicVideo?.trackTime{
                t = Double( a ) / (1000.0*60.0)
                cell.value.text = String(format: "%.2f", t) + " minute"
            }
        case 2:
            cell.field.text = "Track Price"
            cell.value.text = self.musicVideo?.trackPrice
        case 3:
            cell.field.text = "Currency"
            cell.value.text = self.musicVideo?.currency
        case 4:
            cell.field.text = "Country"
            cell.value.text =  self.musicVideo?.country
        default:
            cell.field.text = ""
            cell.value.text = ""
        }
        cell.backgroundColor = UIColor.clear
        let view = UIView()
        
        view.backgroundColor = RED.withAlphaComponent(0.15)
        cell.selectedBackgroundView = view
        return cell
    }
    
    func getImage(){
        DispatchQueue.main.async {
            
            if let a = self.musicVideo?.imageURL{
                print(a)
                let modified = a.replacingOccurrences(of: "100x100", with: "800x800")
                print(modified)
                self.imgView.sd_setImage(with:URL(string: modified) , placeholderImage: UIImage(named: "Placeholder"))
            }
            
            
            
        }
        
    }

}
