//
//  LocationReadyView.swift
//  BasicLocation
//
//  Created by jeffrey lullen on 5/12/26.
//

import SwiftUI

struct LocationReadyView: View {
    let latText:String
    let longText:String
    let onRefresh: () -> Void
    let onSave: () -> Void
    
    var body: some View{
        VStack{
            VStack(spacing:5){
                Text("Longitude: "+longText)
                Text("Latitude: "+latText)
                
                HStack{
                    Button("Refresh"){
                        self.onRefresh()
                    }.buttonStyle(.bordered)
                    
                    Button("Save check-in"){
                        self.onSave()
                    }.buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

#Preview{
    LocationReadyView(
        latText:"22.22", longText:"33.33", onRefresh: {}, onSave:{}
    )
}
