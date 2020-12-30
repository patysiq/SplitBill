//
//  ContentView.swift
//  SplitBill
//
//  Created by PATRICIA S SIQUEIRA on 30/12/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalPerPerson: Double {
        let doublePeople = Double(numberOfPeople) ?? 0
        let peopleCount = Double(doublePeople + 1)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue

        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Valor da Conta", text: $checkAmount).keyboardType(.decimalPad)
                    
                    TextField("Número de pessoas", text: $numberOfPeople).keyboardType(.numberPad)
                }
                Section(header: Text("Quanto de gorjeta você gostaria de dar?")) {
                    Picker("Porcentagem de gorjeta", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Valor total da conta")) {
                    Text("R$\(totalAmount, specifier: "%.2f")")
                }
                
                Section(header: Text("Valor por pessoa")) {
                    Text("R$\(totalPerPerson, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle("Dividindo a conta")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
