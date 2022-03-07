//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Mac on 06/03/22.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather : WeatherModel)
    func didFailWithError(error: Error)
    func showAlert(with message : String)
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=589b650d537baf6c580774ab6ff28e39&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName : String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude : CLLocationDegrees, longitude : CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        // 1 Create URL
        if let url = URL(string: urlString){
            // 2 Create Session
            let session = URLSession(configuration: .default)
            // 3 Create Data Task
            //let task = session.dataTask(with: url, completionHandler: handle(data:responce:error:))
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                else{
                    if let safeData = data {
                        //parseData(weatherData: safeData)
                        if let weather = parseData(safeData){
                            print(weather.conditionName)
                            delegate?.didUpdateWeather(weather : weather)
                        }
                        
                    }else{
                        
                    }
                }
            }
            // 4 Start Task
            task.resume()
        }
        else{
            print("URL is not created successfuly")
            delegate?.showAlert(with: "URL is not created successfuly")
        }
        
    }
    
    func parseData(_ weatherData : Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let weather = WeatherModel(conditionId: id, temp: temp, cityName: name)
            return weather
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    }
