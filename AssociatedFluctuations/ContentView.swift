import SwiftUI

struct ContentView: View {
    @State var length: String = "300.0"
    @State var A1: String = "10.0"
    @State var A2: String = "15.0"
    @State var phi1: String = "15.0"
    @State var phi2: String = "15.0"
    
    @State var flag: Bool = true
    @State var selectedMode = Mode.commonModeOscillation
    
    @ObservedObject var watch = StopWatch()
    
    var body: some View{
        NavigationView{
            VStack{
                Form{
                    Section{
                        Picker(selection: $selectedMode, label: Text("Mode: ")){
                            Text("Common Mode Oscillation").tag(Mode.commonModeOscillation)
                            Text("General Oscillation").tag(Mode.generalOscillation)
                            Text("Oscillations In Antiphase").tag(Mode.oscillationsInAntiphase)
                        }
                        
                        Text("\(selectedMode.rawValue)")
                    }
                    
                    Section{
                        let a1 = String(selectedMode.rawValue.split(separator: " ")[0])
                        let a2 = String(selectedMode.rawValue.split(separator: " ")[1])
                        
                        NavigationLink(destination: AssociatedPendulumView(length: length, A1: a1, A2: a2, phi1: phi1, phi2: phi2, watch: watch)){
                            Text("MyFuckingModelForStupidPiceOfShitLikeMe")
                        }
                    }
                }
                .navigationBarTitle("JO_POCHKA")
            }
        }
    }
    
    enum Mode: String, CaseIterable, Identifiable {
        case commonModeOscillation = "15.0 0.0"
        case oscillationsInAntiphase = "0.0 15.0"
        case generalOscillation = "15.0 10.0"
        
        var id: String{
            self.rawValue
        }
    }
}
