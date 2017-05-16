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

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }

    func showMsg(image: UIImage, text: String) {
        
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
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    

}









