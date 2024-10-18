//
//  ContentView.swift
//  DeviceOrientationPublisher
//
//  Created by Jackie Lu on 2024/10/18.
//

import SwiftUI
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var value: Int = 0
    private var cancellble: AnyCancellable?
    
    init() {
        let publisher = Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .map {
                _ in self.value + 1
            }
        
        cancellble = publisher.assign(to: \.value, on: self)
        cancellble?.cancel()
    }
}

struct ContentView: View {
    
    @StateObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.value)")
                .font(.largeTitle)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
