//
//  ContentView.swift
//  Color Palette
//
//  Created by Francis Dolbec on 2022-01-03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            HStack{
                TextField("Recherche...", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .frame(minWidth: 350)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 10))
                Button("Chercher") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                    .frame(minWidth: 72)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 20))
            }
            .padding(EdgeInsets(top: 30, leading: 10, bottom: 5, trailing: 10))
            
            HStack{
                VStack{
                    Text("Color Palette")
                        .padding()
                    Text("Color Palette")
                        .padding()
                    Text("Color Palette")
                        .padding()
                    Text("Color Palette")
                        .padding()
                    Text("Color Palette")
                        .padding()
                }
                Text("Plus d'infos")
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 1920.0, height: 1080.0)
    }
}
