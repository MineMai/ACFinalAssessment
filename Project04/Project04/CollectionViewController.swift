//
//  CollectionViewController.swift
//  Project04
//
//  Created by YenShao on 2017/5/15.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import MessageUI

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {
    
    var pressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
            if pressed
            {
                cell.backgroundColor = UIColor.red
            }
            else
            {
                cell.backgroundColor = UIColor.blue
            }
            
        }
        else
        {
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
        case 3:
            UIApplication.shared.open(URL(string:"App-Prefs:root=General")!, options: [:], completionHandler: nil)
            
        case 4:
            print("xxx")
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












