import UIKit

//1.
func sumAngles(cornerCount: Int) -> Int{
    guard cornerCount >= 3 else {
        return 0
    }
    return (cornerCount - 2) * 180
}
print("İç açılar toplamı : \(sumAngles(cornerCount: 2))")

//2.
func calcSalary(days:Int) -> Int{
    if days < 1 {
        return 0
    }
    let hours = days * 8
    if hours > 160 {
        return (160 * 10) + ((hours - 160) * 20)
    }
    return hours * 10
}
print("Maaşınız : \(calcSalary(days: 21))₺")

//3.

func calcQuota(quota:Int) -> Int{
    guard quota > 0 else {
        return 0
    }
    if quota <= 50 {
        return 100
    }
    return ((quota - 50) * 4) + 100
}

print("Borcunuz : \(calcQuota(quota: 52))")

//4.

func calcFahreinheit(celc:Int) -> Double {
    return Double(celc) * 1.8 + 32
}

print("Fahreinheit \(calcFahreinheit(celc: 1))")

//5.

func calcPerimeter(short:Int,long:Int) {
    print("Dikdörtgenin çevresi : \(2 * (short + long))")
}

calcPerimeter(short: 2, long: 5)

//6.

func calcFactorial (num:Int) -> Int {
    guard num >= 0 else {
        print("Negatif sayıların faktöriyeli hesaplanamaz.")
        return 0
    }
        
    if num == 0 || num == 1 {
        return 1
    }
    
    var total = 1
    for x in 1...num {
        total *= x
    }
    return total
}

print("Faktöriyel : \(calcFactorial(num: 5))")

//7.

func calcA(word:String){
    var total = 0
    
    for x in word {
        if x == "a" || x == "A" {
            total += 1
        }
    }
    print("Kelime içerisinde \"\(total)\" adet a harfi mevcut")
}

calcA(word: "muvaffakiyetsizleştiricileştiriveremeyebileceklerimizdenmişsinizcesine")
