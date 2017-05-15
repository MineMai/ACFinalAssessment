//
//  ViewController.swift
//  Project01
//
//  Created by YenShao on 2017/5/15.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var totalLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var sum = 0
        
        for i in 1...100
        {
            if i % 2 != 0
            {
                sum += i
            }
        }
        
        totalLabel.text = String(sum)
        
        
    }

    


}

