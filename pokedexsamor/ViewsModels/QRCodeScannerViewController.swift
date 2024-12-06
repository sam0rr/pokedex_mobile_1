import UIKit
import AVFoundation

class QRCodeScannerViewController: UIViewController {
    enum QRCodeScannerError: Error {
        case badInput
        case badOutput
        case invalidCode
    }

    weak var delegate: QRCodeScannerViewControllerDelegate?
    var onClose: (() -> Void)?
    private var captureSession: AVCaptureSession?
    private var scannedCodes = Set<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupCloseButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let captureSession = captureSession, !captureSession.isRunning {
            captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let captureSession = captureSession, captureSession.isRunning {
            captureSession.stopRunning()
        }
    }

    private func setupCamera() {
        let session = AVCaptureSession()
        self.captureSession = session

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            delegate?.didFail(with: .badInput)
            return
        }

        guard let videoInput = try? AVCaptureDeviceInput(device: videoCaptureDevice) else {
            delegate?.didFail(with: .badInput)
            return
        }

        if session.canAddInput(videoInput) {
            session.addInput(videoInput)
        } else {
            delegate?.didFail(with: .badInput)
            return
        }

        let metadataOutput = AVCaptureMetadataOutput()
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            delegate?.didFail(with: .badOutput)
            return
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        session.startRunning()
    }

    private func setupCloseButton() {
        let closeButton = UIButton(type: .system)

        closeButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        closeButton.tintColor = .systemRed
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func closeTapped() {
        onClose?()
        dismiss(animated: true, completion: nil)
    }

    private func validateCode(_ code: String) -> Bool {
        if let _ = Int(code), (1...264).contains(Int(code)!) {
            return true
        } else if !code.isEmpty && code.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
            return true
        }
        return false
    }
}

protocol QRCodeScannerViewControllerDelegate: AnyObject {
    func didFindCode(_ code: String)
    func didFail(with error: QRCodeScannerViewController.QRCodeScannerError)
}

extension QRCodeScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let metadataObject = metadataObjects.first,
              let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
              let stringValue = readableObject.stringValue else { return }

        if scannedCodes.contains(stringValue) {
            return
        }

        if validateCode(stringValue) {
            scannedCodes.insert(stringValue)
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            delegate?.didFindCode(stringValue)
        } else {
            delegate?.didFail(with: .invalidCode)
        }
    }
}
