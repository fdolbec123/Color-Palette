//
//  ContentView.swift
//  Color Palette
//
//  Created by Francis Dolbec on 2022-01-03.
//

import SwiftUI

struct ContentView: View {
    @State var valeur_de_recherche = ""
    var body: some View {
        VStack{
            HStack{
                TextField("Recherche...", text: $valeur_de_recherche)
                    .frame(minWidth: 350)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 10))
                Button("Chercher") {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                }
                    .frame(minWidth: 72)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 20))
            }
            .padding(EdgeInsets(top: 30, leading: 10, bottom: 5, trailing: 10))
            Divider()
            HStack{
                VStack{
                    ScrollView {
                        LazyVGrid(columns: [.init(), .init(), .init(), .init(), .init()]) {
                            ForEach(0..<50) { _ in
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                    .padding(3)
                            }
                        }
                            .frame(minWidth: 520)
                            .padding()
                    }
                }
                    .frame(maxHeight: 1000)
                    .padding()
                Divider()
                //Spacer()
                VStack{
                    GroupBox(label: Label("Informations", systemImage: "info.circle.fill")) {
                        HStack{
                            VStack(alignment: .center, spacing: nil, content:{
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(width: 100, height: 100)
                                    .padding()
                                Text("Nom: Robe de princesse")
                                    .frame(minWidth: 175)
                                    .padding()
                            })
                            //Spacer()
                            VStack(alignment: .leading, spacing: nil, content:{
                                Text("Code hexadecimal: #FFFFFF")
                                    .frame(minWidth: 175)
                                    .padding()
                                Text("Behr: ")
                                    .padding()
                                Text("Betonel: ")
                                    .padding()
                                Text("Sico: ")
                                    .padding()
                            })
                        }
                    }.padding()
                    Spacer()
                }
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
