import SwiftUI

struct QRCodeScannerView: UIViewControllerRepresentable {
    var completion: (Result<String, QRCodeScannerViewController.QRCodeScannerError>) -> Void
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
        let completion: (Result<String, QRCodeScannerViewController.QRCodeScannerError>) -> Void

        init(completion: @escaping (Result<String, QRCodeScannerViewController.QRCodeScannerError>) -> Void) {
            self.completion = completion
        }

        func didFindCode(_ code: String) {
            completion(.success(code))
        }

        func didFail(with error: QRCodeScannerViewController.QRCodeScannerError) {
            completion(.failure(error))
        }
    }
}
