//
//  DemoViewController.swift
//  Pro Search for iTune
//
//  Created by surendra kumar on 2/21/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewConrtrolle: UITableViewController,MFMailComposeViewControllerDelegate {

    
    @IBOutlet var slidercount: UISlider!
    @IBOutlet var limit: UILabel!
   override func viewDidLoad() {
        super.viewDidLoad()
   
    
    let defaults = Foundation.UserDefaults.standard
    if let a = defaults.string(forKey: "limit"){
        self.limit.text = a
        self.slidercount.value = Float(a)!
    }
    
   }
    
    @IBAction func sliderbtn(_ sender: UISlider) {
        let value = String(Int(sender.value))
        self.limit.text = value
        print(value)
        let defaults = Foundation.UserDefaults.standard
        defaults.set(value, forKey: "limit")
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
            //feedback
            let mailComposeViewController = configureMail()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
                
            }else{
                mailAlert()
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.section == 0 && indexPath.row == 1{
            //rate on appstore
            rateonAppStore()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
   
    
    func rateonAppStore(){
        let url : URL = URL(string: "https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=\(APPID)&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=7")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    func configureMail() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["cs14rendra@hotmail.com"])
        mailComposeVC.setSubject("Pro search for iTune Feedback")
        mailComposeVC.setMessageBody("Hi WezaApp,\n\nI would like to share the following feedback\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("Mail cancled")
        case MFMailComposeResult.saved.rawValue:
            print("Mail Saved")
            
        case MFMailComposeResult.sent.rawValue:
            print("Mail Sent")
            
        case MFMailComposeResult.failed.rawValue:
            print("Mail Failed")
            
        default:
            print("Unknown Issue")
        }
        self.dismiss(animated: true, completion: nil)
    }
    func mailAlert(){
        let alert : UIAlertController = UIAlertController(title: "Alert", message: "No e-Mail account setup for iPhone", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
            //
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
   }
