//
//  VegetableInfoViewController.swift
//  VegetableSearchController
//
//  Created by Sakshi Yelmame on 11/04/23.
//

import UIKit

class VegetableInfoViewController: UIViewController {
    
    @IBOutlet weak var vegetableUIImageView: UIImageView!
    
    @IBOutlet weak var vegetableNameUILabel: UILabel!
    
    @IBOutlet weak var vegetableDiscriptionUILabel: UILabel!
    
    var selectedVegetableInfo : Vegetable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let vegName = selectedVegetableInfo?.name, let vegImageName = selectedVegetableInfo?.imagename,let vegDescription =  selectedVegetableInfo?.description{
            vegetableUIImageView.image = UIImage(named: vegImageName)
            vegetableNameUILabel.text = "\(vegName)"
            vegetableDiscriptionUILabel.text = "\(vegDescription)"
        }
    }
}
