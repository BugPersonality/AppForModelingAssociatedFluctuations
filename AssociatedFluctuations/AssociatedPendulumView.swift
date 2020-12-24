import SwiftUI

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
