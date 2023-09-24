//
//  ViewController.swift
//  Weather
//
//  Created by User on 11/05/2023.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var weatherLabel: UILabel!
    
    private let webService = WebService()
    private var changeCancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.placeholder = "eg: Boston"
        weatherLabel.text = "Write city Name"
        createPublishers()
    }
    
    private func createPublishers() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self.textField)
        
        changeCancellable = publisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .compactMap { ($0.object as? UITextField)?.text?.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) }
            .flatMap {
                self.webService.getWeather(city: $0)
                    .catch {_ in Just(Weather.placeHolder) }
                    .map { $0.temp }
            }
            .sink() { temp in
                self.weatherLabel.isHidden = false
                if let temp = temp {
                    self.weatherLabel.text = "\(temp) ℃"
                    self.weatherLabel.textColor = UIColor.black
                } else {
                    self.weatherLabel.text = "invalid city"
                    self.weatherLabel.textColor = UIColor.red
                }
            }
    }
}

