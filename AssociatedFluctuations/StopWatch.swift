import Foundation

class StopWatch: ObservableObject {
    @Published var seconds = 0.0
    @Published var mode: StopWatchMode = .Stoped
    
    var timer = Timer()
    
    func start(){
        mode = .Running
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.seconds += 40
        }
    }
    
    func stop(){
        timer.invalidate()
        seconds = 0
        mode = .Stoped
    }
    
    enum StopWatchMode {
        case Running
        case Stoped
    }
}
