import SwiftUI

struct QRCodeScannerView: UIViewControllerRepresentable {
    var completion: ([String]) -> Void
    @Binding var isScannerActive: Bool

    func makeUIViewController(context: Context) -> QRCodeScannerViewController {
        let viewController = QRCodeScannerViewController()
        viewController.delegate = context.coordinator
        viewController.onClose = {
            isScannerActive = false
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: QRCodeScannerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }

    class Coordinator: NSObject, QRCodeScannerViewControllerDelegate {
        let completion: ([String]) -> Void
        private var scannedCodes = [String]()

        init(completion: @escaping ([String]) -> Void) {
            self.completion = completion
        }

        func didFindCode(_ code: String) {
            if !scannedCodes.contains(code) {
                scannedCodes.append(code)
                completion(scannedCodes)
            }
        }

        func didFail(with error: QRCodeScannerViewController.QRCodeScannerError) {
            print("Error: \(error)")
        }
    }
}
