//
//  ReviewWriteViewController.swift
//  Daeseda
//
//  Created by youngjoo on 2023/09/20.
//

import UIKit

class ReviewWriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.reviewTextView.layer.borderWidth = 1.0
        self.reviewTextView.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var reviewTextView: UITextView!
    
    


}
