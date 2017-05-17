//
//  TableViewController.swift
//  Project05
//
//  Created by YenShao on 2017/5/16.
//  Copyright © 2017年 YenShao. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UserInputMsg {
    
    var takeImage:UIImage?
    var tableListImage = [UIImage]()
    var tableListText = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
    }
    
    
    func loadData()
    {
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDel?.persistentContainer.viewContext else {return}
        do
        {
            let results = try context.fetch(UserData.fetchRequest())
            for item in results
            {
                let theData = item as? UserData
                print(theData?.userText ?? "")
                tableListText.append(theData?.userText ?? "")
                let userImage = theData?.value(forKey: "userImage") as! Data
                let image = UIImage(data: userImage)
                if let img = image
                {
                    tableListImage.append(img)
                }
                
            }
        }
        catch
        {
            
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }

    func showMsg(image: UIImage, text: String) {
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDel?.persistentContainer.viewContext else {return}
        let aUserData = UserData(context: context)
        
        aUserData.userText = text
        
        let img = UIImagePNGRepresentation(image)! as NSData
        aUserData.userImage = img
        appDel?.saveContext()
        
        
        tableListImage.append(image)
        tableListText.append(text)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableListImage.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        cell.messageLabel.text = tableListText[indexPath.row]
        cell.photo.image = tableListImage[indexPath.row]

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detailSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addBtn(_ sender: UIBarButtonItem)
    {
        let imagePickVC = UIImagePickerController()
        imagePickVC.sourceType = .camera
        imagePickVC.delegate = self
        self.show(imagePickVC, sender: self)
        
        
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        takeImage = image
        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "CameraSegue", sender: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CameraSegue"
        {
            let vc = segue.destination as! CameraVC
            vc.takePhoto = takeImage
            vc.userInputMsgDelegate = self
        }
        if segue.identifier == "detailSegue"
        {
            let vc = segue.destination as! DetailVC
            let index = tableView.indexPathForSelectedRow?.row
            vc.myImage = tableListImage[index!]
            vc.myText = tableListText[index!]
        }
    }
    
    
    
    
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            tableListImage.remove(at: indexPath.row)
            tableListText.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    

}









