//
//  ViewController.swift
//  MVVM+RxSwift
//
//  Created by Luka Gabric on 14/02/2017.
//  Copyright © 2017 lukagabric.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var realFeelLabel: UILabel!
    @IBOutlet private weak var precipitationLabel: UILabel!
    @IBOutlet private weak var refreshButton: UIButton!
    @IBOutlet private weak var updatedAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

