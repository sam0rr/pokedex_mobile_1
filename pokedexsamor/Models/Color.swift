import SwiftUI

extension Color {
    func lighter(by percentage: Double) -> Color {
        guard let uiColor = UIColor(self).lighter(by: percentage) else { return self }
        return Color(uiColor)
    }
}

extension UIColor {
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
