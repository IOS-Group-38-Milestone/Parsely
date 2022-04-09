//
//  CreateRecipeViewController.swift
//  Parsely
//
//  Created by Patrick Brothers on 4/8/22.
//

import UIKit
import Parse
import Alamofire
import AlamofireImage

class CreateRecipeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // IB Outlets:
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var prepTimeTextField: UITextField!
    
    @IBOutlet weak var cookTimeTextField: UITextField!
    
    @IBOutlet weak var ingredientsTextView: UITextView!
    
    @IBOutlet weak var instructionsTextView: UITextView!
    
    @IBOutlet weak var tagsTextView: UITextView!
    
    @IBOutlet weak var captionImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Helper Functions
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        
        captionImageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    
    // Buttons:
    
    @IBAction func onCaptionButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)

    }
    
    @IBAction func onPost(_ sender: Any) {
        // access api
        // populate with data from outlets (parse tags)
        // fail if user hasn't entered values
        let recipe = PFObject(className: "Recipes") // make sure you include the s!
        
        recipe["name"] = nameTextField.text
        recipe["prep_time"] = prepTimeTextField.text
        recipe["cook_time"] = cookTimeTextField.text
        
        recipe["ingredients"] = ingredientsTextView.text
        recipe["instructions"] = instructionsTextView.text
        
        // parse tags
        let tagString = tagsTextView.text!
        let tagArray = tagString.components(separatedBy: ",")
        recipe["tags"] = tagArray.map { (tag) -> String in
            (tag.replacingOccurrences(of: " ", with: "")).lowercased()
        }
        
        recipe["author"] = PFUser.current()
        
        let imageData = captionImageView.image!.pngData()
        let file = PFFileObject(name: "image.png", data: imageData!)
        
        recipe["image"] = file
        
        recipe.saveInBackground { (success, error) in
            if success {
                print("success")
                self.dismiss(animated: true, completion: nil)
            } else {
                print("error: \(error?.localizedDescription)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
