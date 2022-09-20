//
//  LocationPreviewView.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//


import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel

    let location: Location
    
    var body: some View {
        VStack(spacing: 16.0) {
            
            HStack(alignment: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 16) {
                    imageSection
                    titleSection
                }
                
                VStack(spacing: 20) {
                    learnMoreButton
                    nextButton
                    visitedButton
                }
                
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .foregroundColor(.green)
//                    .offset(y: 65)
            )
            .clipped()
        }
    }
}

//struct LocationPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.green.ignoresSafeArea()
//            LocationPreviewView(location: LocationsDataService.locations.first!)
//                .padding()
//        }
//        .environmentObject(LocationsViewModel())
//    }
//}

extension LocationPreviewView {
    private var imageSection: some View {
        ZStack {
            AsyncImage(url: URL(string: vm.locationImages?.first?.thumbnail ?? ""))
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.title)
                .font(.title2)
                .fontWeight(.bold)
            Text("\(location.height)m")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            vm.sheetLocation = location
        } label: {
            Text("더보기")
                .font(.headline)
                .frame(width:125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
            vm.downloadImagefromNaver()
        } label: {
            Text("다음")
                .font(.headline)
                .frame(width:125, height: 35)
        }
        .buttonStyle(.bordered)
    }
    
    private var visitedButton: some View {
        Button {
            vm.updateLocations()
        } label: {
            if vm.mapLocation.isVisited == true {
                ButtonView(vm: vm, text: "등반완료", shouldFillBackground: true) {
                    vm.updateLocations()
                }

            } else {
                ButtonView(vm: vm, text: "등반완료", shouldFillBackground: false) {
                    vm.updateLocations()
                }
            }
        }
    }
}



