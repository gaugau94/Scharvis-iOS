//
//  Action_Page.swift
//  Login
//
//  Created by Gaultier Moraillon on 29/06/2016.
//  Copyright © 2016 Gaultier Moraillon. All rights reserved.
//

import UIKit


class Action_Page: UIViewController {
    var ROOM = ""
    var idsa = 0
    var usernameS : UITextField!
    var passwordS : UITextField!
    var string = ""
    var string2 = ""
    var string3 = ""
    var string4 = ""
    var string5 = ""
    var string6 = ""
    var idStatus = 0
    var Array = []
    var x : CGFloat = 30
    var y : CGFloat = 80

    override func viewDidLoad() {
        super.viewDidLoad()

        getItems()
        
    }
    
    func addToArray()
    {
         string5 = string.stringByReplacingOccurrencesOfString(",", withString: "")
         self.Array = self.string5.characters.split(";").map(String.init)
         dump(Array)
    }
    
    func getItems()
    {
        let myUrl = NSURL(string : "http://163.5.84.234:4567/room?id=\(idsa)")
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "GET";
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            print("API Responce \(response)")
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.string = responseString as! String
            print("Piece contient \(self.string)")
            dispatch_async(dispatch_get_main_queue(), {
            self.addToArray()
            self.goToStatus()
            })
        }
        task.resume()
    }
    
    func goToStatus()
    {
        var i = 0
        
        while (i < self.Array.count)
        {
            string3 += self.Array[i] as! String
            print(string3)
            for char in string3.characters
            {
                if (char >= "1" && char <= "9")
                {
                    string4 += String(char)
                }
                else if ((char >= "A" && char <= "Z") || (char >= "a" && char <= "z"))
                {
                    string6 += String(char)
                    //print(string6)
                }
                
            }
            sleep(1)
            idStatus = Int(string4)!
            print(idStatus)
            print(string6)
            self.getStatus(self.string6, idStatus: self.idStatus)
            //createLabel(string6)
            self.string3 = ""
            self.string4 = ""
            self.string6 = ""
            i = i + 1
        }
    }
    
    func createLabel(string6: String)
    {
        print(string6)
        let label: UILabel = UILabel()
        label.frame = CGRectMake(x, y, 200, 21)
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = string6
        self.view.addSubview(label)
    }
    
    func createSwitch(string2: String)
    {
        
        
        let switchDemo = UISwitch(frame:CGRectMake(200, y, 0, 0));
        if (string2 == "0" || string2 == "00")
        {
        switchDemo.on = true
        }
        else {
            switchDemo.on = false
        }
        switchDemo.addTarget(self, action: #selector(Action_Page.switchValueDidChange(_:)), forControlEvents: .ValueChanged);
        switchDemo.tag = idStatus
        self.view.addSubview(switchDemo);
    }
    
    func switchValueDidChange(sender:UISwitch!)
    {
            let user = "0658092965"
        print(user)
        let idaction = sender.tag
        
        if (sender.on == true){
            print("on")
            print(sender.tag)
            let myUrl1 = NSURL(string : "http://163.5.84.234:4567/action?action=0&id=\(idaction)&username=\(user)")
            print(myUrl1)
            let request = NSMutableURLRequest(URL:myUrl1!);
            request.HTTPMethod = "POST";
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            {
                data, response, error in
                
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
                print("API Responce \(response)")
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                self.string2 = responseString as! String
            }
            task.resume()

        }
        else{
            print("off")
            print(sender.tag)
            let myUrl = NSURL(string : "http://163.5.84.234:4567/action?action=1&id=\(idaction)&username=\(user)")
            print(user)
            print(myUrl)
            let request = NSMutableURLRequest(URL:myUrl!);
            request.HTTPMethod = "POST";
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
            {
                data, response, error in
                
                if error != nil
                {
                    print("error=\(error)")
                    return
                }
                print("API Responce \(response)")
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                self.string2 = responseString as! String
            }
            task.resume()
        }
    }

    func getStatus(string6: String, idStatus: Int)
    {
        let myUrl = NSURL(string : "http://163.5.84.234:4567/status?id=\(idStatus)")
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "GET";
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            print("API Responce \(response)")
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            self.string2 = responseString as! String
            print("Piece status \(self.string2)")
            print("Piece ID \(self.idStatus)")
            dispatch_async(dispatch_get_main_queue(), {
                print("Piece IDDDDDDDDD \(self.idStatus)")
            self.createLabel(string6)
            self.createSwitch(self.string2)
            self.y = self.y + 50
            })
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender: UIButton!) {
    }

}
