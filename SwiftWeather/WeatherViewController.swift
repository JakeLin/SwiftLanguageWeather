//
//  Created by Jake Lin on 8/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit
import FacebookShare
import CoreSpotlight
import MobileCoreServices

//MARK: - UIViewController Properties
class WeatherViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet var forecastViews: [ForecastView]!
    
    let identifier = "WeatherIdentifier"
    
    //MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WeatherViewModel()
        viewModel?.startLocationService()
        setAccessibilityIdentifiers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureLabels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureLabelsWithAnimation()
    }
    
    //MARK: ViewModel
    var viewModel: WeatherViewModel? {
        didSet {
            viewModel?.location.observe {
                [unowned self] in
                self.locationLabel.text = $0                
                
                let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
                attributeSet.title = self.locationLabel.text
                
                let item = CSSearchableItem(uniqueIdentifier: self.identifier, domainIdentifier: "com.rushjet.SwiftWeather", attributeSet: attributeSet)
                CSSearchableIndex.default().indexSearchableItems([item]){error in
                    if let error =  error {
                        print("Indexing error: \(error.localizedDescription)")
                    } else {
                        print("Location item successfully indexed")
                    }
                }
            }
            
            viewModel?.iconText.observe {
                [unowned self] in
                self.iconLabel.text = $0
            }
            
            viewModel?.temperature.observe {
                [unowned self] in
                self.temperatureLabel.text = $0
            }
            
            viewModel?.forecasts.observe {
                [unowned self] (forecastViewModels) in
                if forecastViewModels.count >= 4 {
                    for (index, forecastView) in self.forecastViews.enumerated() {
                        forecastView.loadViewModel(forecastViewModels[index])
                    }
                }
            }
        }
    }
    
    //MARK: Accessibility
    func setAccessibilityIdentifiers() {
        locationLabel.accessibilityIdentifier = "a11y_current_city"
        iconLabel.accessibilityIdentifier = "a11y_wheather_icon"
        temperatureLabel.accessibilityIdentifier = "a11y_wheather_temperature"
    }
    
    //MARK: Functions
    func configureLabels(){
        locationLabel.center.x  -= view.bounds.width
        iconLabel.center.x -= view.bounds.width
        temperatureLabel.center.x -= view.bounds.width
        iconLabel.alpha = 0.0
        locationLabel.alpha = 0.0
        temperatureLabel.alpha = 0.0
    }
    
    func configureLabelsWithAnimation(){
        UIView.animate(withDuration: 0.5, animations: {
            self.locationLabel.center.x += self.view.bounds.width
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.iconLabel.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.0, options: [], animations: {
            self.temperatureLabel.center.x += self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.iconLabel.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.locationLabel.alpha = 1.0
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.temperatureLabel.alpha = 1.0
        }, completion: nil)
    }
    
    //MARK: Actions
    @IBAction func shareButtonPressed(_ sender: Any) {
        shareOnFacebook()
    }
    
    func shareOnFacebook(){
        let photo = Photo(image: #imageLiteral(resourceName: "background"), userGenerated: false)
        let myContent = PhotoShareContent(photos: [photo])
        let shareDialog = ShareDialog(content: myContent)
        shareDialog.mode = .native
        shareDialog.failsOnInvalidData = true

        try? shareDialog.show()
    }
}
