//
//  ContentView.swift
//  QRCodeScanner
//
//  Created by Mohammed Safadi Macbook Pro on 15/01/2023.
//

import SwiftUI
import CodeScanner

struct ContentView: View {
    @State private var isShowingScanner = false
    @State private var scanResult:String = ""
    var body: some View {
        ZStack {
            Text("Scan Will be here")
            VStack {
                VStack {
                    Text("Scan QR Code Example")
                        .font(.subheadline)
                    
                    if scanResult !=  "" {
                        Text("Scan result :  \(scanResult)")
                            .font(.headline)
                    }

                 }
                .padding(.vertical, 20)
                
                Spacer()
                HStack {
                    Button(action: {
                        isShowingScanner.toggle()
                        
                    }, label: {
                        Image(systemName: isShowingScanner ? "bolt.fill" : "bolt.slash.fill")
                            .imageScale(.large)
                            .foregroundColor(isShowingScanner ? Color.yellow : Color.blue)
                            .padding()
                    })
                }
                .background(Color.white)
                .cornerRadius(10)
                
            }.padding()
            
            
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "40", completion: handleScan)
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
       isShowingScanner = false
        switch result {
        case .success(let result):
            let details = result.string
            self.scanResult = details
            print(details)
 
        case .failure(let error):
            print("Scanning failed: \(error.localizedDescription)")
        }
    }

    
}


    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
