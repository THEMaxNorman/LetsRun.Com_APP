//
//  userAccount.swift
//  LetsRun.Com
//
//  Created by Max Norman on 8/5/17.
//  Copyright © 2017 Max Norman. All rights reserved.
//

import Foundation

class userAccount: NSObject, NSCoding {
    //a class for a user
    //These are used for "AutoFilling" user when posting on boards.
    struct Keys {
        static let username = "username"
        static let password = "password"
        static let favlinks = "favlinks"
        static let signature = "signature"
    }
    override init() {}
    
    var userName : String?
    
    var passWord : String?
    
    var _signature : String = "Posted with LRC App"
    
    var favoriteLinks : [String : String] = [:];
    required init(coder decoder: NSCoder) {
        if let nameObject = decoder.decodeObject(forKey: Keys.username) as? String{
            userName = nameObject;
        }
        
        if let passObject = decoder.decodeObject(forKey: Keys.password) as? String{
            passWord = passObject;
        }
        
        if let linkObject = decoder.decodeObject(forKey: Keys.favlinks) as? [String : String]{
            favoriteLinks = linkObject;
        }
        
        if let sigObject = decoder.decodeObject(forKey: Keys.signature) as? String{
            _signature = sigObject;
        }
        
        
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(userName, forKey: Keys.username)
        coder.encode(passWord, forKey: Keys.password)
        coder.encode(favoriteLinks, forKey: Keys.favlinks)
        coder.encode(_signature, forKey: Keys.signature)
    }
    //list of favorite Links
    func addFavLink(Link : String, Name:String)  {
        //adds the link to the list
        favoriteLinks[Link] =  Name;
    }
    func updateList(str : String){
        let tot = str.components(separatedBy: ",")
        for String in tot{
            for (link, Name) in favoriteLinks {
                if(String.contains(link)){
                    favoriteLinks.removeValue(forKey: link)
                }
            }
        }
    }
    
    func htmlFavs() -> String {
        //returns a string with every favorite thread in links
        /*this is incredibly messy but very cool
         puts links into HTML and then uses UIWebview to display it
         gives it a very native look
         */
        if(favoriteLinks.count > 0){
            var text : String = "<style> body{background-color : #fffece; } div.transbox { margin: 0px; background-color: #cccccc; border: 1px solid white; opacity: 1; filter: alpha(opacity=60); /* For IE8 and earlier */} div.transbox2 { margin: 0px; background-color: #fffece; border: 1px solid white; opacity: 1; filter: alpha(opacity=60); /* For IE8 and earlier */ } div.transbox p { font-family: \("Helvetica Neue"), Helvetica, Arial, sans-serif; font-size: 14px; color: #000000;} div.transbox2 p { font-family: \("Helvetica Neue"), Helvetica, Arial, sans-serif;font-size: 14px;color: #000000;} </style> <body><script>function myFunction(elmnt) {elmnt.parentNode.remove(elmnt);document.title = document.title + elmnt.parentNode.innerHTML +',';}</script>";
        
            var c = 0;
            // the counter is used to alternate it
            for (link,  Name) in favoriteLinks {
                c += 1;
                print(link);
                print(Name)
                if(c % 2 == 0){
                    text.append("<div class = \("transbox")> <p><a href = \(link)> \(Name)</a><button onclick='myFunction(this)'>X</button></p></div>" )
                }else{
                    text.append("<div class = \("transbox2")> <p><a href = \(link)> \(Name)</a><button onclick='myFunction(this)'>X</button></p></div>" )
                }
            
            
            }
            text.append("</body>")
            print(text);
            return text;
        }else{
            return "<style> body{background-color: #FFFECE} p{text-align:center}</style><body><p> Aww nuts</p> <p>No watched threads! </p> <p><a href = 'http://www.letsrun.com/'> Return to Home Page</a></p> <p><img src= http://68.media.tumblr.com/face58fc0b5baf7c9b824c8dcb185355/tumblr_o4z7jyMq0d1utvn4oo2_500.jpg width= 500  height= 750></p></body>"        }
    }
}
