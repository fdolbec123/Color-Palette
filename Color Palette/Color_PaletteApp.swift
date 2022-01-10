//
//  Color_PaletteApp.swift
//  Color Palette
//
//  Created by Francis Dolbec on 2022-01-03.
//

import SwiftUI
import Foundation

@main
struct Color_PaletteApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        print("Test")
        fetchXMLDataFile()
    }
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

func fetchXMLDataFile(){
    let session = URLSession.shared
    print("Before URL")
    let url = URL(fileURLWithPath: "/Users/francisdolbec/dev/Color Palette Data/couleurs_data.xml")
    print(url)
    //Change URL depending of final destination of file!!!
    let dataTask = session.dataTask(with: url) { (data, response, error) in
        guard let data = data, error == nil else {
            print("Oups!")
            print(error ?? "Response inattendu")
            return
        }
        let dataAsString = String(data: data, encoding: .utf8)!
        print(dataAsString)
    }
    dataTask.resume()
}
