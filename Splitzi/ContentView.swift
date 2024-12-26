//
//  ContentView.swift
//  Splitzi
//
//  Created by Zheer Barzan on 26/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20]
    
    var totalPerPerson : Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        
        
        return amountPerPerson
    }
    
    var body: some View {
     
        NavigationStack{
            
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    
                }
                
                Section(header: Text("How much tip do you want to Tip?")){
                    
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            } .navigationTitle("Splitzi")
                .toolbar{
                    if isFocused{
                        Button("Done"){
                            isFocused = false
                        }
                    }
                }

        }
    }
}

#Preview {
    ContentView()
}
