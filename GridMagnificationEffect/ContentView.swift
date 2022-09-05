//
//  ContentView.swift
//  GridMagnificationEffect
//
//  Created by Aleksandr F. on 02.09.2022.
//

import SwiftUI

struct ContentView: View {
    @GestureState var location:CGPoint = .zero
    var body: some View {
        GeometryReader{proxy in
            let size = proxy.size
            
            // MARK: To Fit Into Whole View
            let width = size.width/10
            let itemCount = Int((size.height / width).rounded()) * 10
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
