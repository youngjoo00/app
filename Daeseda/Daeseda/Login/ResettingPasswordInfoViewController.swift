//
//  ResettingPasswordInfoViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/08.
//

import UIKit

class ResettingPasswordInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["phoneView", "emailView"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
      }()
      let phoneView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
      let emailView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
      }()
}
