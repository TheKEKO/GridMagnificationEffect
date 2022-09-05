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
            
            // MARK: For Solid Linear Gradient
            LinearGradient(colors: [.cyan, .yellow, .mint, .pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .mask {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: 10), spacing: 0) {
                        let colors:[Color] = [.cyan, .yellow, .mint, .pink, .purple, .orange, .blue, .brown]
                        ForEach(0..<itemCount, id: \.self) {i in
                            GeometryReader{ innerProxy in
                                let rect = innerProxy.frame(in: .named("GESTURE"))
                                let scale = itemScale(rect: rect, size: size)
                                
                                // MARK: Instead Of Manual Calculation
                                let trasnformedRect = rect.applying(.init(scaleX: scale, y: scale))
                                
                                // MARK: Transforming Location Too
                                let transformedLocation = location.applying(.init(scaleX: scale, y: scale))
                                
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(colors[i % colors.count])
                                
                                // MARK: For Effect 1
                                    .scaleEffect(scale)
                                    .offset(x: trasnformedRect.midX - rect.midX,
                                            y: trasnformedRect.midY - rect.midY)
                                    .offset(x: location.x - transformedLocation.x,
                                            y: location.y - transformedLocation.y)
                                
                                // MARK: For Effect 2 Simple Replace Scale Location
                                //                                    .scaleEffect(scale)
                            }
                            .padding(5)
                            .frame(height:width)
                        }
                    }
                }
            
        }
        .padding(16)
        .gesture(
            DragGesture(minimumDistance: 0)
                .updating($location, body: { value, out, _ in
                    out = value.location
                })
        )
        .coordinateSpace(name: "GESTURE")
        .preferredColorScheme(.dark)
        .animation(.easeInOut, value: location == .zero)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
