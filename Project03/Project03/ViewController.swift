//
//  ViewController.swift
//  Project03
//
//  Created by YenShao on 2017/5/15.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    lazy var session = { return URLSession(configuration: .default) }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    @IBAction func getBtn(_ sender: UIButton)
    {
        let apiAddress = "https://httpbin.org/get"
        if let url = URL(string: apiAddress)
        {
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil
                {
                    print(error?.localizedDescription as Any)
                }
                if let downloadedData = data
                {
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: downloadedData, options: [])
                        
                        DispatchQueue.main.async {
                            self.parseJSON(json: json)
                        }
                    }
                    catch
                    {
                        print("Error")
                    }
                }
            })
            task.resume()
        }
    }
    
    func parseJSON(json:Any)
    {
        if let okJSON = json as? [String:Any]
        {
            print("origin = \(okJSON["origin"] ?? "Error")")
        }
    }
    
    
    
    
    
    @IBAction func postBtn(_ sender: UIButton)
    {
        if let url = URL(string: "https://httpbin.org/post")
        {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            
            let params = ["time":dateString]
            
            do
            {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            }
            catch
            {
                print(error.localizedDescription)
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if error != nil
                {
                    print(error!.localizedDescription)
                }
                
                let spendTime = Calendar(identifier: .gregorian).dateComponents([.nanosecond], from: date, to: Date())
                print("花費時間 = 0.\(spendTime.nanosecond! / 10000000)秒")
                
            })
            task.resume()
        }
    
    }

}





