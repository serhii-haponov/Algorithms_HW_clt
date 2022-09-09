//
//  HW3_HR_Auto_Loan.swift
//  Algorithms_HW_clt
//
//  Created by Serhii Haponov on 06.09.2022.
//

import Foundation

//Auto dealerships frequently advertise tempting loan offers in order to make it easier for people to afford the "car of their dreams". A typical sales tactic is to show you various cars, and then talk in terms of what your monthly payment would be, to say nothing of how much you are actually paying for the car, how much interest you pay, or how long you have to make payments.
//
//A typical auto loan is calculated using a fixed interest rate, and is set up so that you make the same monthly payment for a set period of time in order to fully pay off the balance. The balance of your loan starts out as the sticker price of the car. Each month, the monthly interest is added to your balance, and the amount of your payment is subtracted from your balance. (The payment is subtracted after the interest is added.) The monthly interest rate is 1/12 of the yearly interest rate. Thus, if your annual percentage rate is 12%, then 1% of the remaining balance would be charged as interest each month.
//
//You have been checking out some of the cars at your local dealership. An excited salesman has just approached you, shouting about how you can have the car you are looking at for a payment of only monthlyPayment for only loanTerm months! You are to find the annual percentage rate of the loan, assuming that the initial balance of the loan is price.
//
//Because of the way interest is compounded monthly, the actual interest accrued over the course of a year is not necessarily the same as (balance * yearly interest rate). In fact, it's usually more.
//
//Input Format
//
//A single line of input contains 2 real numbers price and monthlyPayment and a single integer number loanTerm.
//
//Constraints
//
//1 ≤ price ≤ 106
//0 ≤ monthlyPayment ≤ price / 2
//1 ≤ loanTerm ≤ 600
//The resulting interest rate will be between 0 and 100, inclusive.
//Output Format
//
//Print a single number — the resulting yearly interest rate. Your answer must be within 10-6 absolute error of the actual result.
//
//Sample Input 0
//
//6800.00 100.00 68
//Sample Output 0
//
//0.000000000000133
//Explanation 0
//
//Noting that 68 payments of 100 equals the total price of 6800, so there is no interest.
//
//Sample Input 1
//
//2000.00 510.00 4
//Sample Output 1
//
//9.562054624583681
//Explanation 1
//
//Here, we do pay a little interest. At 9.562% annual interest, that means each month we pay 0.7968% of the balance in interest. Our payment schedule looks like this:
//
//Month | + Interest | - Payment | = Balance
//------------------------------------------
//      |            |           |  2000.00
//   1  |     15.94  |   510.00  |  1505.94
//   2  |     12.00  |   510.00  |  1007.94
//   3  |      8.03  |   510.00  |   505.97
//   4  |      4.03  |   510.00  |     0.00
//Sample Input 2
//
//15000.00 364.00 48
//Sample Output 2
//
//7.687856394581649
//Explanation 2
//
//This is similar to what purchasing a new car with no money down might look like, if you make payments for 4 years.

//MARK: - Start
struct HW3_HR_Auto_Loan {
    
    func start() {
        let input = getInput()
        print(calculateAnnualPercentage(price: input.price, monthlyPayment: input.monthlyPayment, loanTerm: input.loanTerm))
    }
}

//MARK: - Input
private extension HW3_HR_Auto_Loan {
    func getInput() -> (price: Double, monthlyPayment: Double, loanTerm: Double) {
        print("Set imput for HW3_HR_Auto_Loan:")
        let firstLine = readLine()?.split(separator: " ").compactMap { Double($0) } ?? []
        let price = firstLine[0]
        let monthlyPayment = firstLine[1]
        let loanTerm = firstLine[2]
        return (price, monthlyPayment, loanTerm)
    }
}

//MARK: - Execution
private extension HW3_HR_Auto_Loan {
    
    func calculateAnnualPercentage(price: Double, monthlyPayment: Double, loanTerm: Double) -> Double {
        
        var minValue  = 0.0
        var maxValue = 100.0
        
        var currentPercent = (maxValue + minValue) * 0.5
        
        let intLoanTearm = Int(loanTerm)
        
        while maxValue != currentPercent && minValue != currentPercent  { //?? why True instad takes more time
            var result = price
            for _ in 0..<intLoanTearm {
                result = (result * currentPercent / 100) + result - monthlyPayment
            }
            
            if result > 0.000_000_001 {
                maxValue = currentPercent
            } else if result < -0.000_000_001 {
                minValue = currentPercent
            } else {
                return currentPercent * 12
            }
            currentPercent = (maxValue + minValue) * 0.5
        }
        return currentPercent * 12
    }
    
    
//    Max Versions
    private func calcYearInterest(price: Double, monthPayment: Double, term: Int) -> Double {
        guard monthPayment * Double(term) != price else { return 0.0 }

        func isGoodEnough(yearRate: Double) -> Bool {
            let monthRateMultiplier = 1 + yearRate / 12 / 100

            var sum = price
            var i = term
            while sum >= 0, i >= 0 {
                sum = sum * monthRateMultiplier - monthPayment
                i -= 1
            }

            return i >= 0 && sum <= 0
        }

        // v2 - max_precision
        var bad = 101.0
        var good = 0.0
        var m = (good + bad) / 2
        while bad != m, good != m {
            if isGoodEnough(yearRate: m) {
                good = m
            } else {
                bad = m
            }

            m = (good + bad) / 2
        }

         // v1 - 10^-6 precision
    //    var bad = 101.0
    //    var good = 0.0
    //
    //    while bad - good > (0.000001) {
    //        let m = (good + bad) / 2
    //        if isGoodEnough(yearRate: m) {
    //            good = m
    //        } else {
    //            bad = m
    //        }
    //    }

        return good
    }
}
