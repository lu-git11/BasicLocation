//
//  PermissionView.swift
//  BasicLocation
//
//  Created by jeffrey lullen on 5/12/26.
//

import SwiftUI

struct PermissionView: View{
    
    let onEnable: () -> Void
    
    var body: some View{
        VStack(spacing:12){
            Text("We need access tot he location to save check-ins")
            Button("Enable location"){
                self.onEnable()
            }.buttonStyle(.borderedProminent)
        }
    }
}

#Preview{
    PermissionView(onEnable: {})
}
