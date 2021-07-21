//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by saj panchal on 2021-07-19.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var model: Model = Model()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $model.order.name)
                    TextField("Street Address", text: $model.order.streetAddress)
                    TextField("City", text: $model.order.city)
                    TextField("Zip", text: $model.order.zip)
                    
                }
                Section {
                    NavigationLink(
                        destination: CheckoutView(model: model),
                        label: {
                            Text("Check out")
                        }).disabled(!model.order.hasValidAddress)
                }
            }.navigationBarTitle("Delivery details", displayMode: .inline)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(model: Model())
    }
}
