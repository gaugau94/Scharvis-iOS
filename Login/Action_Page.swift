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
    var stringDigit = ""
    var stringDigit2:Int = 0
    var Array = []
    var NameId: NSMutableArray = []
    var NameStatus: NSMutableArray = []
    var NameType: NSMutableArray = []
    var x : CGFloat = 30
    var y : CGFloat = 80

    override func viewDidLoad() {
        super.viewDidLoad()

        getItems()
        
    }
    
    func addToArray()
    {
         string5 = string.stringByReplacingOccurrencesOfString("[", withString: "")
         string = string5.stringByReplacingOccurrencesOfString("]", withString: "")
         string5 = string.stringByReplacingOccurrencesOfString("\"", withString: "")
        string = string5.stringByReplacingOccurrencesOfString("{", withString: "")
       // string5 = string.stringByReplacingOccurrencesOfString("{", withString: "")
         self.Array = self.string.characters.split("}").map(String.init)
         dump(Array)
        string = ""
    }
    
    func getItems()
    {
        let myUrl = NSURL(string : "http://10.224.9.234:4567/room?id=\(idsa)")
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
            self.showTab()
            self.createLabel()
            self.createSwitch()
            })
        }
        task.resume()
    }
    
    func showTab()
    {
        print("Type")
        dump(NameType)
        print("Status")
        dump(NameStatus)
        print("Id")
        dump(NameId)
    }
    
    func goToStatus()
    {
        var i = 0
        
        let b = self.Array.count
        
        while(i < b)
        {
            string += self.Array[i] as! String
            
            if (string.characters.first == ",")
            {
                string.removeAtIndex((string.startIndex))
            }
            print(string)
            
            stringDigit = string.stringByReplacingOccurrencesOfString("[^0-9 ]", withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range:nil);
            NameId.addObject(stringDigit)
            //dump(NameId)
            string2 = string
            for char in string.characters
            {
                if (char == "s")
                {
                    break
                }
                else{
                    string.removeAtIndex((string.startIndex))
                }
            }
            for char in string.characters
            {
                if (char == ":"){
                    break
                }
                else{
                    string.removeAtIndex((string.startIndex))
                }
            }
            
            if (string.characters.first == ":")
            {
                string.removeAtIndex((string.startIndex))
            }
            NameStatus.addObject(string)
            //dump(NameStatus)
            for char in string2.characters
            {
                if (char == "t"){
                    break
                }
                else{
                    string2.removeAtIndex((string2.startIndex))
                }
            }
            print(string2)
            
            if let dotRange = string2.rangeOfString(",") {
                string2.removeRange(dotRange.startIndex..<string2.endIndex)
            }
            
            for char in string2.characters
            {
                if (char == ":"){
                    break
                }
                else{
                    string2.removeAtIndex((string2.startIndex))
                }
            }
            
            if (string2.characters.first == ":")
            {
                string2.removeAtIndex((string2.startIndex))
            }
            NameType.addObject(string2)
            //dump(NameType)
            print(string)
            
            i = i + 1
            string = ""
            string2 = ""
        }
        
        
    }
    
    func createLabel()
    {
        var i = y
        for content in self.NameType {
        let label: UILabel = UILabel()
        label.frame = CGRectMake(x, i, 200, 21)
        label.textColor = UIColor.blackColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = content as? String
        self.view.addSubview(label)
        i = i + 50
        }
        
      
    }
    
    func createSwitch()
    {
        var i = y
        var j = 0
        for content in NameStatus{
        let switchDemo = UISwitch(frame:CGRectMake(200, i, 0, 0));
        if (content as! String == "True")
        {
        switchDemo.on = true
        }
        else {
            switchDemo.on = false
        }
        switchDemo.addTarget(self, action: #selector(Action_Page.switchValueDidChange(_:)), forControlEvents: .ValueChanged);
        self.stringDigit2 = (self.NameId.objectAtIndex(j)).integerValue as Int
        switchDemo.tag = stringDigit2
        switchDemo.accessibilityIdentifier = self.NameType.objectAtIndex(j) as? String
        self.view.addSubview(switchDemo);
        i = i + 50
        j = j + 1
        }
    }
    
    func switchValueDidChange(sender:UISwitch!)
    {
        print(sender.tag)
        print(sender.accessibilityIdentifier)
        let user = "0658092965"
        print(user)
        //let idaction = sender.tag
        
        if (sender.on == true){
            print("on")
            print(sender.tag)
            let myUrl1 = NSURL(string : "http://163.5.84.234:4567/action")
            print(myUrl1)
            var stringPost = "{"
            stringPost += "\""
            stringPost += "user"
            stringPost += "\""
            stringPost += ":"
            stringPost += "\""
            stringPost += "\(user)"
            stringPost += "\""
            stringPost += ","
            stringPost += "\""
            stringPost += "id"
            stringPost += "\""
            stringPost += ":"
            //stringPost += "\""
            stringPost += String(sender.tag)
            //stringPost += "\""
            stringPost += ","
            stringPost += "\""
            stringPost += "action"
            stringPost += "\""
            stringPost += ":"
            stringPost += "\""
            stringPost += "on"
            stringPost += "\""
            stringPost += ","
            stringPost += "\""
            stringPost += "type"
            stringPost += "\""
            stringPost += ":"
            stringPost += "\""
            stringPost += sender.accessibilityIdentifier!
            stringPost += "\""
            stringPost += "}"
         
            NSLog("PostData: %@",stringPost);
            
            let url:NSURL = NSURL(string:"http://10.224.9.234:4567/action")!
            
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
                }
            }


        }
        else{
            print("off")
            print(sender.tag)
            let myUrl1 = NSURL(string : "http://163.5.84.234:4567/action")
            print(myUrl1)
            var stringPost = "{"
            stringPost += "\""
            stringPost += "user"
            stringPost += "\""
            stringPost += ":"
            stringPost += "\""
            stringPost += "\(user)"
            stringPost += "\""
            stringPost += ","
            stringPost += "\""
            stringPost += "id"
            stringPost += "\""
            stringPost += ":"
            //stringPost += "\""
            stringPost += String(sender.tag)
            //stringPost += "\""
            stringPost += ","
            stringPost += "\""
            stringPost += "action"
            stringPost += "\""
            stringPost += ":"
            stringPost += "\""
            stringPost += "off"
            stringPost += "\""
            stringPost += ","
            stringPost += "\""
            stringPost += "type"
            stringPost += "\""
            stringPost += ":"
            stringPost += "\""
            stringPost += sender.accessibilityIdentifier!
            stringPost += "\""
            stringPost += "}"
            
          
            NSLog("PostData: %@",stringPost);
            
            let url:NSURL = NSURL(string:"http://10.224.9.234:4567/action")!
            
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
                }
            }

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
            //self.createLabel(string6)
            //self.createSwitch(self.string2)
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
