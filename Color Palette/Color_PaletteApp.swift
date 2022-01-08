//
//  Color_PaletteApp.swift
//  Color Palette
//
//  Created by Francis Dolbec on 2022-01-03.
//

import SwiftUI

@main
struct Color_PaletteApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool{
        
        return true
    }
}
