import  SwiftUI

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
        p.move(to: CGPoint(x: endX2 + circleRadius, y: endY2))
        p.addArc(center: circlePoint1, radius: circleRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
       
        
        p.move(to: CGPoint(x: endX1 + circleRadius, y: endY1))
        p.addArc(center: circlePoint2, radius: circleRadius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        
        return p
    }
}
