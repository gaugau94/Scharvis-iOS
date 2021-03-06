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
       // let request = NSMutableURLRequest(URL:myUrl);
       // request.HTTPMethod = "POST";
        // Compose a query string
        //let postString = "username:\(username)&password:\(password)";
        //request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        /*let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
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
        task.resume()*/

        do {
            var stringPost = "{"
            stringPost += "\""
            stringPost += "username"
            stringPost += "\""
            stringPost += ":"
            stringPost += "\""
            stringPost += "\(username)"
            stringPost += "\""
            stringPost += ","
            stringPost += "\""
            stringPost += "password"
            stringPost += "\""
            stringPost += ":"
            stringPost += "\""
            stringPost += "\(password)"
            stringPost += "\""
            stringPost += "}"
            
            NSLog("PostData: %@",stringPost);
            
            //let url:NSURL = NSURL(string:"http://10.224.9.234:4567/login")!
             let url:NSURL = NSURL(string:"http://192.168.1.219:4567/login")!
            
            let postData:NSData = stringPost.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String( postData.length)
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
                
                urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
                
            } catch let error as NSError {
                reponseError = error
                print(reponseError)
                urlData = nil
            }
            
            if ( urlData != nil ) {
            
                let res = response as! NSHTTPURLResponse!;
                print(res)
                NSLog("Response code: %ld", res.statusCode);
                
                if (res.statusCode >= 200 && res.statusCode < 300)
                {
                    let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
                    
                    NSLog("Response ==> %@", responseData);
                    
                    //var error: NSError?
                    if (responseData != "fail")
                    {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.performSegueWithIdentifier("segueIdentifier", sender: self)
                        })
                    }
                    else
                    {
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Sign in Failed!"
                        alertView.message = "Please enter valid Username and Password"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    }
                }
            }
        }
        }
    }
    @IBOutlet weak var Home: UISwitch!
   /* @IBAction func IsHome(sender: AnyObject) {
        if Home.on {
            myUrl = NSURL(string: "http://10.224.9.234:4567/login")!;
        }
        else{
            myUrl = NSURL(string: "http://163.5.84.234:4567/login")!;
        }
        print(myUrl)
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueIdentifier"{
           let DestinationController = segue.destinationViewController as? Room_Page
            DestinationController?.password = txtpassword
            DestinationController?.username = txtusername

            
        }
    }
}








































