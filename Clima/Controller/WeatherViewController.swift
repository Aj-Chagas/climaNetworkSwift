//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        fetcheWeather()
    }
    
    //dispara quado o botao retorno do teclado é acionado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //fecha teclado
        textField.endEditing(true)
        return true
    }
    
    // quando o usuario toca em outra coisa
    // caso a string seja vazia, ele não consegue tirar o foco do text view
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else{
            textField.placeholder = "Type something"
            return false
        }
    }
    
    //quando perde o foco
    func textFieldDidEndEditing(_ textField: UITextField) {
        fetcheWeather()
    }
    
    func fetcheWeather() {
        if let city = searchTextField.text {
            weatherManager.fetcheWeather(cityName: city)
        }
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController : WeatherManagerDelegate {
    
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            
        }
        print(weather.temperatureString)
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
    
}

