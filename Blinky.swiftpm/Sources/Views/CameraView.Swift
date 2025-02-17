import SwiftUI

struct CameraView: UIViewRepresentable {
    let cameraViewController: CameraViewController
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        let previewLayer = cameraViewController.getPreviewLayer()
        previewLayer.frame = view.frame
        view.layer.addSublayer(previewLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}