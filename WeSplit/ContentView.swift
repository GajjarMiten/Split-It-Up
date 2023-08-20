import SwiftUI

extension Int {
    func toDouble() -> Double {
        Double(self)
    }
}

struct ContentView: View {
    
    @State private var checkAmount = 0.0;
    @State private var numOfPeople = 2;
    @State private var tipAmount = 20.0;
    @State private var tipPercentage = 0;
    
    @FocusState private var amountIsFocused:Bool;
    
    let tips = [10, 15, 20, 25, 0]
    
    var totalPerPerson:Double{
        
        let peopleCount = (numOfPeople+2).toDouble()
        
        let tipAmont  = checkAmount * tipPercentage.toDouble()/100;
        
        return (checkAmount + tipAmont)/peopleCount;
        
    }
    
    var body: some View {
        Form{
            Section{
                TextField("Enter the amount",value: $checkAmount,
                          format: .currency(code: Locale.current.currency?.identifier ?? "USD"),
                          prompt: Text("Enter the amount"))
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)
                
                Picker("Number of people",selection: $numOfPeople){
                    ForEach(2 ..< 100) {
                        Text("\($0) people")
                    }
                }
            }
            Section{
                Picker("Percentage of tip",selection:$tipPercentage ){
                    ForEach(tips,id: \.self){
                        Text($0,format:.percent)
                    }
                    
                }
                .pickerStyle(.segmented)
            } header: {
                Text("How much tip you want to leave?")
            }
            Section{
                Text(totalPerPerson,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
        }
        
        .toolbar{
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
