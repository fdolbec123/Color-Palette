//
//  Color_PaletteApp.swift
//  Color Palette
//
//  Created by Francis Dolbec on 2022-01-03.
//


// TODO LIST:
// - CLEANING!!!
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
//                print("Test retreving first element of array:")
//                print(colors[0])
                
            } else if let error = error{
                print(error)
            }
            //print("Ceci  est un  test pour un array:")
            //print()
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
            //print(attributeDict["nom"]! as String)
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
            //print(rgbValue)
            //print(hexValue)
            //print(behrCodeValue)
            //print(betonelCodeValue)
            //print(sicoCodeValue)
            let couleurInfos = paletteDeCouleur(rgbValue: rgbValue, hexValue: hexValue, behrCode: behrCodeValue, betonelCode: betonelCodeValue, sicoCode: sicoCodeValue)
            //print(couleurValue!)
            let palette_de_test =  [rgbValue, hexValue, behrCodeValue, betonelCodeValue, sicoCodeValue]
            //let test_palette_avec_nom_inclus = [couleurValue!: palette_de_test]
//            print(palette_de_test)
//            print("test")
//            print(test_palette_avec_nom_inclus)
            test_palette.append(palette_de_test)
//            print("Une fois append")
//            print(test_palette)
            //print(couleurInfos)
            //print("In parser")
            couleursInfos.append(couleurInfos)
            palette_avec_nom[couleurValue!] = palette_de_test
            //print("Ceci est la palette avec leur nom respectif: ", palette_avec_nom)
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
//        if inCouleur{
//            print(couleurValue!)
//        }
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
        //let dataAsString = String(data: data, encoding: .utf8)!
        //print(dataAsString)
        let parser = XMLParser(data: data)
        let paletteBuilder = paletteDeCouleurBuilder()
        parser.delegate = paletteBuilder
        parser.parse()
        //let colorAssembled = paletteBuilder.couleursInfos
        //let colorTest = paletteBuilder.test_palette
        let palette_with_names = paletteBuilder.palette_avec_nom
        //print(colorAssembled)
        //completion(colorAssembled, nil)
//        completion(colorTest, nil)
        completion(palette_with_names, nil)
    }
    dataTask.resume()
}
