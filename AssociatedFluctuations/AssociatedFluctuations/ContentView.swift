import SwiftUI

struct ContentView: View {
    @State var length: String = "300.0"
    @State var A1: String = "10.0"
    @State var A2: String = "15.0"
    @State var phi1: String = "15.0"
    @State var phi2: String = "15.0"
    
    @State var flag: Bool = true
    @ObservedObject var watch = StopWatch()
    
//    var modes: [String] = ["Common Mode Oscillation",
//                           "General Oscillation",
//                           "Oscillations In Antiphase"]
//
//    @State private var selectedIndexFormModes: Int = 0
    
    @State private var selectedMode = Mode.commonModeOscillation
    
    var body: some View{
        NavigationView{
            VStack{
                
                Form{
                    Section{
//                        Picker(selection: $selectedIndexFormModes, label: Text("Mode: ")){
//                            ForEach(0..<self.modes.count){ i in
//                                Text("\(self.modes[i])")
//                            }
//                        }
                        Picker(selection: $selectedMode, label: Text("Mode: ")){
                            Text("Common Mode Oscillation").tag(Mode.commonModeOscillation)
                            Text("General Oscillation").tag(Mode.generalOscillation)
                            Text("Oscillations In Antiphase").tag(Mode.oscillationsInAntiphase)
                        }
                    }
                    
//                    TextField("length:", text: $length)
//                    TextField("A1: ", text: $A1)
//                    TextField("A2: ", text: $A2)
//                    TextField("phi1: ", text: $phi1)
//                    TextField("phi2: ", text: $phi2)
                    
                    Section{
                        
//                        if selectedMode == Mode.commonModeOscillation {
//                            A1 = "15.0"
//                        }
//                        else if selectedMode == Mode.generalOscillation{
//                            A1 = "15.0"
//                        }
//                        else if selectedMode == Mode.oscillationsInAntiphase{
//                            A1 = "15.0"
//                        }
                        
                        NavigationLink(destination: AssociatedPendulumView(length: length, A1: A1, A2: A2, phi1: phi1, phi2: phi2, watch: watch)){
                            Text("MyFuckingModelForStupidPiceOfShitLikeMe")
                        }
                    }
                }
                .navigationBarTitle("JO_POCHKA")
            }
        }
    }
    
    enum Mode:String, CaseIterable, Identifiable {
        var id: String{
            self.rawValue
        }
        
        case commonModeOscillation
        case oscillationsInAntiphase
        case generalOscillation
    }
}

struct AssociatedPendulumView: View {
    @State var isStarted = false
    @ObservedObject var watch: StopWatch
    
    private var length: Double
    private var A1: Double
    private var A2: Double
    private var phi1: Double
    private var phi2: Double
    
    var model1: PendulumModel
    var model2: PendulumModel
    
    init(length: String, A1: String, A2: String, phi1: String, phi2: String, watch: StopWatch) {
        self.length = Double(length)!
        self.A1 = Double(A1)!
        self.A2 = Double(A2)!
        self.phi1 = Double(phi1)!
        self.phi2 = Double(phi2)!
        
        self.watch = watch
        
        model1 = PendulumModel(l: self.length, A1: self.A1, A2: self.A2, phi1: self.phi1, phi2: self.phi2, time: watch.seconds, flag: false)
        model2 = PendulumModel(l: self.length, A1: self.A1, A2: self.A2, phi1: self.phi1, phi2: self.phi2, time: watch.seconds, flag: true)
    }
    
    var body: some View {
        VStack{
            
            Text("\(model1.angle)")
            Text("\(model2.angle)")
            
            PendulumShape(angle1: model1.angle, angle2: model2.angle, length: length)
                .stroke(Color.black, lineWidth: 4)
            
            Spacer()
            
            Text(String(format: "%.1f", watch.seconds / 400))
                .frame(width: 200, height: 60)
                .background(Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                .onTapGesture{
                    if isStarted{
                        watch.stop()
                    }
                    else{
                        watch.start()
                    }
                    isStarted.toggle()
                }
        }
    }
}

struct PendulumShape: Shape {
    var angle1: Double
    var angle2: Double
    var length: Double
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(angle1, angle2)
        }
        set {
            angle1 = newValue.first
            angle2 = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()
        
        // Points for lines
        let startX1 = rect.midX + rect.midX / 2
        let startX2 = rect.midX / 2
        
        let endX1 = CGFloat(length * sin(angle1 / 180.0 * 3.14) + Double(startX1))
        let endY1 = CGFloat(length * cos(angle1 / 180.0 * 3.14))
        
        let endX2 = CGFloat(length * sin(angle2 / 180.0 * 3.14) + Double(startX2))
        let endY2 = CGFloat(length * cos(angle2 / 180.0 * 3.14))
        
        
        let startPoint1 = CGPoint(x: startX1, y: 0)
        let endPoint1 = CGPoint(x: endX1, y: endY1)
        
        let startPoint2 = CGPoint(x: startX2, y: 0)
        let endPoint2 = CGPoint(x: endX2, y: endY2)
        
        // Points for spring
        let springX1 = CGFloat( ((startX2 - endX2) / 2) + endX2 )
        let springY1 = CGFloat(endY2 / 2)
        
        let springX2 = CGFloat( ((startX1 - endX1) / 2) + endX1 )
        let springY2 = CGFloat(endY1 / 2)
        
        let springPoint1 = CGPoint(x: springX1, y: springY1)
        let springPoint2 = CGPoint(x: springX2, y: springY2)
        
        // Points for circle
        let circleRadius = CGFloat(20.0)
        
        let circleX1 = CGFloat(endX2)
        let circleY1 = CGFloat(endY2)
        
        let circleX2 = CGFloat(endX1)
        let circleY2 = CGFloat(endY1)
        
        let circlePoint1 = CGPoint(x: circleX1, y: circleY1)
        let circlePoint2 = CGPoint(x: circleX2, y: circleY2)
        
        // Draw lines
        p.move(to: startPoint1)
        p.addLine(to: endPoint1)
        
        p.move(to: startPoint2)
        p.addLine(to: endPoint2)
        
        // Draw spring between lines
        p.move(to: springPoint1)
        p.addLine(to: springPoint2)
        
        // Draw circle under lines
        p.move(to: endPoint2)
        p.addArc(center: circlePoint1, radius: circleRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
       
        
        p.move(to: endPoint1)
        p.addArc(center: circlePoint2, radius: circleRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        
        return p
    }
}
