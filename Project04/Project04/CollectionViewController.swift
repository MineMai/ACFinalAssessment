//
//  CollectionViewController.swift
//  Project04
//
//  Created by YenShao on 2017/5/15.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation
import CoreMotion

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate, CLLocationManagerDelegate {
    
    var pressed = false
    
    let locationManager = CLLocationManager()  //定位用的
    var myLocation:CLLocationCoordinate2D?     //把位置給導航用的變數
    
    var pedometer:CMPedometer! //計步用的
    var countStep:NSNumber!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //定位設定
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation() //開始執行
    }

    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        cell.numberLabel.text = String(indexPath.row + 1)
        
        if indexPath.row == 1
        {
            cell.numberLabel.text = "Red or Blue"
            if pressed
            {
                cell.backgroundColor = UIColor.red
            }
            else
            {
                cell.backgroundColor = UIColor.blue
            }
            
        }
        else if indexPath.row == 0
        {
            cell.backgroundColor = UIColor.magenta
            cell.numberLabel.text = "Alert"
        }
        else if indexPath.row == 2
        {
            cell.backgroundColor = UIColor.brown
            if let step = countStep
            {
                cell.numberLabel.text = "\(String(describing: step))步"
            }
            else
            {
                cell.numberLabel.text = "0步"
            }
        }
        else if indexPath.row == 3
        {
            cell.backgroundColor = UIColor.cyan
            cell.numberLabel.text = "Setting"
        }
        else if indexPath.row == 4
        {
            cell.backgroundColor = UIColor.green
            cell.numberLabel.text = "Map"
        }
        else
        {
            cell.numberLabel.text = "Mail"
            cell.backgroundColor = randomColor()
        }
        
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        switch indexPath.row {
        case 0:
            showAlert()
        case 1:
            if pressed
            {
                pressed = false
                collectionView.reloadData()
            }
            else
            {
                pressed = true
                collectionView.reloadData()
            }
        case 2:
            print("xxx")
            pedometer = CMPedometer() //產生計步器
            if CMPedometer.isStepCountingAvailable()
            {
                pedometer.startUpdates(from: Date(), withHandler: { (data, error) in
                    
                    print("Step = \(String(describing: data!.numberOfSteps))")
                    DispatchQueue.main.async {
                        
                        self.countStep = data!.numberOfSteps
                        collectionView.reloadData()
                    }
                })
            }
        case 3:
            UIApplication.shared.open(URL(string:"App-Prefs:root=General")!, options: [:], completionHandler: nil)
            
        case 4:
            let lat = myLocation?.latitude
            let long = myLocation?.longitude
            
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                print("lat = \(lat!)")
                print("long = \(long!)")
                UIApplication.shared.open(URL(string:"comgooglemaps://?saddr=\(lat!),\(long!)&daddr=25.052551,121.532302&directionsmode=transit")!, options: [:], completionHandler: nil)
            } else {
                print("Can't use comgooglemaps://");
            }
        default:
            let mailComposeViewController = configureMail()
            if MFMailComposeViewController.canSendMail()
            {
                present(mailComposeViewController, animated: true, completion: nil)
            }
            else
            {
                showSendMailErrorAlert()
            }
        }
        

    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentLocation = locations.last else
        {
            print("CurrentLocation is nil")
            return
        }
        myLocation = currentLocation.coordinate
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 2, height: view.frame.height / 3)
    }
    
    
    func randomColor() -> UIColor
    {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: "I'm Alert", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - Mail設定
    func configureMail() -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["yenshao.c@gmail.com"])
        mailComposerVC.setSubject("測試信件")
        mailComposerVC.setMessageBody("test...\n", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert()
    {
        let sendMailErrorAlert = UIAlertController(title: "無法送出", message: "請檢查您的裝置，再試一次", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(ok)
        present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case MFMailComposeResult.cancelled:
            print("Cancelled mail")
        case MFMailComposeResult.sent:
            print("Mail Sent")
        case MFMailComposeResult.saved:
            print("Mail saved")
        default:
            print("失敗")
            break
        }
        dismiss(animated: true, completion: nil)
    }
    
    

}












