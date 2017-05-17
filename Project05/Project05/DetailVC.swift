//
//  DetailVC.swift
//  Project05
//
//  Created by YenShao on 2017/5/16.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit
import Social

class DetailVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var myImage:UIImage?
    var myText:String?
    
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 333, height: 360))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: detailScrollView.frame.width, height: detailScrollView.frame.height))
    
        if let image = myImage
        {
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            self.detailScrollView.addSubview(imageView)
        }
        
        if let text = myText
        {
            detailLabel.text = text
        }
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    

    
    @IBAction func shareBtn(_ sender: UIBarButtonItem)
    {
        guard let shareImage = myImage, let shareText = myText else { return }
        
        let activityController = UIActivityViewController(activityItems: [shareText, shareImage], applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
