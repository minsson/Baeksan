//
//  LocationsListView.swift
//  Baeksan
//
//  Created by minsson on 2022/09/14.
//


import SwiftUI

struct LocationsListView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) { location in
                Button {
                    vm.showNextLocation(location: location)
                } label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
            .environmentObject(LocationsViewModel())
    }
}

extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(location.title)
                    .font(.headline)
                Text("\(location.height)m")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Image(systemName: location.isVisited ? "checkmark.circle" : "circle")
                .onTapGesture {
                    vm.updateLocations(of: location)
                }
        }
    }
}

