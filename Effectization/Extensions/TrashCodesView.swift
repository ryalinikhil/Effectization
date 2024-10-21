//
//  TrashCodes.swift
//  Effectization
//
//  Created by Sameer Nikhil on 24/10/24.
//

//MARK:- JUST FOR REFERENCE PURPOSE ONLY: DO NOT MODIFY

//HOME PAGE

/*
    var body: some View {
        
        ZStack{
            
            Color.black
                .ignoresSafeArea()
                
                VStack {
                    // Horizontal Scroll for  Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(categories) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category.name)
                                        .font(.system(size: 19, weight: .bold))
                                        .padding(.horizontal,16)
                                        .padding(.vertical,8)
                                        .background(selectedCategory?.id == category.id ? Color.clear : Color.clear)
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 24)
                                        .background(Color.white)
                                        .cornerRadius(30)
                                }
                            }
                        }
                        .padding()
                    }
                    
                    // Subcategory view for selected category
                    if let category = selectedCategory {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(category.subcategories) { subcategory in
                                ZStack {
                                    Image(subcategory.image)
                                        .resizable()
                                        .frame(width: .infinity, height: 480)
                                        .cornerRadius(40)
                                    
                                    VStack(alignment: .leading) {
                                        HStack{
                                            ZStack{
                                                blur22()
                                                Text(subcategory.title)
                                                    .font(.headline)
                                                    .foregroundStyle(.white)
                                            }
                                            Spacer()
                                        }
                                        
                                        Spacer()
                                        HStack{
                                            Text(subcategory.duration)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            
                                            Spacer()
                                            
                                            NavigationLink(
                                                destination: EmptyView()
                                            ) {
                                                ZStack{
                                                    
                                                    blur23()
                                                    
                                                    Image(systemName: "chevron.right")
                                                        .font(.system(size: 18, weight: .bold))
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                            
                                        }
                                        .padding(.leading)
                                    }
                                    
                                    .padding()
                                }
                                .cornerRadius(10)
                                .shadow(radius: 5)
                            }
                        }
                        .padding()
                        
                    } else {
                        // Placeholder view before selecting a category
                        Text("Choose a category to see workouts")
                            .font(.title)
                            .padding()
                    }
                    Spacer()
                }
            }
        }*/


//MARK:- 2 QR CODE

/*
 HStack{
     Button(action: {
         // Action for "Scan Code" button (can reset scanner)
         self.scannedCode = nil
     }) {
         Text("Scan Code")
             .font(.system(size: 20))
             .font(.headline)
             .foregroundColor(.black)
             .padding()
     }
     
     Spacer()
     
     Button(action: {
         // Action for "Scan Code" button (can reset scanner)
         self.isMyQRPresented = true
     }) {
         Text("My QR")
             .font(.system(size: 20))
             .font(.headline)
             .foregroundColor(.black)
             .padding()
     }
 }
 .padding(.horizontal) // Padding around buttons to ensure space within the background
 .background(Color.white) // Background color (use any color you prefer)
 .cornerRadius(35) // Corner radius of 20 to round the rectangle
 .shadow(radius: 5)
 */

//MARK:- 3 CATEGORIES ARRAY LIST

/*
 let categories = [
     //MARK:- CATEGORY 1
     WorkoutCategory(name: "AR", subcategories: [
         WorkoutSubcategory(title: "SnapChat Lenses", duration: "SnapChat", image: "img1"),WorkoutSubcategory(title: "SnapChat Lenses", duration: "SnapChat", image: "img2"),
         WorkoutSubcategory(title: "Tiktok Filters", duration: "SnapChat", image: "img3"),
         WorkoutSubcategory(title: "WebAR", duration: "SnapChat", image: "img5")
     ]),
     //MARK:- CATEGORY 3
     WorkoutCategory(name: "Web Apps", subcategories: [
         WorkoutSubcategory(title: "Hyper Casual Game", duration: "25 min", image: "img4"),
         WorkoutSubcategory(title: "Branded Activation", duration: "25 min", image: "img9"),
         WorkoutSubcategory(title: "Web Tools", duration: "25 min", image: "img10")
     ]),
     //MARK:- CATEGORY 2
     WorkoutCategory(name: "CGI", subcategories: [
         WorkoutSubcategory(title: "Static Renders", duration: "20 min", image: "img7"),
         WorkoutSubcategory(title: "CGI Videos", duration: "20 min", image: "img6"),
         WorkoutSubcategory(title: "VFX Videos", duration: "20 min", image: "img8")
     ]),
     //MARK:- CATEGORY 4
     WorkoutCategory(name: "AI", subcategories: [
         WorkoutSubcategory(title: "Content Creation", duration: "25 min", image: "img11"),
         WorkoutSubcategory(title: "AI Web App", duration: "25 min", image: "img12"),
         WorkoutSubcategory(title: "AI Tool", duration: "25 min", image: "img13")
     ])

 ]
 */



//MARK:- QR

/*
import SwiftUI
import AVFoundation

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
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            print("Your device doesn't support scanning a QR code.")
            return viewController
        }
        
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print("Error creating video input: \(error)")
            return viewController
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            print("Couldn't add video input to session.")
            return viewController
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            print("Couldn't add metadata output to session.")
            return viewController
        }
        
        // Set up the camera preview layer
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewController.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        // Create scanner frame overlay
        let scannerFrame = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        scannerFrame.center = viewController.view.center
        scannerFrame.layer.borderColor = UIColor.green.cgColor
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
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No need to update anything here
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

struct ContentView67: View {
    @State private var scannedCode: String = "Scan a QR code"
    
    var body: some View {
        VStack {
            QRCodeScannerView { code in
                self.scannedCode = code
                print("Scanned QR Code: \(code)")
            }
            .edgesIgnoringSafeArea(.all)
            
            Text(scannedCode)
                .padding()
                .background(Color.black.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding()
        }
    }
}
*/
