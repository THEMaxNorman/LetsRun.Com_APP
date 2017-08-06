//
//  ViewController.swift
//  LetsRun.Com
//
//  Created by Max Norman on 7/11/17.
//  Copyright © 2017 Max Norman. All rights reserved.
//

import UIKit
import  CoreData

class ViewController: UIViewController, UIWebViewDelegate {
    //The current url the user is looking at
    //used for saving favorites
    var currentUrl = "";
    
    //the user of the account - only one
    var user = userAccount();
    
    @IBOutlet weak var loginScreen: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        if(user.userName != nil){
            loginScreen.isHidden = true;
        }
        popUp.isHidden = true;
        self.webView.delegate = self;
        let url = NSURL (string: "http://www.letsrun.com");
        let request = NSURLRequest(url: url! as URL);
        webView.loadRequest(request as URLRequest);
    }
    
    var filePath: String {
        //1 - manager lets you examine contents of a files and folders in your app; creates a directory to where we are saving it
        let manager = FileManager.default
        //2 - this returns an array of urls from our documentDirectory and we take the first path
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        //print("this is the url path in the documentDirectory \(url)")
        //3 - creates a new path component and creates a new file called "Data" which is where we will store our Data array.
        return (url!.appendingPathComponent("Data").path)
    }
    
    func saveData(user : userAccount) {
        NSKeyedArchiver.archiveRootObject(user, toFile: filePath)
    }
    
    func loadData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? userAccount {
            user = ourData
        }
    }
    
    @IBOutlet weak var popUp: UIView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var webView: UIWebView!

    @IBOutlet weak var popUpNamer: UITextField!
   
    @IBAction func OpenFavorite(_ sender: Any) {
        
        webView.loadHTMLString(user.htmlFavs() , baseURL: nil)
    }
    var htmlTitle = "";
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.scalesPageToFit = true;
       if let text = webView.request?.url?.absoluteString{
            currentUrl = text;
            //SearchBar.text = currentUrl;
            //print(text);
            if(webView.stringByEvaluatingJavaScript(from: "document.title") != nil){
                htmlTitle = webView.stringByEvaluatingJavaScript(from: "document.title")!;
            }
        
        }
        //gonna be a cool feature
        

        var userName = "'"
        if(user.userName != nil){
            userName.append(user.userName!);
        }
        userName.append("'");
        print(userName)
        if(currentUrl.contains("reply") || htmlTitle.contains("New Post")){
            if (true) {
                let loadUsernameJS = "document.getElementsByName('author')[0].value = \(userName)"
                
                var user = webView.stringByEvaluatingJavaScript(from: loadUsernameJS);
                print(user);
            
            }
        }
    }
        

  
    @IBAction func Beginsave(_ sender: Any) {
         //Shows the popup which allows the user to name the link
        popUp.isHidden = false;
        if(htmlTitle != nil){
            popUpNamer.text = htmlTitle;
        }
    }
    
    @IBAction func save(_ sender: Any) {
        //lets the user name the thread and then saves it using the threads url
        user.addFavLink(Link: currentUrl, Name: popUpNamer.text!);
        popUp.isHidden = true;
        popUpNamer.text = "";
        popUpNamer.resignFirstResponder();
        saveData(user: user)
        
        

    }
    @IBAction func closePopUp(_ sender: Any) {
        popUp.isHidden = true;
    }
 
    @IBOutlet weak var userText: UITextField!
    
    @IBAction func SubmitButton(_ sender: Any) {
        //submits the username and saves it
        user.userName = userText.text;
        saveData(user: user)
        
        //hides all the bs
        loginScreen.isHidden = true;
        userText.resignFirstResponder();

    }
    
   
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var timeCalc: UIView!
    @IBOutlet weak var timeField: UITextField!
    @IBOutlet weak var distanceField: UITextField!
    @IBAction func openTimeCalc(_ sender: Any) {
        timeCalc.isHidden = false;
        print("Open")
    }
    @IBAction func ShowConv(_ sender: Any) {
      textField.text = prettyPrintAll(time: StringToTime(time: timeField.text!), event: Double(distanceField.text!)!)
        
    }
    
    func convert(time: Double, event : Double, event2 : Double) -> Double{
        var string = 0.0;
        string = time * pow(Double(event2/event), 1.06)
        
        return string
    }
    func StringToTime(time:String) -> Double {
        let arr = time.components(separatedBy: ":")
        var hrs = 0;
        var mins = 0
        var secs = 0
        if (arr.count == 3) {
             hrs = Int(arr[0])!;
             mins = Int(arr[1])!;
             secs = Int(arr[2])!;
        }else{
             mins = Int(arr[0])!;
             secs = Int(arr[1])!;
        }
        return convertTime(hours: hrs, mins: mins, secs: secs);
        
    }
    func convertTime(hours : Int, mins:Int, secs: Int ) -> Double{
        var totalTime = Double(secs);
        totalTime += Double((hours * 360) + (mins * 60));
        return Double(totalTime)
    }
    
    
    func convertTimeBack(tot : Double) -> String{
        var string = ""
        var tota = tot
        var secs = tota.truncatingRemainder(dividingBy: 60)
        tota -= secs;
        var mins = tota/60.0
        var hours = 0.0;
        var newmins = mins.truncatingRemainder(dividingBy: 60)
        if (mins > 60){
            mins -= newmins;
            hours = mins / 60.0
        }
        if(hours != 0){
            string = "\(Int(hours)):\(Int(mins)):\(Int(round(secs)))"
            
            
        }else{
            string = "\(Int(mins)):\(Int(round(secs)))"
        }
        return string
    }
    func prettyPrintAll(time : Double , event:Double) -> String {
        var endString = "Your Equivalents: \n"
        endString.append("800m: \(convertTimeBack(tot: convert(time: time, event: event, event2: 800.0)))\n")
        endString.append("1500m: \(convertTimeBack(tot: convert(time: time, event: event, event2: 1500.0)))\n")
        endString.append("Mile: \(convertTimeBack(tot: convert(time: time, event: event, event2: 1609.0)))\n")
        endString.append("3000m: \(convertTimeBack(tot: convert(time: time, event: event, event2: 3000.0)))\n")
        endString.append("5000m: \(convertTimeBack(tot: convert(time: time, event: event, event2: 5000.0)))\n")
        endString.append("10000m: \(convertTimeBack(tot: convert(time: time, event: event, event2: 10000.0)))\n")
        endString.append("Half Marathon: \(convertTimeBack(tot: convert(time: time, event: event, event2: 21000.0)))\n")
        endString.append("full thon: \(convertTimeBack(tot: convert(time: time, event: event, event2: 42000.0)))\n")
        return endString
    }
    @IBAction func X(_ sender: Any) {
        closeCalc();
    }
    
    func closeCalc(){
        timeCalc.isHidden = true;
    }

}





