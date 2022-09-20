//
//  VisitedLocationAnnotaionView.swift
//  Baeksan
//
//  Created by jin on 9/20/22.
//

import SwiftUI

struct VisitedLocationAnnotaionView: View {
    let accentColor = Color.red
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "flag.circle.fill")
                .font(.system(size: 30))
//                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(accentColor)
                .clipShape(Circle())
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(accentColor)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct VisitedLocationAnnotaionView_Previews: PreviewProvider {
    static var previews: some View {
        VisitedLocationAnnotaionView()
    }
}
