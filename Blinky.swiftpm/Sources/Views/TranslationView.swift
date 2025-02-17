import SwiftUI

struct TranslationView: View {
    let morseCode: String
    let translatedText: String
    let screenWidth: CGFloat
    let isIPad: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            // 모스 부호 표시
            VStack(alignment: .leading) {
                Text("Morse Code:")
                    .font(isIPad ? .title : .title2)
                    .foregroundColor(.white)
                Text(morseCode.isEmpty ? "Waiting for blinks..." : morseCode)
                    .font(.system(isIPad ? .title3 : .body, design: .monospaced))
                    .foregroundColor(.teal)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
            
            // 변환된 텍스트 표시
            VStack(alignment: .leading) {
                Text("Translated Text:")
                    .font(isIPad ? .title : .title2)
                    .foregroundColor(.white)
                Text(translatedText.isEmpty ? "Translation will appear here" : translatedText)
                    .font(.system(isIPad ? .title3 : .body, design: .monospaced))
                    .foregroundColor(.teal)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.black.opacity(0.5))
            .cornerRadius(10)
        }
        .padding(.horizontal, screenWidth * 0.05)
        .frame(width: screenWidth)
    }
}