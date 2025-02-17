import SwiftUI

struct FaceShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let faceRect = CGRect(
            x: rect.minX - (rect.width * 0.25),
            y: rect.minY - (rect.height * 0.25),
            width: rect.width * 1.5,
            height: rect.height * 1.5
        )
        path.addEllipse(in: faceRect)
        return path
    }
}