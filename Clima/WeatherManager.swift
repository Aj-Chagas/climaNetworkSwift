//
//  WheatherManager.swift
//  Clima
//
//  Created by Anderson Chagas on 13/04/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=273ae29997f369b4fdbfb577a14f5772&units=metric"
    var delegate : WeatherManagerDelegate?
    
    func fetcheWeather(cityName : String) {
        let url = "\(weatherURL)&q=\(cityName.trimmingCharacters(in: .whitespaces).stringByAddingPercentEncodingForRFC3986() ?? "London")"
        performRequest(with: url)
    }
    
    func performRequest(with urlString : String){
        //1. Create a URL
        if let url : URL = URL(string: urlString){
            
            //2. Create a URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            
            //4. start the task
            task.resume()
        }
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?){
        
        if error != nil {
            delegate?.didFailWithError(error!)
            return
        }
        
        
        if let safeData = data {
            if let weather = parseJson(safeData) {
                delegate?.didUpdateWeather(weather)
            }
        }
        
    }
    
    func parseJson(_ weatherDate : Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: weatherDate)
            
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            
        } catch {
            print(error)
            return nil
        }
        
    }
    
}


