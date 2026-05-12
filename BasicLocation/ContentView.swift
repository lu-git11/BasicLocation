//
//  ContentView.swift
//  BasicLocation
//
//  Created by jeffrey lullen on 5/12/26.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var viewModel: LocationViewModel = LocationViewModel()
    
    
    var body: some View {
        VStack {
            Text("Nearby Logs").font(.title).bold()
            
            if viewModel.viewState == .needsPermission{
                PermissionView(onEnable: viewModel.enableLocation)
            }
            else if viewModel.viewState == .loading{
                LoadingView()
            }
            else if viewModel.viewState == .ready{
                LocationReadyView(
                    latText: viewModel.latitude,
                    longText: viewModel.longitude,
                    onRefresh:{ viewModel.refreshButton()},
                    onSave:{ viewModel.saveCheckIn()}
                )
            }else if viewModel.viewState == .failed {
                FailedView(
                    message: viewModel.errorMessage,
                    onTryAgain: viewModel.refreshButton
                )
            }
            
            CheckInListView(
                checkIns: viewModel.checkIns,
                onClearAll: viewModel.clearAll
            )
        }
    }
}


struct CheckInListView: View{
    let checkIns:[CheckIn]
    let onClearAll: ()->Void
    
    var body: some View{
        VStack{
            HStack{
                Text("check-in").font(.headline)
                Button("Clear all"){
                    onClearAll()
                }.disabled(checkIns.count == 0)
            }
            if checkIns.count == 0{
                Text("No check ins")
            }else {
                List(checkIns){
                    checkin in
                    VStack{
                        Text(checkin.timeStamp,style: .date)
                            .padding()
                        Text("Lat: \(String(checkin.latitude))")
                        Text("Long: \(String(checkin.longitude))")
                    }
                }
            }
        }
    }
    
}
struct FailedView: View{
    let message:String
    let onTryAgain: ()-> Void
    
    var body: some View{
        VStack{
            Text(message).fontWeight(.bold).foregroundColor(.red)
            
            Button("Try Again"){
                self.onTryAgain()
            }.buttonStyle(.borderedProminent)
        }
    }
}
struct LoadingView: View {
    var body: some View{
        VStack{
            ProgressView().padding()
            Text("Getting your location..")
        }
    }
}

#Preview {
    ContentView()
}
