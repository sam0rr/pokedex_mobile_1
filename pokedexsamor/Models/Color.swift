import SwiftUI

extension Color {
    /// Initialize a `Color` from a HEX string
    init(hex: String) {
        var hexSanitized = hex
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst() // Remove the "#" prefix
        }

        let scanner = Scanner(string: hexSanitized)
        var rgbValue: UInt64 = 0
        if scanner.scanHexInt64(&rgbValue) {
            let red = Double((rgbValue >> 16) & 0xFF) / 255.0
            let green = Double((rgbValue >> 8) & 0xFF) / 255.0
            let blue = Double(rgbValue & 0xFF) / 255.0
            self.init(red: red, green: green, blue: blue)
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }

    /// Returns a lighter version of the color
    func lighter(by percentage: Double) -> Color {
        guard let uiColor = UIColor(self).lighter(by: percentage) else { return self }
        return Color(uiColor)
    }
}

extension UIColor {
    /// Returns a lighter version of the color.
    func lighter(by percentage: Double) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0

        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }

        return UIColor(
            red: min(red + CGFloat(percentage), 1.0),
            green: min(green + CGFloat(percentage), 1.0),
            blue: min(blue + CGFloat(percentage), 1.0),
            alpha: alpha
        )
    }
}
