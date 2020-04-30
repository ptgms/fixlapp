//
//  FirstViewController.swift
//  fixl
//
//  Created by ptgms on 27.04.20.
//  Copyright © 2020 ptgms. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numpadItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        cell.Text.text = self.numpadItems[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        switch indexPath.item {
        case 0:
            print("Keypad item 1 pressed")
        case 1:
            print("Keypad item 2 pressed")
        case 2:
            print("Keypad item 3 pressed")
        case 3:
            print("Keypad item 4 pressed")
        case 4:
            print("Keypad item 5 pressed")
        case 5:
            print("Keypad item 6 pressed")
        case 6:
            print("Keypad item 7 pressed")
        case 7:
            print("Keypad item 8 pressed")
        case 8:
            print("Keypad item 9 pressed")
        case 9:
            print("Keypad item Remove pressed")
        case 10:
            print("Keypad item 0 pressed")
        case 11:
            print("Keypad item Clear pressed")
        default:
            print("This is impossible, how?")
            exit(-1)
        }
    }
    
    let unsupported = ["iPhone4,1", "iPhone5,1", "iPhone5,2", "iPhone5,3", "iPhone5,4", "iPhone6,1", "iPhone6,2", "iPod7,1", "iPod9,1", "iPhone8,4"]
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var moneyLabel: UILabel!
    
    let reuseIdentifier = "cell"
    let numpadItems = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "CE", "0", "CA"]
    let defaults = UserDefaults.standard
    var country: String = ""
    var currency = "E"
    var acknow = false
    override func viewDidLoad() {
        super.viewDidLoad()
        country = defaults.string(forKey: "country") ?? ""
        let flagState = defaults.bool(forKey: "hideFlag")
        countryLabel.isHidden = flagState
        switch country {
        case "United Kingdom":
            countryLabel.text = "🇬🇧"
            currency = "£"
        case "USA":
            countryLabel.text = "🇺🇸"
            currency = "$"
        case "Poland":
            countryLabel.text = "🇵🇱"
            currency = "PLN"
        case "Germany":
            countryLabel.text = "🇩🇪"
            currency = "€"
        case "France":
            countryLabel.text = "🇫🇷"
            currency = "€"
        case "Netherlands":
            countryLabel.text = "🇳🇱"
            currency = "€"
        default:
            countryLabel.text = "ERROR"
        }
        NotificationCenter.default.addObserver(self, selector: #selector(showFlag), name: Notification.Name("showFlag"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideFlag), name: Notification.Name("hideFlag"), object: nil)
        let numberOfColumns: CGFloat = 3
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (collectionView.frame.width - max(0, numberOfColumns - 1)*horizontalSpacing)/numberOfColumns
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
        layoutCells()
        moneyLabel.text = "00.00 " + currency
    }

    override func viewDidAppear(_ animated: Bool) {
        let countrysel = defaults.string(forKey: "country") ?? ""
        if (countrysel == "") {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewSetUp")
            self.present(nextViewController, animated:false, completion:nil)
        } else {
            print("Country set to " + defaults.string(forKey: "country")!)
        }
        print(modelIdentifier())
        acknow = defaults.bool(forKey: "acknow")
        if (acknow==false) {
            if (unsupported.contains(modelIdentifier())) {
                print("Device incompatible! Displaying Warning...")
                let alert = UIAlertController(title: "warning".localized, message: "deviceIncomp".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok".localized, style: .default, handler: { action in
                    self.defaults.set(true, forKey: "acknow")
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.defaults.set(true, forKey: "acknow")
            }
        }
    }

    @objc func showFlag() {
        countryLabel.isHidden = false
    }
    
    @objc func hideFlag() {
        countryLabel.isHidden = true
    }
    
    func layoutCells() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 5.0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 40)/3, height: ((UIScreen.main.bounds.size.width - 40)/3))
        collectionView!.collectionViewLayout = layout
    }

    func modelIdentifier() -> String {
        if let simulatorModelIdentifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] { return simulatorModelIdentifier }
        var sysinfo = utsname()
        uname(&sysinfo) // ignore return value
        return String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
    }
    
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
