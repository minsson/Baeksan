//
//  BaeksanApp.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//

import SwiftUI

@main
struct SwiftulMapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
