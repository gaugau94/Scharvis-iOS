//
//  ViewController.swift
//  Login
//
//  Created by Gaultier Moraillon on 21/04/2016.
//  Copyright © 2016 Gaultier Moraillon. All rights reserved.
//


import UIKit

class ViewController: UIViewController {

    var myUrl : NSURL = NSURL(string: "http://10.224.9.234:4567/login")!;
    
    @IBOutlet weak var txtusername: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Connect(sender: UIButton) {
        print(myUrl)
        
        let username:NSString = txtusername.text!
        let password:NSString = txtpassword.text!
        
       if (username.isEqualToString("") || password.isEqualToString("")){
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Please enter Username and Password"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }else{
        let request = NSMutableURLRequest(URL:myUrl);
        request.HTTPMethod = "POST";
        // Compose a query string
        let postString = "username=\(username)&password=\(password)";
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            // You can print out response object
            print("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            if (responseString == "true"){
               dispatch_async(dispatch_get_main_queue(), {
                self.performSegueWithIdentifier("segueIdentifier", sender: self)
                })
            }
            else{
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign in Failed!"
                alertView.message = "Please enter valid Username and Password"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
        task.resume()
        }
    }
    @IBOutlet weak var Home: UISwitch!
    @IBAction func IsHome(sender: AnyObject) {
        if Home.on {
            myUrl = NSURL(string: "http://10.224.9.234:4567/login")!;
        }
        else{
            myUrl = NSURL(string: "http://163.5.84.234:4567/login")!;
        }
        print(myUrl)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueIdentifier"{
           let DestinationController = segue.destinationViewController as? Room_Page
            DestinationController?.password = txtpassword
            DestinationController?.username = txtusername

            
        }
    }
}








































