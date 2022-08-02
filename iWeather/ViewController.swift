//
//  ViewController.swift
//  iWeather
//
//  Created by Betul Erdis on 2022-07-16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var getTempIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tempView: UIView!
    @IBOutlet weak var maxTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var cityNameTxtFld: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tempView.isHidden = true
        self.getTempIndicator.isHidden = true
        
    }

    @IBAction func cityWeatherRequest(_ sender: Any) {
        
        if let cityName = self.cityNameTxtFld.text, cityName != "" {
            self.getTempIndicator.isHidden = false
            self.getTempIndicator.startAnimating()
            WebServiceManager.sharedInstance.callWeatherAPI(forCity: cityName) { (success, message, data) in
                DispatchQueue.main.async {
                    self.getTempIndicator.stopAnimating()
                    self.getTempIndicator.isHidden = true
                }
                if success, let responseData = data {
                    DispatchQueue.main.async {
                        self.tempView.isHidden = false
                        self.currentTempLbl.text = "\(responseData.temp)"
                        self.minTempLbl.text = "\(responseData.temp_min)"
                        self.maxTempLbl.text = "\(responseData.temp_max)"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.tempView.isHidden = true
                        self.showAlert(with: "Data is not available now.")
                    }
                }
            }
        } else {
            showAlert(with: "Please enter a city name")
            
        }
    }
    func showAlert(with message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
        
    }


}

