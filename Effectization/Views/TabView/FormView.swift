//
//  FormView.swift
//  Effectization
//
//  Created by Sameer Nikhil on 24/10/24.
//

import SwiftUI

struct FormView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var company: String = ""
    @State private var message: String = ""
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()

            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Company logo and name
                    HStack {
                        Image(systemName: "building.2.crop.circle.fill") // Replace with your logo
                            .resizable()
                            .frame(width: 65, height: 65)
                            .padding(.leading, 20)
                            .foregroundStyle(.white)
                        
                        Text("Effectization\nStudio")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                            .multilineTextAlignment(.leading)
                    }
                    .padding(.top, 20)
                    
                    // "GET IN TOUCH" Label
                    Text("GET IN TOUCH")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .heavy))
                        .padding(.leading, 20)
                        .padding(.top)
                    
                    // Text fields for user input
                    Group {
                        CustomTextField(placeholder: "Name", text: $name)
                        CustomTextField(placeholder: "Email", text: $email, isEmail: true)
                        CustomTextField(placeholder: "Company", text: $company)
                        CustomTextField(placeholder: "Message", text: $message, height: 80)
                    }
                    .padding(.horizontal, 20)
                    
                    // Submit button
                    Button(action: submitForm) {
                        Text("Submit")
                            .font(.system(size: 18, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 30)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .padding(.bottom, 70)
               // .background(GradientBackground())
                .ignoresSafeArea(edges: .all)
            }
        }
    }
    
    func submitForm() {
        if name.isEmpty || email.isEmpty || company.isEmpty || message.isEmpty {
            alertTitle = "Error"
            alertMessage = "Please fill all fields"
            showAlert = true
        } else if !isValidEmail(email) {
            alertTitle = "Error"
            alertMessage = "Please enter a valid email address"
            showAlert = true
        } else {
            // Call the form
            submitToGoogleForm()
        }
    }
    
    // Function - Google Forms
    func submitToGoogleForm() {
        let url = URL(string: "https://docs.google.com/forms/u/0/d/e/1FAIpQLScUguD2__4okFoAmjcLWus8Q9hmB8gHkl4qlgEhQxzKljm-Fg/formResponse")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Prepare the POST string with form data
        let postString = "entry.485428648=\(name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entry.879531967=\(email.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entry.326955045=\(company.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&entry.267295726=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        request.httpBody = postString.data(using: .utf8)
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertTitle = "Error"
                    alertMessage = "Failed to submit form: \(error.localizedDescription)"
                    showAlert = true
                } else if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    alertTitle = "Success"
                    alertMessage = "Form submitted successfully!"
                    clearFormFields()
                    showAlert = true
                } else {
                    alertTitle = "Error"
                    alertMessage = "Failed to submit form. Please try again later."
                    showAlert = true
                }
            }
        }.resume()
    }
    
    func clearFormFields() {
        name = ""
        email = ""
        company = ""
        message = ""
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isMultiline: Bool = false
    var isEmail: Bool = false
    var height: CGFloat = 50
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.5))
                    .padding(.leading, 20) // Padding for placeholder text
            }
                        TextField("", text: $text)
                .keyboardType(isEmail ? .emailAddress : .default)
                .padding(.horizontal, 10)
                .frame(height: height)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.white)
                .autocapitalization(.none)
        }
        .padding(.vertical, 1)
    }
}




struct GradientBackground: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: .infinity, height: .infinity)
            .background(BlurView(style: .light)) // Set to .light for stronger blur but keep it subtle
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1) // Lighter stroke for less emphasis
            )
            .background(Color.white.opacity(0.05)) // Slight white tint to enhance glassmorphism
            .shadow(
                color: Color.black.opacity(0.05), radius: 16, y: 8 // Soften the shadow
            )
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
