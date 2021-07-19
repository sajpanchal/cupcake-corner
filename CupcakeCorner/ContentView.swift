//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by saj panchal on 2021-07-18.
//

import SwiftUI

struct ContentView: View {
   @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select Cupcake Type", selection: $order.type) {
                        ForEach(0..<Order.types.count, id: \.self) { index in
                            Text(Order.types[index])
                        }
                    }
                }
                Stepper(value: $order.quantity, in: 3...20) {
                    Text("Number of cakes: \(order.quantity)")
                }
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation(), label: {
                        Text("Any Special Requests?")
                    })
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting, label: {
                            Text("Add Extra Frosting")
                        })
                        Toggle(isOn: $order.addSprinkles, label: {
                            Text("Add Extra Sprinkles")
                        })
                    }
                    
                }
                Section {
                    NavigationLink(
                        destination: AddressView(order: order),
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
