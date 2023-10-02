import Foundation
import UIKit

enum WDFont: String {
    case Black = "NotoSansKR-Black"
    case Bold = "NotoSansKR-Bold"
    case Light = "NotoSansKR-Light"
    case Medium = "NotoSansKR-Medium"
    case Regular = "NotoSansKR-Regular"
    case Thin = "NotoSansKR-Thin"
    case GmarketBold = "GmarketSansTTFBold"
    case GmarketLight = "GmarketSansTTFLight"
    case GmarketMedium = "GmarketSansTTFMedium"
    
    func of(size: CGFloat) -> UIFont {
        if let font = UIFont(name: self.rawValue, size: size) {
            return font
        } else {
            // 폰트를 찾을 수 없을 때 기본 폰트를 반환하거나 다른 대체 폰트를 설정할 수 있습니다.
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    // 다른 폰트 스타일에 대한 정적 메서드 추가
    static func black(size: CGFloat) -> UIFont {
        return WDFont.Black.of(size: size)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return WDFont.Bold.of(size: size)
    }
    
    static func light(size: CGFloat) -> UIFont {
        return WDFont.Light.of(size: size)
    }
    
    static func medium(size: CGFloat) -> UIFont {
        return WDFont.Medium.of(size: size)
    }
    
    static func regular(size: CGFloat) -> UIFont {
        return WDFont.Regular.of(size: size)
    }
    
    static func thin(size: CGFloat) -> UIFont {
        return WDFont.Thin.of(size: size)
    }
}
