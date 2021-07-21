//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by saj panchal on 2021-07-19.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var model = Model()
   
    @State var confirmationMessage = ""
    @State var showingConfirmation = false
    var body: some View {
        GeometryReader { geometryProxy in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width:geometryProxy.size.width)
                    Text("Your total is $\(self.model.order.cost, specifier: "%.2f")")
                        .font(.title)
                    Button("Place Order") {
                        self.placeOrder()
                    }.padding()
                }
               
            }
        }.alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text("Thank You"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        })
    }
    // calling this method on button click.
    func placeOrder() {
        //encode the given Order instance to JSON format.
        guard let encoded = try? JSONEncoder().encode(model.order) else {
            print("failed to encode order")
            return
        }
        // set the url.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        //create url request for a given url
        var request = URLRequest(url: url)
        //configure a request to sent http POST request and attach the body with encoded JSON string.
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        // create a URL session by sending the request and catch the response.
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //if the response is OK we will get data.
            guard let data = data else {
                self.confirmationMessage = "Error: Connection failed. Please check the internet connection."
                self.showingConfirmation = true
                return
            }
            // decode the given data back into Order instance format.
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your Order for \(decodedOrder.quantity)x\(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                //show the alert once got the response.
                self.showingConfirmation = true
            }
            else {
                     print("Invalid response from server.")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(model: Model())
    }
}
