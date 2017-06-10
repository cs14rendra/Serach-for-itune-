//
//  ViewController.swift
//  Pro Search for iTune
//
//  Created by surendra kumar on 2/19/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit
import AlertOnboarding

extension MVTableViewController {
    func cutomizeAlertView(){
        self.alertView.percentageRatioWidth = 0.95
        self.alertView.percentageRatioHeight = 0.93
        self.alertView.colorButtonText = RED
        self.alertView.colorCurrentPageIndicator = RED
        self.alertView.colorPageIndicator = RED.withAlphaComponent(0.30)
        self.alertView.colorTitleLabel = RED.withAlphaComponent(0.70)
        self.alertView.colorButtonBottomBackground = RED.withAlphaComponent(0.27)
        
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
}

class MVTableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,APIManagerdelegate,UITextFieldDelegate,AlertOnboardingDelegate {
    
    var activity : UIActivityIndicatorView?
    var alertView: AlertOnboarding!
    var term = "justin"
    var type = "musicVideo"
    var limit = "10"
    var a = 0
    var musicVideos = [MusicAndVideo]()
    let manager = APIManager()
    var arrayOfImage = ["item1", "item2", "item3"]
    var arrayOfTitle = ["SEARCH ITEM", "FILTER ITEM", "PLAY AND BUY"]
    var arrayOfDescription = ["search for a music or musicVideo by entering artist name or some keyword of lyrics for song",
                              "you can filter search, choose it on top-left corner of the App,selected option will apear on the button",
                              "preview  msuic and musicVideo item by clicking on play button and buy it from ituneStore using buy button"]
    
    @IBOutlet var searchbtn: UIBarButtonItem!
    @IBOutlet var menuView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var filter: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        manager.delegate = self
        setUserdafaultValueatFirstLaunchofApp()
        setimageIcon()
        textField.layer.cornerRadius = textField.frame.size.height/2
        textField.tintColor = RED
        textField.layer.borderColor = RED.cgColor
        textField.layer.borderWidth = 1.0
        tableView.separatorColor = UIColor.clear
        //Alert
        alertView = AlertOnboarding(arrayOfImage: arrayOfImage, arrayOfTitle: arrayOfTitle, arrayOfDescription: arrayOfDescription)
        alertView.delegate = self
        
        let btn: UIButton = UIButton()
    
        btn.backgroundColor = UIColor(red:0.25, green:0.04, blue:0.04, alpha:1.0)
        btn.setTitle(" Me", for: .normal)
        btn.addTarget(self, action: #selector(MVTableViewController.buttonAction(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -13).isActive = true
        btn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.widthAnchor.constraint(equalToConstant: 50).isActive = true
            btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 25.0
        btn.showsTouchWhenHighlighted = true
        btn.setImage(UIImage(named:"plus"), for: .normal)
        btn.tintColor = UIColor.white
        let rate = RateMyApp.sharedInstance
        rate.appID = APPID
        rate.trackAppUsage()
        createAcivity()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !isAppAlreadyLaunchedOnce(){
            self.cutomizeAlertView()
            self.alertView.show()
        }
        
        
    }

    
    //APIManagerDelegate
    func dataAfterFetchFromserver(musicVideos: [MusicAndVideo]) {
        
        if let _ = self.activity?.isAnimating {
            self.activity?.stopAnimating()
        }
        self.musicVideos = musicVideos
        tableView.reloadData()
            for index in 0..<musicVideos.count{
            print(musicVideos[index].trackName)
            }
        if musicVideos.count == 0 {
            print("NO data found")
            let alert = UIAlertController(title: "Sorry", message: "No record found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //populate table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicVideos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MVTableViewCell
        cell.musicVideo = musicVideos[indexPath.row]
        cell.imgView?.layer.masksToBounds = true
        cell.imgView?.layer.cornerRadius = 7.0
        let view = UIView()
        
        view.backgroundColor = RED.withAlphaComponent(0.15)
        cell.selectedBackgroundView = view
        return cell
    }
    
    
    @IBAction func musicVideoSearch(_ sender: Any) {
        let defaults = Foundation.UserDefaults.standard
        defaults.set("musicVideo", forKey: "type")
        defaults.set("all", forKey: "img")
        let originalimage = UIImage(named: "video")
        filter.image = UIImage(cgImage: (originalimage?.cgImage)!, scale: 20, orientation: (originalimage?.imageOrientation)!)
        UIView.animate(withDuration: 0.3, animations: {
            
            self.menuView.transform = .identity
            self.tableView.transform = .identity
        })
    }
    @IBAction func musicSearch(_ sender: Any) {
        let defaults = Foundation.UserDefaults.standard
        defaults.set("music", forKey: "type")
        defaults.set("music", forKey: "img")
        let originalimage = UIImage(named: "music")
        filter.image = UIImage(cgImage: (originalimage?.cgImage)!, scale: 20, orientation: (originalimage?.imageOrientation)!)
        UIView.animate(withDuration: 0.3, animations: {
            
            self.menuView.transform = .identity
            self.tableView.transform = .identity
        })
    }
    @IBAction func allSearch(_ sender: Any) {
        let defaults = Foundation.UserDefaults.standard
        defaults.set("musicVideo&media=music", forKey: "type")
        defaults.set("video", forKey: "img")
        let originalimage = UIImage(named: "all")
        filter.image = UIImage(cgImage: (originalimage?.cgImage)!, scale: 15, orientation: (originalimage?.imageOrientation)!)
        UIView.animate(withDuration: 0.3, animations: {
            
            self.menuView.transform = .identity
            self.tableView.transform = .identity
        })
    }
    @IBAction func search(_ sender: Any) {
        
            getUserDefaultValue()
            let originatext = textField.text!
            let modyfied = originatext.replacingOccurrences(of: " ", with: "+")
            self.term = modyfied
            textField.text = ""
            print("\(self.type)")
            print("\(self.limit)")
            self.textField.endEditing(true)
            let url = "https://itunes.apple.com/search?term=\(self.term)&country=US&media=\(self.type)&limit=\(self.limit)"
            manager.loadData(url: url)
            //Add progress animation here
            self.activity?.startAnimating()
        
    }
    @IBAction func filter(_ sender: Any) {
        if self.menuView.transform == .identity{
            UIView.animate(withDuration: 0.3, animations: {
                
                self.menuView.transform = CGAffineTransform(translationX: 0, y: CGFloat(73))
                self.tableView.transform = CGAffineTransform(translationX: 0, y: CGFloat(73))
                
            })
        }else{
           UIView.animate(withDuration: 0.3, animations: {
            
             self.menuView.transform = .identity
            self.tableView.transform = .identity
           })
        }
    }
    
    
    
    
    func setUserdafaultValueatFirstLaunchofApp(){
        let defaults = Foundation.UserDefaults.standard
        if defaults.string(forKey: "type") != nil{
            //self.type = type
            // need to change logo too
        }else{
            defaults.set("musicVideo&media=music", forKey: type)
            let originalimage = UIImage(named: "all")
            filter.image = UIImage(cgImage: (originalimage?.cgImage)!, scale: 15, orientation: (originalimage?.imageOrientation)!)
        }
        if defaults.string(forKey: "limit") != nil{
            //self.limit = limit
        }else{
            defaults.set("10", forKey: "limit")
        }
        
        if defaults.string(forKey: "img") != nil{
            
        }else{
            defaults.set("all", forKey: "img")
        }
    }
    
    
    func getUserDefaultValue(){
        //need only at search button will tapped
        //take it and store in variable
        //its sure that default have value still play safe side
        let defaults = Foundation.UserDefaults.standard
        if let type = defaults.string(forKey: "type"){
            self.type = type
        }
        
        if let limit = defaults.string(forKey: "limit"){
            self.limit = limit
        }
    }
    
    
    
    func setimageIcon(){
        let defaults = Foundation.UserDefaults.standard
        let imagetype = defaults.string(forKey: "img")!
        if imagetype == "all"{
            let originalimage = UIImage(named: "all")
            filter.image = UIImage(cgImage: (originalimage?.cgImage)!, scale: 15, orientation: (originalimage?.imageOrientation)!)
        }else if imagetype == "music"{
            let originalimage = UIImage(named: "music")
            filter.image = UIImage(cgImage: (originalimage?.cgImage)!, scale: 20, orientation: (originalimage?.imageOrientation)!)
        }else{
            let originalimage = UIImage(named: "video")
            filter.image = UIImage(cgImage: (originalimage?.cgImage)!, scale: 20, orientation: (originalimage?.imageOrientation)!)
        }
        
        }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "musicVideoDetails" {
            if let indexPath = tableView.indexPathForSelectedRow{
                let destination = segue.destination as! DetailViewController
                destination.musicVideo = self.musicVideos[indexPath.row]
            }
        }
        
        if segue.identifier == "settings" {
            
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.backgroundColor = UIColor.clear.cgColor
        //Apply Circular 
        let numberofCellPossible = Int(UIScreen.main.bounds.height / cell.bounds.height)
        let finalvalue = numberofCellPossible + 5
         if a <= finalvalue {
            a = a+1
        let whiteRoundView = UIView(frame: CGRect(x: 7, y: 8, width: cell.frame.size.width-14, height: cell.frame.size.height-10))
            whiteRoundView.layer.backgroundColor = RED.cgColor
            whiteRoundView.layer.masksToBounds = false
        whiteRoundView.layer.cornerRadius = 6.0
        whiteRoundView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundView.layer.shadowOpacity = 0.2
        cell.contentView.addSubview(whiteRoundView)
        cell.contentView.sendSubview(toBack: whiteRoundView)
        print("Value of a is : \(a)")
            print(UIScreen.main.bounds.size.height)
            print("2nd : \(UIScreen.main.bounds.height)")
            print("cell size is : \(cell.bounds.size.height)")
            
        }
        cell.transform = CGAffineTransform(translationX: 0, y: tableView.frame.size.height)
        UIView.animate(withDuration: 0.4) {
            cell.alpha = 1.0
            cell.transform = CGAffineTransform.identity
        }
    }
    
    
    // ALERT DELEGATE 
    func alertOnboardingCompleted() {
        
        
    }
    
    func alertOnboardingNext(_ nextStep: Int) {
        
        
    }
    
    func alertOnboardingSkipped(_ currentStep: Int, maxStep: Int) {
        
        
    }
    
    func buttonAction(sender : UIButton){
        print("btn")
        performSegue(withIdentifier: "settings", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func createAcivity(){
       
        
        activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activity?.center = CGPoint(x: self.view.center.x, y: self.view.center.y-(self.navigationController?.navigationBar.frame.size.height)!)
        activity?.hidesWhenStopped = true
        activity?.activityIndicatorViewStyle = .gray
        activity?.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        activity?.color = RED
        activity?.layer.masksToBounds = true
        activity?.layer.cornerRadius = 7.0
        self.view.addSubview(activity!)
       
    }
}

