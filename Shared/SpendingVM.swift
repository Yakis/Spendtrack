//
//  SpendingVM.swift
//  Spendtrack
//
//  Created by Mugurel on 13/07/2020.
//

import Foundation


class SpendingVM: ObservableObject {
    @Published var total: Double = 0
    
    
    
    func calculateSpendings(timeSpan: [Item]) {
        var temp: Double = 0
        for item in timeSpan {
            print(item.type)
            if item.type == "expense" {
                temp -= item.amount
            } else {
                temp += item.amount
            }
            total = temp
        }
    }
    
    
    
        }
