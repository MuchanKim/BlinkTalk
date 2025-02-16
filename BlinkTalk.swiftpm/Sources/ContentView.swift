import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("BlinkTalk")
                .font(.system(size: 40, weight: .bold))
                .padding(.top, 20)
            
            CameraView()
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .cornerRadius(25)
                .padding(.horizontal, 40)
                .shadow(radius: 10)
            
            Spacer()
            
            // 추후 모스 부호 변환 결과가 표시될 영역
            Text("Translated text will appear here")
                .font(.system(size: 24))
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal, 40)
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    ContentView()
}