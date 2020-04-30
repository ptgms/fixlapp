//
//  SecondViewController.swift
//  fixl
//
//  Created by ptgms on 27.04.20.
//  Copyright © 2020 ptgms. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    let defaults = UserDefaults.standard
    var flagState = false
    
    @IBOutlet weak var flagSwitch: UISwitch!
    @IBOutlet weak var compatLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    let unsupported = ["iPhone4,1", "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2", "iPod7,1", "iPod9,1", "iPhone8,4"]
    let version: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"]! as! String
    let build: String = Bundle.main.infoDictionary!["CFBundleVersion"]! as! String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        flagState = defaults.bool(forKey: "hideFlag")
        flagSwitch.isOn = flagState
        if (unsupported.contains(modelIdentifier())) {
            compatLabel.textColor = UIColor.red
            compatLabel.text = "device".localized + modelIdentifier() + "deviceuns".localized
        } else {
            compatLabel.text = "device".localized + modelIdentifier()
        }
        versionLabel.text = "version".localized + version + "build".localized + build
    }
    @IBAction func resetPressed(_ sender: Any) {
        let alert = UIAlertController(title: "warning".localized, message: "reset1".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: { action in
            print("Resetting")
            self.defaults.setValue("", forKey: "country")
            self.defaults.set(false, forKey: "acknow")
            exit(0)
        }))
        alert.addAction(UIAlertAction(title: "cancel".localized, style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)

    }
    
    @IBAction func flagSwitchPressed(_ sender: Any) {
        if (flagState==true) {
            flagState = false
            defaults.set(false, forKey: "hideFlag")
            NotificationCenter.default.post(name: Notification.Name("showFlag"), object: nil)
        } else {
            flagState = true
            defaults.set(true, forKey: "hideFlag")
            NotificationCenter.default.post(name: Notification.Name("hideFlag"), object: nil)
        }
    }
    
    func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
}



