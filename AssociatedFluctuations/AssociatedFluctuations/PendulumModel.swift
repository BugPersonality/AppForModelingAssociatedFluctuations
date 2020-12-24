import Foundation

struct PendulumModel {    
    private let alpha = 30.0
    private let g = 9.87
    private let k = 100.0
    private let l1 = 250.0
    private let m = 10000.0
    
    private let l: Double
    private let A1: Double
    private let A2: Double
    private let phi1: Double
    private let phi2: Double
    private let flag: Bool
    
    private let omega1: Double
    private let omega2 : Double
    private let constConnect: Double
    
    private(set) var angle: Double
    
    var time: Double{
        didSet{
            if flag{
                angle = 0.5 * (A1 * cos((omega1 * time + phi1) / 180 * 3.14) + A2 * cos((omega2 * time + phi2) / 180 * 3.14))
            }
            else{
                angle = 0.5 * (A1 * cos((omega1 * time + phi1) / 180 * 3.14) - A2 * cos((omega2 * time + phi2) / 180 * 3.14))
            }
        }
    }
    
    init(l: Double, A1: Double, A2: Double, phi1: Double, phi2: Double, time: Double, flag: Bool) {
        self.l = l
        self.A1 = A1
        self.A2 = A2
        self.phi1 = phi1
        self.phi2 = phi2
        self.flag = flag
        self.time = time
        
        constConnect = sqrt((k * l1 * l1) / (m * l * l))
        omega1 = sqrt(1 / g)
        omega2 = sqrt(omega1 * omega1 + 2 * constConnect * constConnect)
        
        if flag{
            angle = 0.5 * (A1 * cos((omega1 * time + phi1) / 180 * 3.14) + A2 * cos((omega2 * time + phi2) / 180 * 3.14))
        }
        else{
            angle = 0.5 * (A1 * cos((omega1 * time + phi1) / 180 * 3.14) - A2 * cos((omega2 * time + phi2) / 180 * 3.14))
        }
    }
}
