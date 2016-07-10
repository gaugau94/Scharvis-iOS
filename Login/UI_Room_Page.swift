//
//  UI_Room_Page.swift
//  Login
//
//  Created by Gaultier Moraillon on 16/05/2016.
//  Copyright © 2016 Gaultier Moraillon. All rights reserved.
//

import UIKit
import Foundation

var id = 1

class Room_Page: UIViewController {
    
    var username : UITextField!
    var password : UITextField!
    var number: Int = 1
    var string = ""
    var string2 = ""
    var string3 = ""
    var string4 = ""
    var arrayOfVillains = []
    var NameRoom: NSMutableArray = []
    var buttonY: CGFloat = 100  // our Starting Offset, could be 0
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
        let myUrl = NSURL(string: "http://163.5.84.234:4567/rooms");
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
            print(self.string)
            self.DelFromString()
            self.addToArray()
            self.printArray()
            self.addStartingButtons()
        }
        task.resume()
    }
    
    func addToArray()
    {
        self.arrayOfVillains = self.string3.characters.split("\"").map(String.init)
    }
    
    func DelFromString()
    {
        string2 = string.stringByReplacingOccurrencesOfString("{", withString: "")
        string3 = string2.stringByReplacingOccurrencesOfString("}", withString: "")
        print(string3)
    }
    
    func printArray()
    {
        var i = 0
        let b = self.arrayOfVillains.count
        
        while (i < (b-1))
        {
            string4 += self.arrayOfVillains[i] as! String
            for char in string4.characters
            {
                if (char >= "A" && char <= "Z" ){
                    NameRoom.addObject(string4)
                    break
                }
                else{
                    string4.removeAtIndex((string4.startIndex))
                }
            }
            i = i + 1
            string4 = ""
        }
    }
    
    func addStartingButtons() {
        
        dispatch_async(dispatch_get_main_queue(), {
        for content in self.NameRoom {
            
            let vButton = UIButton(frame: CGRect(x: 50, y: self.buttonY, width: 250, height: 30))
            self.buttonY = self.buttonY + 50
            
            vButton.layer.cornerRadius = 10
            vButton.backgroundColor = UIColor.darkGrayColor()
            vButton.setTitle("\(content)", forState: UIControlState.Normal)
            vButton.tag = id
            vButton.addTarget(self, action: #selector(Room_Page.villainButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.view.addSubview(vButton)
           id = id + 1
        }
        })
    }
    
    func villainButtonPressed(sender:UIButton!) {
        string = sender.titleLabel!.text!
        number = sender.tag
        dispatch_async(dispatch_get_main_queue(), {
          self.performSegueWithIdentifier("Action_Page", sender: self)
        })
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Action_Page"{
            let DestinationController = segue.destinationViewController as? Action_Page
            DestinationController!.idsa = number
            DestinationController?.passwordS = password
            DestinationController?.usernameS = username
            DestinationController?.ROOM = string
            
            
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
