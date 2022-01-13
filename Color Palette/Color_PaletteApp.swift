//
//  Color_PaletteApp.swift
//  Color Palette
//
//  Created by Francis Dolbec on 2022-01-03.
//


// TODO LIST:
// - FIND A WAY TO PASS THE DICTIONARY TO THE INTERFACE
// - OPTIONNAL: ADD "NUANCE" INFOS



import SwiftUI
import Foundation

@main
//==================STRUCT=======================
struct Color_PaletteApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init(){
        fetchXMLDataFile() {(colorAssembled, error) in
            if let colors = colorAssembled{
                print("Couleurs assemblées")
                print(colors)
            } else if let error = error{
                print(error)
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
}
struct paletteDeCouleur{
    //let nuance: String
    //let couleur: String
    let rgbValue: String //Check back to see if we change to rgb value at parsing or after
    let hexValue: String //Check back to see if we change to hex value at parsing or after
    let behrCode: String
    let betonelCode: String
    let sicoCode: String
}
//===============CLASS=========================
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool{
        
        return true
    }
}
class paletteDeCouleurBuilder: NSObject, XMLParserDelegate{
    var inNuance = false
    var inCouleur = false
    var inRGB = false
    var inHEX = false
    var inBehr = false
    var inBetonel = false
    var inSico = false
    var nuanceValue: String?
    var couleurValue: String?
    var rgbValue: String?
    var hexValue: String?
    var behrCodeValue: String?
    var betonelCodeValue: String?
    var sicoCodeValue: String?
    var couleursInfos = [paletteDeCouleur]()
    var test_palette: Array<Any> = Array()
    var palette_avec_nom: Dictionary<String, Array<Any>> = [:]
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        switch elementName{
        case "nuance":
            inNuance = true
        case "couleur":
            inCouleur = true
            couleurValue = ""
            couleurValue = attributeDict["nom"]! as String
        case "rgb":
            inRGB = true
            rgbValue = ""
        case "hex":
            inHEX = true
            hexValue = ""
        case "behr":
            inBehr = true
            behrCodeValue = ""
        case "betonel":
            inBetonel = true
            betonelCodeValue = ""
        case "sico":
            inSico = true
            sicoCodeValue = ""
        default:
            break
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "nuance":
            inNuance = false
        case "couleur":
            inCouleur = false
            guard
                let rgbValue = rgbValue,
                let hexValue = hexValue,
                let behrCodeValue = behrCodeValue,
                let betonelCodeValue = betonelCodeValue,
                let sicoCodeValue = sicoCodeValue
            else {break}
            let couleurInfos = paletteDeCouleur(rgbValue: rgbValue, hexValue: hexValue, behrCode: behrCodeValue, betonelCode: betonelCodeValue, sicoCode: sicoCodeValue)
            let palette_de_test =  [rgbValue, hexValue, behrCodeValue, betonelCodeValue, sicoCodeValue]
            test_palette.append(palette_de_test)
            couleursInfos.append(couleurInfos)
            palette_avec_nom[couleurValue!] = palette_de_test
        case "rgb":
            inRGB = false
        case "hex":
            inHEX = false
        case "behr":
            inBehr = false
        case "betonel":
            inBetonel = false
        case "sico":
            inSico = false
        default:
            break
        }
    }
    func parser(_ parser:XMLParser, foundCharacters donnee:String){
        if inRGB{
            rgbValue?.append(donnee)
        }
        if inHEX{
            hexValue?.append(donnee)
        }
        if inBehr{
            behrCodeValue?.append(donnee)
        }
        if inBetonel{
            betonelCodeValue?.append(donnee)
        }
        if inSico{
            sicoCodeValue?.append(donnee)
        }
    }
    func parserDidStartDocument(_ parser: XMLParser) {
        inNuance = false
        inCouleur = false
        inRGB = false
        inHEX = false
        inBehr = false
        inBetonel = false
        inSico = false
        nuanceValue = nil
        couleurValue = nil
        rgbValue = nil
        hexValue = nil
        behrCodeValue = nil
        betonelCodeValue = nil
        sicoCodeValue = nil
        couleursInfos = [paletteDeCouleur]() // to check!!!!!!!!!
        }
}
//================FUNCTIONS=====================
func fetchXMLDataFile(completion: @escaping (Dictionary<String, Array<Any>>?, Error?) //[paletteDeCouleur]  à la place de Array
                      -> Void){
    let session = URLSession.shared
    print("Before URL")
    let url = URL(fileURLWithPath: "/Users/francisdolbec/dev/Color Palette Data/couleurs_data.xml")
    print(url)
    //Change URL depending of final destination of file!!!
    let dataTask = session.dataTask(with: url) { (data, response, error) in
        guard let data = data, error == nil else {
            completion(nil, error)
            print("Oups!")
            print(error ?? "Response inattendu")
            return
        }
        let parser = XMLParser(data: data)
        let paletteBuilder = paletteDeCouleurBuilder()
        parser.delegate = paletteBuilder
        parser.parse()
        let palette_with_names = paletteBuilder.palette_avec_nom
        completion(palette_with_names, nil)
    }
    dataTask.resume()
}
