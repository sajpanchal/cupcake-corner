//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by saj panchal on 2021-07-18.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var model = Model()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select Cupcake Type", selection: $model.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) { index in
                            Text(Order.types[index])
                        }
                    }
                }
                Stepper(value: $model.order.quantity, in: 3...20) {
                    Text("Number of cakes: \(model.order.quantity)")
                }
                Section {
                    Toggle(isOn: $model.order.specialRequestEnabled.animation(), label: {
                        Text("Any Special Requests?")
                    })
                    if model.order.specialRequestEnabled {
                        Toggle(isOn: $model.order.extraFrosting, label: {
                            Text("Add Extra Frosting")
                        })
                        Toggle(isOn: $model.order.addSprinkles, label: {
                            Text("Add Extra Sprinkles")
                        })
                    }
                    
                }
                Section {
                    NavigationLink(
                        destination: AddressView(model: model),
                        label: {
                            Text("Delivery Details")
                        })
                }
            }.navigationBarTitle("Cupcake Corner")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
