//
//  WeatherViewController.swift
//  MVVM+RxSwift
//
//  Created by Luka Gabric on 14/02/2017.
//  Copyright © 2017 lukagabric.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {
    
    //MARK: - Vars
    
    @IBOutlet private weak var errorView: UIView!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!
    @IBOutlet private weak var realFeelLabel: UILabel!
    @IBOutlet private weak var precipitationLabel: UILabel!
    @IBOutlet private weak var updatedAtLabel: UILabel!
    @IBOutlet private weak var refreshButton: UIButton!
    
    private var viewModel: WeatherViewModel!
    
    private let weatherDataService: WeatherDataService
    
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    
    init(weatherDataService: WeatherDataService) {
        self.weatherDataService = weatherDataService
        super.init(nibName: "WeatherViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureViewModel()
        self.configureBindings()
    }
    
    //MARK: - Private
    
    private func configureViewModel() {
        let refreshDriver = self.refreshButton.rx.tap.asDriver()
        self.viewModel = WeatherViewModel(weatherDataService: self.weatherDataService, refreshDriver: refreshDriver)
    }
    
    private func configureBindings() {
        self.viewModel.locationName.drive(self.locationLabel.rx.text).disposed(by: self.disposeBag)
        self.viewModel.temperature.drive(self.temperatureLabel.rx.text).disposed(by: self.disposeBag)
        self.viewModel.realFeel.drive(self.realFeelLabel.rx.text).disposed(by: self.disposeBag)
        self.viewModel.precipitationPercentage.drive(self.precipitationLabel.rx.text).disposed(by: self.disposeBag)
        self.viewModel.updatedAt.drive(self.updatedAtLabel.rx.text).disposed(by: self.disposeBag)
        self.viewModel.isLoading.map { !$0 }.drive(self.loadingView.rx.isHidden).disposed(by: self.disposeBag)
        self.viewModel.isLoading.map { !$0 }.drive(self.refreshButton.rx.isEnabled).disposed(by: self.disposeBag)
        self.viewModel.hasFailed.map { !$0 }.drive(self.errorView.rx.isHidden).disposed(by: self.disposeBag)
    }
    
    //MARK: -
    
}

