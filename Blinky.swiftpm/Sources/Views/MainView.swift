import SwiftUI

struct MainView: View {
    @StateObject private var cameraViewController = CameraViewController()
    @State private var morseCode: String = ""
    @State private var translatedText: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            let isIPad = UIDevice.current.userInterfaceIdiom == .pad
            let faceGuideWidth = screenWidth * (isIPad ? 0.3 : 0.7)
            let faceGuideHeight = faceGuideWidth * 1.15
            
            ZStack {
                CameraView(cameraViewController: cameraViewController)
                    .ignoresSafeArea()
                
                // 얼굴 실루엣 가이드
                FaceShape()
                    .fill(Color.clear)
                    .frame(width: faceGuideWidth, height: faceGuideHeight)
                    .overlay(
                        FaceShape()
                            .stroke(Color.green.opacity(0.6), lineWidth: 8)
                    )
                    .position(
                        x: screenWidth / 2,
                        y: screenHeight * 0.4
                    )
                
                TranslationView(
                    morseCode: morseCode,
                    translatedText: translatedText,
                    screenWidth: screenWidth,
                    isIPad: isIPad
                )
                .position(
                    x: screenWidth / 2,
                    y: screenHeight * (isIPad ? 0.8 : 0.85)
                )
            }
        }
    }
}

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

#Preview {
    MainView()
}
