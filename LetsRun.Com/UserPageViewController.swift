//
//  UserPageViewController.swift
//  LetsRun.Com
//
//  Created by Max Norman on 7/12/17.
//  Copyright © 2017 Max Norman. All rights reserved.
//

import UIKit

class UserPageViewController: UIViewController {

       @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var UserNameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let  ViewController = getInstanceofSecond();
        
        ViewController.loadData();
        //SHOULD set the stuff to the username that is saved 
        UserNameLabel.text = ViewController.user.userName
        UserNameField.text = ViewController.user.userName
        // Do any additional setup after loading the view.
        
      
    }
    
    func saveData(user : userAccount) {
        let  ViewController = getInstanceofSecond();
        NSKeyedArchiver.archiveRootObject(user, toFile: ViewController.filePath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  
    
    
    
    @IBOutlet weak var Sig: UITextField!
    
    @IBOutlet weak var UserPassword: UITextField!
    
    
    @IBAction func Save(_ sender: Any) {
        let ViewController = getInstanceofSecond();
        ViewController.user.userName = UserNameField.text;
        //sets the overall class data type "user" as the text in the box
        UserNameLabel.text = ViewController.user.userName;
        saveData(user: ViewController.user)
        UserNameField.resignFirstResponder()
        Sig.text = ViewController.user._signature
        ViewController.user.passWord = UserPassword.text;
        ViewController.saveData(user: ViewController.user)
        saveData(user: ViewController.user)
        UserPassword.resignFirstResponder()
        Sig.resignFirstResponder()
    }
    
    
    func getInstanceofSecond() -> ViewController {
        //A Helper Function which returns the instance of the "Second" View controller
        let ViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        return ViewController;
        
    }
    @IBAction func OpenList(_ sender: Any) {
        let ViewController = getInstanceofSecond();
        //ViewController.OpenFavorite(true);
    }
    

}
