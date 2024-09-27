//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Tunay Biçer on 26.09.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelFormula: UILabel!
    @IBOutlet weak var labelResults: UILabel!
    
    var formula:String = ""
    var inOperation:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
    }
    
    func clearAll(){
        // bütün işlemlere reset atar
        formula = ""
        labelFormula.text = ""
        labelResults.text = ""
        inOperation = false
    }
    
    @IBAction func allClearTap(_ sender: Any) {
        clearAll()
    }
    
    
    @IBAction func backTap(_ sender: Any) {
        // formula stringindeki son değeri siler
        if (!formula.isEmpty){
            formula.removeLast()
            labelFormula.text = formula
        }
    }
    
    func addFormula(value: String){
        // formula stringine gelen değerleri ekle
        inOperation = true
        formula += value
        labelFormula.text = formula
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        // eğer operasyon yok ise results labelini boşalt
        if inOperation == false {
            labelResults.text = ""
        }
        // tıklanan numarayı ayırt et
        if let number = sender.titleLabel?.text {
            addFormula(value: number)
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        // tıklanan operasyon butonunu ayırt et
        switch sender.tag {
            case 1: // "+"
                addFormula(value: "+")
            case 2: // "-"
                addFormula(value: "-")
            case 3: // "*"
                addFormula(value: "*")
            case 4: // "/"
                addFormula(value: "/")
            case 5: // %
                addFormula(value: "%")
            default:
                break
            }
    }
    
    @IBAction func equalsPressed(_ sender: Any) {
        
        inOperation = false // operasyonu durdur
        if validInput(){
            let forceDouble = formula.replacingOccurrences(of: "(?<![\\d\\.])([0-9]+)(?!\\.[0-9]+)", with: "$1.0", options: .regularExpression) // Sadece tam sayıları Double'a zorlama
            let checkFormulaPercentage = forceDouble.replacingOccurrences(of: "%", with: "*0.01") // yüzde alma işlemi için formülü düzenle
            let expression = NSExpression(format: checkFormulaPercentage) // tüm işlemi expression ile yap
            let result = expression.expressionValue(with: nil, context: nil) as! Double // gelen sonucu Double olarak forced cast et
            let resultString = formatResult(result: result) // sonucu formatlama için fonksiyona yolla
            labelResults.text = resultString
            formula = ""
        }else {
            // geçerli giriş olmayan durumlarda alert çıkartır
            let alert = UIAlertController(title: "Hatalı Giriş", message: "Hesap makinesi girilen veriyle işlem yapamadı!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // tam sayıları ve ondalıklı sayıları formatlama
    func formatResult(result: Double) -> String {
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", result)
        }else {
            return String(format: "%.2f", result)
        }
    }
    
    // eğer geçerli giriş yapılmadı ise false gönderecek
    func validInput() -> Bool{
        
        var count = 0
        var funcCharIndexes = [Int]()
        
        // formula içerisindeki tüm charları sayar
        for char in formula {
            if speacialCharacter(char: char){ // eğer özel karakter ise array'e index countu yollar
                funcCharIndexes.append(count)
            }
            count += 1
        }
        
        func speacialCharacter (char: Character) -> Bool{ // özel karakter ise true döndür
            if char == "*"{
                return true
            }
            if char == "-"{
                return true
            }
            if char == "/"{
                return true
            }
            if char == "+"{
                return true
            }
            if char == "%"{
                return true
            }
            return false
        }
        
        var previous : Int = -1 // -1 çünkü şu an array indexinde herhangi bir özel karakter yok
        
        for index in funcCharIndexes { // özel karakterler arrayini döndürür
            if index == 0 { // eğer ilk index özel karakter ise false döndür
                return false
            }
            if index == formula.count - 1 { // eğer son index özel karakter ise false döndürür
                return false
            }
            
            if previous != -1{ // previous -1 e eşit ise çalışır.
                if index - previous == 1 { // index değerinden previous çıktığında 1 kalıyorsa iki özel karakter yan yana demektir. Bu yüzden false döner
                    return false
                }
            }
            previous = index
        }
        
        return true
    }
    
}

