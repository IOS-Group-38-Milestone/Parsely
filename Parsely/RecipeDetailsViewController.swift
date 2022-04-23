//
//  RecipeDetailsViewController.swift
//  Parsely
//
//  Created by Yulduz Muradova on 4/16/22.
//

import UIKit
import Parse

class RecipeDetailsViewController: UIViewController {
    var recipe: PFObject!
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var PrepTimeLabel: UILabel!
    
    @IBOutlet weak var cookTimeLabel: UILabel!
    
    @IBOutlet weak var IngredientsText: UITextView!
    @IBOutlet weak var stepsText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameRecipe = recipe["name"] as! String
        recipeNameLabel.text = nameRecipe
        let prepTime = recipe["prep_time"] as! String
        PrepTimeLabel.text = prepTime
        let cookTime = recipe["cook_time"] as! String
        cookTimeLabel.text = cookTime
        let imageFile = recipe["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)!
        recipeImage.af.setImage(withURL: url)
  
        let ingredients = recipe["ingredients"] as! String
        IngredientsText.text = ingredients
        let steps = recipe["instructions"] as! String
        stepsText.text = steps
        // Do any additional setup after loading the view.
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
