//
//  UserInfo.swift
//  Login
//
//  Created by Gaultier Moraillon on 16/05/2016.
//  Copyright © 2016 Gaultier Moraillon. All rights reserved.
//

import Foundation
import UIKit

class User: UIViewController {
    
    class var sharedInstance: User {
        struct Static {
            static var instance: User?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = User()
        }
        
        return Static.instance!
    }
    
    @IBOutlet weak var txtusername: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    
}
