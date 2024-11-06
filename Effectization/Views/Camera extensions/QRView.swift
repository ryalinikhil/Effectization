//
//  QRView.swift
//  Effectization
//
//  Created by Sameer Nikhil on 23/10/24.
//

/*
#Preview {
    ContentView67(showTabBar: $showTabBar)
}
*/

import SwiftUI
import AVFoundation
import PhotosUI

struct ContentView67: View {
    @State private var scannedCode: String? = nil
    @State private var isGalleryPickerPresented = false
    @State private var isMyQRPresented = false
    @Binding var showTabBar: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                // Top bar with Scan Code and My QR
                HStack {
                    Button(action: {
                        // Action for "Scan Code" button (can reset scanner)
                        self.scannedCode = nil
                    }) {
                        VStack(alignment: .leading, spacing: 10){
                            Text("Scan Code")
                                .font(.system(size: 20))
                                .font(.headline)
                                .bold()
                                .foregroundColor(.black)
                            
                            Text("Align the QR code to scan")
                                .font(.system(size: 17))
                                .font(.title3)
                                .foregroundColor(.gray)
                                .padding(.bottom)
                        }
                        .padding(.top, 90)

                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Action for "My QR" button (present a My QR view or generate user's QR)
                        dismiss()
                    }) {
                        Text("Back")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding()
                            .padding(.top, 70)

                    }
                }
                .padding(.horizontal)
                .background(Color.white) // Background color (use any color you prefer)
                .cornerRadius(30) // Corner radius of 20 to round the rectangle
                .shadow(radius: 5)
                

                
                QRCodeScannerView { code in
                    self.scannedCode = code
                    
                    // Open the scanned URL after a delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        openURL(code)
                    }
                }
                .padding(.top)
                .edgesIgnoringSafeArea(.all)
                
                
                if let code = scannedCode {
                    // Display the scanned code as an overlay
                    VStack {
                        Text("Scanned QR Code:")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(code)
                            .font(.body)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .cornerRadius(10)
                            .padding()
                        
                        Button(action: {
                            self.scannedCode = nil
                        }) {
                            Text("Scan Another Code")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
                }
                HStack{
                    // Import from Gallery Button
                    Button(action: {
                        isGalleryPickerPresented = true
                    }) {
                       // Text("Import from Gallery")
                        //    .foregroundColor(.black)
                        Image(systemName: "photo")
                            .padding()
                       //     .background(Color.gray)
                         //   .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding()
            }
            .ignoresSafeArea()
            .sheet(isPresented: $isGalleryPickerPresented) {
                ImagePicker { selectedImage in
                    if let image = selectedImage, let qrCode = detectQRCode(from: image) {
                        self.scannedCode = qrCode
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isMyQRPresented, onDismiss: {
                    showTabBar = true // Show tab bar when MyQRView is dismissed
                }) {
                    MyQRView()
                }
        
        .onAppear {
            showTabBar = false // Show the tab bar when this view appears
        }
        .navigationBarBackButtonHidden(false)
        /*.navigationBarItems(trailing:
                       Button(action: {
                           isMyQRPresented = true // Present the "My QR" view
                       }) {
                           Text("My QR")
                               .foregroundColor(.black)
                       }
                   )*/

    }
    
    // Function to open the scanned URL in the browser
    func openURL(_ code: String) {
        var formattedCode = code
        if !formattedCode.lowercased().hasPrefix("http://") && !formattedCode.lowercased().hasPrefix("https://") {
            formattedCode = "https://\(formattedCode)"
        }
        if let url = URL(string: formattedCode) {
            if UIApplication.shared.applicationState == .active {
                UIApplication.shared.open(url)
            } else {
                print("App is not in the foreground, URL won't open.")
            }
        } else {
            print("Failed to create URL: \(formattedCode)")
        }
    }
    
    // Detect QR code from image function
    func detectQRCode(from image: UIImage) -> String? {
        guard let ciImage = CIImage(image: image) else { return nil }
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        let features = detector?.features(in: ciImage) as? [CIQRCodeFeature]
        return features?.first?.messageString
    }
}

// A view to show "My QR" when the button is pressed
struct MyQRView: View {
    var body: some View {
        VStack {
            Text("My QR Code")
                .font(.title)
            // Here you would generate or show a user's QR code
            Image(systemName: "qrcode")
                .resizable()
                .frame(width: 200, height: 200)
                .padding()
            
            Button("Close") {
                // Close the QR view
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
            }
            .padding()
        }
    }
}

// A simple ImagePicker to select an image from the gallery
struct ImagePicker: UIViewControllerRepresentable {
    var onSelect: (UIImage?) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(onSelect: onSelect)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var onSelect: (UIImage?) -> Void

        init(onSelect: @escaping (UIImage?) -> Void) {
            self.onSelect = onSelect
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let result = results.first, result.itemProvider.canLoadObject(ofClass: UIImage.self) else {
                onSelect(nil)
                return
            }
            result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    self.onSelect(image as? UIImage)
                }
            }
        }
    }
}



struct QRCodeScannerView: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: QRCodeScannerView
        var captureSession: AVCaptureSession?
        
        init(parent: QRCodeScannerView) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                
                // Handle the scanned QR code value
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                parent.didFindCode(stringValue)
            }
        }
    }
    
    var didFindCode: (String) -> Void
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let captureSession = AVCaptureSession()
        context.coordinator.captureSession = captureSession
        
        // Check camera permission
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCaptureSession(captureSession, viewController: viewController, context: context)
            return viewController // Return immediately after setting up the session
        case .denied, .restricted:
            let promptView = CameraAccessPromptViewController()
            return UIHostingController(rootView: promptView)
        case .notDetermined:
            // Request permission and handle accordingly
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        self.setupCaptureSession(captureSession, viewController: viewController, context: context)
                        viewController.view.layoutIfNeeded() // Ensure layout updates
                    } else {
                        let promptView = CameraAccessPromptViewController()
                        viewController.present(UIHostingController(rootView: promptView), animated: true, completion: nil)
                    }
                }
            }
            // Return a blank view controller while waiting for permission
            return viewController // Return immediately while waiting for user response
        @unknown default:
            fatalError("Unknown camera authorization status.")
        }
    }
    
    func setupCaptureSession(_ captureSession: AVCaptureSession, viewController: UIViewController, context: Context) {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Your device doesn't support scanning a QR code.")
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Error creating video input: \(error)")
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Couldn't add video input to session.")
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Couldn't add metadata output to session.")
            return
        }
        
        // Set up the camera preview layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        // Create scanner frame overlay
        let scannerFrame = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scannerFrame.center = viewController.view.center
        scannerFrame.layer.borderColor = UIColor.white.cgColor
        scannerFrame.layer.borderWidth = 2
        viewController.view.addSubview(scannerFrame)
        
        // Add scaling animation to the scanner frame
        UIView.animate(withDuration: 1, delay: 0, options: [.autoreverse, .repeat], animations: {
            scannerFrame.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
        
        // Start the session
        DispatchQueue.global(qos: .userInitiated).async {
            captureSession.startRunning()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No need to update anything here
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

struct CameraAccessPromptViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        // Create and configure the label
        let label = UILabel()
        label.text = "Enable camera access for your phone."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // Add label to the view controller's view
        viewController.view.addSubview(label)
        
        // Center the label in the view
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor),
            label.leadingAnchor.constraint(greaterThanOrEqualTo: viewController.view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(lessThanOrEqualTo: viewController.view.trailingAnchor, constant: -20)
        ])
        
        viewController.view.backgroundColor = .white // Optional: set a background color
        
        return viewController // Return the view controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No updates needed here
    }
}


