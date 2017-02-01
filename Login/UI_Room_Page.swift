//
//  UI_Room_Page.swift
//  Login
//
//  Created by Gaultier Moraillon on 16/05/2016.
//  Copyright © 2016 Gaultier Moraillon. All rights reserved.
//

import UIKit
import Foundation

var id = 0

class Room_Page: UIViewController {
    
    var username : UITextField!
    var password : UITextField!
    var number: Int = 1
    var string = ""
    var string2 = ""
    var string3 = ""
    var string4 = ""
    var stringDigit = ""
    var stringDigit2:Int = 0
    var arrayOfVillains = []
    var NameRoom: NSMutableArray = []
    var NameId: NSMutableArray = []
    var NameType: NSMutableArray = []
    var buttonY: CGFloat = 100  // our Starting Offset, could be 0
    
    
    override func viewDidLoad() {
    super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "fond.png")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Room_Page.refreshList(_:)), name:"refresh", object: nil)
        let myUrl = NSURL(string: "http://192.168.1.3:4567/rooms");
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
    
    func refreshList(notification: NSNotification){
        
        print("parent method is called")
    }
    
    func addToArray()
    {
        self.arrayOfVillains = self.string3.characters.split("}").map(String.init)
        dump(self.arrayOfVillains)
    }
    
    func DelFromString()
    {
        string2 = string.stringByReplacingOccurrencesOfString("[", withString: "")
        string3 = string2.stringByReplacingOccurrencesOfString("]", withString: "")
        string2 = string3.stringByReplacingOccurrencesOfString("{", withString: "")
        string3 = string2.stringByReplacingOccurrencesOfString("\"", withString: "")
        print(string3)
    }
    
    func printArray()
    {
        var i = 0
        //var j = 0
        let b = self.arrayOfVillains.count
        
        
        while (i < (b))
        {
            string4 += self.arrayOfVillains[i] as! String
        
            if (string4.characters.first == ",")
            {
                string4.removeAtIndex((string4.startIndex))
            }
            print(string4)
            
            stringDigit = string4.stringByReplacingOccurrencesOfString("[^0-9 ]", withString: "", options: NSStringCompareOptions.RegularExpressionSearch, range:nil);
            NameId.addObject(stringDigit)
            dump(NameId)
            
            for char in string4.characters
            {
                if (char == "n"){
                    break
                }
                else{
                    string4.removeAtIndex((string4.startIndex))
                }
            }
            print(string4)
            
            if let dotRange = string4.rangeOfString(",") {
                string4.removeRange(dotRange.startIndex..<string4.endIndex)
            }
            
            for char in string4.characters
            {
                if (char == ":"){
                    break
                }
                else{
                    string4.removeAtIndex((string4.startIndex))
                }
            }
            
            if (string4.characters.first == ":")
            {
                string4.removeAtIndex((string4.startIndex))
            }
            NameRoom.addObject(string4)
            dump(NameRoom)
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
            self.stringDigit2 = (self.NameId.objectAtIndex(id)).integerValue as Int
            vButton.tag = self.stringDigit2
            vButton.addTarget(self, action: #selector(Room_Page.villainButtonPressed(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.view.addSubview(vButton)
           id = id + 1
        }
        })
    }
    
    func villainButtonPressed(sender:UIButton!) {
        string = sender.titleLabel!.text!
        number = sender.tag
        print("ID:\(number)")
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
