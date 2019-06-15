//
//  ViewController.swift
//  GoldPrice
//
//  Created by Саша Гужавин on 05/05/2019.
//  Copyright © 2019 Sasha Guzhavin. All rights reserved.
//

import UIKit

// лучше сделать final
// final class and final function

// паттерны проектирования

// про стиль кода и правила можно использовать swiftlint
// raywenderlich - code style guide

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private weak var errorViewPrace: UIView! // все аутлеты приватные, потому что снаружи никто не должен изменять вью
    @IBOutlet weak var errorViewWeight: UIView!
    @IBOutlet weak var metalSegment: UISegmentedControl!
    @IBOutlet weak var resulfLabel: UILabel!
    @IBOutlet weak var weightTextView: UITextField!
    @IBOutlet weak var praceTextView: UITextField!
    
    // Расчет введеных значений и вывод их на resulfLabel
    
    // требует декомпозиции
    @IBAction func doneButton(_ sender: UIButton) {
       // Запрещает расчет при отсутствии значений
        let myColorRed : UIColor = UIColor.red
        let myColorWhite : UIColor = UIColor.white
        if weightTextView.text == "" {
            self.resulfLabel.text = "Введите массу"
            self.errorViewWeight.backgroundColor = myColorRed
            return
        } else if praceTextView.text == "" {
            self.resulfLabel.text = "Введите пробу"
            self.errorViewPrace.backgroundColor = myColorRed
            self.errorViewWeight.backgroundColor = myColorWhite
            return
        }
        if weightTextView.text == "0" {
            self.resulfLabel.text = "Введите массу"
            return
        } else if praceTextView.text == "0" {
            self.resulfLabel.text = "Введите пробу"
            return
        }
        weightTextView.resignFirstResponder()
        praceTextView.resignFirstResponder()
        let massa: Double = Double(String(weightTextView.text!))! // force unwrap === плохо  if let, if var, guard let
        let proba: Int = Int(String(praceTextView.text!))!
        let why: String = String(metalSegment.titleForSegment(at: metalSegment!.selectedSegmentIndex)!)
        let priceGoldNowRur: Double = 2790.11
        let priceSerebroNowRur: Double = 31.18
        let myColor : UIColor = UIColor.red
        let myColor1 : UIColor = UIColor.white
        // Формула расчета
        func price(massa: Double, proba: Int, why: String) -> Int {
            self.errorViewPrace.backgroundColor = myColorWhite
            self.errorViewWeight.backgroundColor = myColorWhite
            let convertProba = Double(proba) / 1000
            switch why {
            case "Серебро":
                let price = massa * convertProba * priceSerebroNowRur
                return Int(price)
            case "Золото":
                let price = massa * convertProba * priceGoldNowRur
                return Int(price)
            default:
                return Int("Error 1")!
            }
        }
        self.resulfLabel.text = " Цена \(price(massa: massa, proba: proba, why: why)) руб."
    }
    
    // Очистка информации с экрана
    @IBAction private func clearButtom(_ sender: UIButton) {
        let myColorWhite : UIColor = UIColor.white
        errorViewWeight.backgroundColor = myColorWhite
        errorViewPrace.backgroundColor = myColorWhite
        weightTextView.text = ""
        praceTextView.text = ""
        self.resulfLabel.text = "Gold Price"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // IQKeyboardManager - либа для клавиатуры
    // keyboard notification swift
    // Скрытие клавиатуры при нажатии на экран
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    // Запрещает переворот экрана
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    override var shouldAutorotate: Bool {
        return false
    }
}

extension ViewController {
    
    private func initialSetup() {
        weightTextView.delegate = self
        praceTextView.delegate = self
        weightTextView.tintColor = .clear
        praceTextView.tintColor = .clear
    }
}
