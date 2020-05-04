//
//  SettingsVC.swift
//  Glass-Half-Full
//
//  Created by XCodeClub on 2020-05-04.
//  Copyright © 2020 Tyler Ciarmataro. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    @IBOutlet weak var targetText: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    let defaults = UserDefaults.standard
    var target:Int = 8 // the default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get target from storage and set textfield
        if defaults.integer(forKey: "target") != 0 {
            target = defaults.integer(forKey: "target")
        }
        
        targetText!.text = "\(target)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTarget(_ sender: Any) {
        // targettext will always have a value because it's set in viewDidLoad
        let targetNum = Int(targetText!.text!)
        defaults.set(targetNum, forKey:"target")
        
        messageLabel!.text = "Your target has been set to \(defaults.integer(forKey: "target")) cups a day! Get drinking!"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
