import Vision
import UIKit

class BlinkDetectionController {
    // 눈 감김 상태 추적
    private var isEyesClosed = false
    private var lastBlinkTime: Date?
    private var blinkStartTime: Date?
    
    // 설정값
    private let earThreshold: CGFloat = 0.15  // EAR 임계값 조정
    private let shortBlinkMin: TimeInterval = 0.05  // 짧은 깜빡임 최소 시간
    private let shortBlinkMax: TimeInterval = 0.3  // 짧은 깜빡임 최대 시간
    private let longBlinkMin: TimeInterval = 0.3   // 긴 깜빡임 최소 시간
    private let longBlinkMax: TimeInterval = 0.8   // 긴 깜빡임 최대 시간
    
    // 고개 끄덕임 관련 속성 추가
    private enum NodPhase {
        case neutral, downward, upward
    }
    private var nodPhase = NodPhase.neutral
    private var nodCount = 0
    private var lastNodTime: Date?
    private let nodResetInterval: TimeInterval = 1.0
    
    // 눈 깜빡임 감지 상태
    private var isBlinkDetectionEnabled = false {
        didSet {
            // 상태가 변경될 때마다 현재 상태 출력
            if isBlinkDetectionEnabled {
                print("🎯 Blink detection ENABLED")
                // 상태 변경 시 변수들 초기화
                isEyesClosed = false
                lastBlinkTime = nil
                blinkStartTime = nil
            } else {
                print("⭕️ Blink detection DISABLED")
            }
        }
    }
    
    // Vision 요청 핸들러
    private var faceDetectionRequest: VNDetectFaceRectanglesRequest?
    private var faceLandmarksRequest: VNDetectFaceLandmarksRequest?
    
    // 프레임 간격 측정
    private var lastFrameTime: Date?
    
    // 연속 감지 방지를 위한 쿨다운
    private let blinkCooldown: TimeInterval = 0.1
    private var lastBlinkEndTime: Date?
    
    init() {
        setupVision()
    }
    
    private func setupVision() {
        faceDetectionRequest = VNDetectFaceRectanglesRequest()
        faceLandmarksRequest = VNDetectFaceLandmarksRequest()
    }
    
    func detectBlink(in pixelBuffer: CVPixelBuffer) {
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        
        do {
            if let faceRequest = faceDetectionRequest {
                try handler.perform([faceRequest])
                
                if let faces = faceRequest.results, !faces.isEmpty {
                    if let landmarksRequest = faceLandmarksRequest {
                        try handler.perform([landmarksRequest])
                        
                        if let face = faces.first {
                            detectNod(face: face)
                        }
                        
                        if isBlinkDetectionEnabled {
                            analyzeEyeState(from: landmarksRequest)
                        }
                    }
                }
            }
        } catch {
            print("Vision detection error: \(error)")
        }
    }
    
    private func analyzeEyeState(from request: VNDetectFaceLandmarksRequest) {
        guard isBlinkDetectionEnabled,
              let face = request.results?.first as? VNFaceObservation,
              let landmarks = face.landmarks else {
            return
        }
        
        if let leftEye = landmarks.leftEye,
           let rightEye = landmarks.rightEye {
            
            let leftEyeAspectRatio = calculateEyeAspectRatio(eye: leftEye)
            let rightEyeAspectRatio = calculateEyeAspectRatio(eye: rightEye)
            let averageEAR = (leftEyeAspectRatio + rightEyeAspectRatio) / 2.0
            
            let now = Date()
            let eyesClosed = averageEAR < earThreshold
            
            if eyesClosed != isEyesClosed {
                if eyesClosed {
                    // 이전 깜빡임과의 간격 체크
                    if let lastEnd = lastBlinkEndTime,
                       now.timeIntervalSince(lastEnd) < blinkCooldown {
                        return  // 쿨다운 시간 내에는 새로운 깜빡임 무시
                    }
                    blinkStartTime = now
                } else if let startTime = blinkStartTime {
                    let blinkDuration = now.timeIntervalSince(startTime)
                    lastBlinkEndTime = now  // 깜빡임 종료 시간 기록
                    
                    // 깜빡임 종류 판단
                    if blinkDuration >= shortBlinkMin && blinkDuration <= shortBlinkMax {
                        print("👁 Short blink detected! (Duration: \(String(format: "%.2f", blinkDuration))s)")
                        lastBlinkTime = now
                    } 
                    else if blinkDuration >= longBlinkMin && blinkDuration <= longBlinkMax {
                        print("👁 Long blink detected! (Duration: \(String(format: "%.2f", blinkDuration))s)")
                        lastBlinkTime = now
                    }
                    // 너무 짧거나 긴 깜빡임은 무시
                    else if blinkDuration < shortBlinkMin {
                        print("⚠️ Blink too short (Duration: \(String(format: "%.2f", blinkDuration))s)")
                    }
                    else if blinkDuration > longBlinkMax {
                        print("⚠️ Blink too long (Duration: \(String(format: "%.2f", blinkDuration))s)")
                    }
                    
                    blinkStartTime = nil
                }
                isEyesClosed = eyesClosed
            }
        }
    }
    
    private func calculateEyeAspectRatio(eye: VNFaceLandmarkRegion2D) -> CGFloat {
        let points = eye.normalizedPoints
        
        guard points.count >= 6 else { return 0.0 }
        
        let p1 = points[0]
        let p2 = points[1]
        let p3 = points[2]
        let p4 = points[3]
        let p5 = points[4]
        let p6 = points[5]
        
        let height1 = distance(from: p2, to: p6)
        let height2 = distance(from: p3, to: p5)
        let width = distance(from: p1, to: p4)
        
        return (height1 + height2) / (2.0 * width)
    }
    
    private func distance(from p1: CGPoint, to p2: CGPoint) -> CGFloat {
        let dx = p2.x - p1.x
        let dy = p2.y - p1.y
        return sqrt(dx * dx + dy * dy)
    }
    
    private func detectNod(face: VNFaceObservation) {
        let pitch = face.pitch?.doubleValue ?? 0
        let now = Date()
        
        switch nodPhase {
        case .neutral:
            if pitch < -0.3 {
                nodPhase = .downward
                print("⬇️ Head down")
            }
            
        case .downward:
            if pitch > 0.3 {
                nodPhase = .upward
                print("⬆️ Head up")
                
                if let lastNod = lastNodTime,
                   now.timeIntervalSince(lastNod) > nodResetInterval {
                    nodCount = 0
                }
            }
            
        case .upward:
            if abs(pitch) < 0.1 {
                nodPhase = .neutral
                nodCount += 1
                lastNodTime = now
                print("➡️ Back to neutral (Nod count: \(nodCount))")
                
                if nodCount == 2 {
                    isBlinkDetectionEnabled.toggle()
                    nodCount = 0
                }
            }
        }
    }
}