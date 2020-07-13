//
//  SpendtrackApp.swift
//  Shared
//
//  Created by Mugurel Moscaliuc on 10/07/2020.
//

import SwiftUI

@main
struct SpendtrackApp: App {
    
    
    @StateObject var spendingVM = SpendingVM()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(spendingVM)
        }
    }
}

struct SpendtrackApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
