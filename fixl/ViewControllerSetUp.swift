//
//  ViewControllerSetUp.swift
//  fixl
//
//  Created by ptgms on 27.04.20.
//  Copyright © 2020 ptgms. All rights reserved.
//

import UIKit
import SAConfettiView

class ViewControllerSetUp: UIViewController {

    private let pickerData = ["Select a country", "United Kingdom", "USA", "Poland", "Germany", "France", "Netherlands"]
    private let pickerDataDE = ["Wähle ein Land", "Vereinigtes Königreich", "USA", "Polen", "Deutschland", "Frankreich", "Niederlanden"]
    
    let langStr = Locale.current.languageCode!
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeDesc: UILabel!
    @IBOutlet weak var contButton: UIButton!
    @IBOutlet weak var countryPls: UILabel!
    @IBOutlet weak var pickerBox: UIPickerView!
    @IBOutlet var swipeGest: UISwipeGestureRecognizer!
    
    var selected: String = ""
    var selected2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contButton.addTarget(self, action: #selector(continuePressed), for: .touchUpInside)
        config()
        self.pickerBox.delegate = self
        self.pickerBox.dataSource = self
        contButton.semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "MM-dd"
        let formattedDate = format.string(from: date)
        
        // its my birthday lets add confetti to the courtesy of https://github.com/sudeepag/SAConfettiView
        if (formattedDate=="09-04") {
            let confettiView = SAConfettiView(frame: self.view.bounds)
            self.view.insertSubview(confettiView, belowSubview: self.view)
            confettiView.isUserInteractionEnabled = false
            confettiView.type = .Triangle
            confettiView.startConfetti()
        }
    }
    @IBAction func swiped(_ sender: UISwipeGestureRecognizer) {
        print("Swiped!")
        if (selected=="") {
            print("Invalid state, staying here.")
        } else {
            defaults.set(selected2, forKey: "country")
            defaults.set(false, forKey: "hideFlag")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FirstViewController")
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        introAnim()
    }
    
    func config() {
        self.contButton.alpha = 0
        self.contButton.isHidden = true
        self.pickerBox.alpha = 0
        self.welcomeDesc.alpha = 0
        self.welcomeLabel.alpha = 0
        self.countryPls.alpha = 0
        swipeGest.isEnabled = false
    }
    
    func fadein() {
        
    }
    
    func introAnim() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.welcomeLabel.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseIn, animations: {
            self.welcomeDesc.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 3, options: .curveEaseIn, animations: {
            self.countryPls.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 4.5, options: .curveEaseIn, animations: {
            self.pickerBox.alpha = 1.0
        }, completion: nil)
    }
    
     @objc func continuePressed() {
        print("Continue Called!")
        if (selected=="") {
            print("Invalid state, staying here.")
        } else {
            defaults.set(selected2, forKey: "country")
            defaults.set(false, forKey: "hideFlag")
        }
    }
}

extension ViewControllerSetUp: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (langStr=="de") {
            return pickerDataDE.count
        } else {
            return pickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (langStr=="de") {
            selected = pickerDataDE[row]
            selected2 = pickerData[row]
        } else {
            selected = pickerData[row]
            selected2 = pickerData[row]
        }
        if (langStr=="de") {
            if (selected=="Wähle ein Land") {
                swipeGest.isEnabled = false
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.contButton.alpha = 0
                }, completion: { (true) in
                    self.contButton.isHidden = true
                })
            } else if (selected=="") {
                swipeGest.isEnabled = false
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.contButton.alpha = 0
                }, completion: { (true) in
                    self.contButton.isHidden = true
                })
            } else {
                swipeGest.isEnabled = true
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.contButton.isHidden = false
                    self.contButton.alpha = 1.0
                }, completion: nil)
            }
        } else {
            if (selected=="Select a country") {
                swipeGest.isEnabled = false
                selected = ""
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.contButton.alpha = 0
                }, completion: { (true) in
                    self.contButton.isHidden = true
                })
            } else if (selected=="") {
                swipeGest.isEnabled = false
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.contButton.alpha = 0
                }, completion: { (true) in
                    self.contButton.isHidden = true
                })
            } else {
                swipeGest.isEnabled = true
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.contButton.isHidden = false
                    self.contButton.alpha = 1.0
                }, completion: nil)
            }
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (langStr=="de") {
            return pickerDataDE[row]
        } else {
            return pickerData[row]
        }
    }
}
