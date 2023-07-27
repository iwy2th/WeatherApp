//
//  ViewController.swift
//  WeatherApp
//
//  Created by Iwy2th on 26/07/2023.
//

import UIKit

class ViewController: UIViewController {
  // MARK: - Properties
  @IBOutlet weak var conditionImageView: UIImageView!
  @IBOutlet weak var temperaturelLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var searchTextField: UITextField!
  // MARK: - ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    //
  }
  @IBAction func searchPressed(_ sender: UIButton) {
    searchTextField.endEditing(true)
    print(searchTextField.text!)
  }
}
// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
    print(searchTextField.text!)
    return true
  }
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    searchTextField.text = ""
    return true
  }
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    if textField.text != "" {
      return true
    } else {
      textField.placeholder = "Enter the city name"
      return false
    }
  }
  func textFieldDidEndEditing(_ textField: UITextField) {
    
  }
}

