//
//  LocationViewModel.swift
//  BasicLocation
//
//  Created by jeffrey lullen on 5/12/26.
//

import Foundation
import CoreLocation
import Combine

enum LocationViewState{
    case needsPermission
    case loading
    case ready
    case denied
    case failed
}

class LocationViewModel:ObservableObject{
    @Published var viewState:LocationViewState = .needsPermission
    @Published var latitude: String = "--"
    @Published var longitude:String = "--"
    
    @Published var errorMessage:String = ""
    @Published var checkIns:[CheckIn] = []
    
    private var locationService:LocationService = LocationService()
    private var cancellables:Set<AnyCancellable> = Set<AnyCancellable>()
    
    init() {
        self.locationService.objectWillChange.sink{
            [weak self] in
            DispatchQueue.main.async {
                if self != nil {
                    self!.updateUIfromManager()
                }
            }
        }
        .store(in: &self.cancellables)
        self.updateUIfromManager()
    }
    
    func updateUIfromManager(){
        if self.locationService.isLoading == true{
            self.viewState = .loading
            return
        }
        
        let status:CLAuthorizationStatus = self.locationService.authStatus
        
        if status == .notDetermined{
            self.viewState = .needsPermission
            return
        }
        
        if status == .denied || status == .restricted {
            self.errorMessage = "Location access off"
            self.viewState = .denied
        }
        if self.locationService.location != nil{
            let coordinate:CLLocationCoordinate2D = self.locationService.location!
            self.latitude = String(format: "%.5f", coordinate.latitude)
            self.longitude = String(format: "%.5f", coordinate.longitude)
            
            self.viewState = .ready
            return
        }
        
        self.errorMessage = "Could not read"
        self.viewState = .failed
    }
    
    func saveCheckIn(){
        if self.locationService.location == nil {
            return
        }
        
        let coordinate:CLLocationCoordinate2D = self.locationService.location!
        
        let newCoord:CheckIn = CheckIn(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            timeStamp: Date()
        )
        self.checkIns.insert(newCoord, at: 0)
    }
    
    func clearAll(){
        self.checkIns.removeAll()
    }
    
    func enableLocation(){
        self.errorMessage = ""
        self.viewState = .loading
        self.locationService.requestPermissionAndLocation()
    }
    func refreshButton(){
        self.errorMessage = ""
        self.viewState = .loading
        self.locationService.requestPermissionAndLocation()
    }
}
