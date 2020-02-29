//
//  ViewController.swift
//  NetworkStatus
//
//  Created by Sambit Das on 21/02/20.
//  Copyright © 2020 Sambit Das. All rights reserved.
//

import UIKit
import  UserNotifications
import SystemConfiguration

class ViewController: UIViewController {
    
 let reachablity = Reachability()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(internetChanged(note:)), name: Notification.Name.reachabilityChanged, object: reachablity)
        
        do{
            try reachablity.startNotifier()
            
        }catch{
            print(error.localizedDescription)
            print("catch error")
        }
        
        }
    
    
    @objc func internetChanged(note : Notification){
        _ = note.object as! Reachability
        if reachablity.isReachable{
            if reachablity.isReachableViaWiFi{
                DispatchQueue.main.async {
                    print("Wifi")
                   self.notification()
                 }
            }else{
               DispatchQueue.main.async {
                    print("Celular")
               self.notification()
                }
            }
            
        }else{
            DispatchQueue.main.async {
                print("not connect")
                    self.notification()
            }
        }
    }

    func notification(){
       let content = UNMutableNotificationContent()
        content.title = "Alert Message"
        content.body = " You Network status has changed"
        content.sound = UNNotificationSound.default
         
        let triger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testIndentifier", content: content, trigger: triger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}

