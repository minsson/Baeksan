//
//  ButtonView.swift
//  Baeksan
//
//  Created by minsson on 2022/09/20.
//

import SwiftUI

struct ButtonView: View {
    
    @ObservedObject var vm: LocationsViewModel
    
    var text: String
    var shouldFillBackground: Bool
    var action: () -> Void
    
    var body: some View {
        
        if shouldFillBackground {
            Button {
                action()
            } label: {
                Text(text)
                    .font(.headline)
                    .frame(width: 125, height: 35)
                    .foregroundColor(.white)
            }
            .frame(width: 148, height: 49)
            .background(Color("CompleteButtonColor"))
            .cornerRadius(10)
        } else {
            Button {
                action()
            } label: {
                Text(text)
                    .font(.headline)
                    .frame(width: 125, height: 35)
            }
            .buttonStyle(.bordered)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    
    static var vm = LocationsViewModel()
    
    static var previews: some View {
        ButtonView(vm: vm, text: "My Button", shouldFillBackground: true) {
        }
    }
}
