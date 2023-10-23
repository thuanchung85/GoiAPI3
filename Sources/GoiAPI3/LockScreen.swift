
import SwiftUI


public struct LockScreen : View {
    
    @Binding var password:String
    
    // you can change it when user clicks reset password....
    // AppStorage => UserDefaults....
     @AppStorage("lock_Password") var key = "12345"
    @Binding var unLocked : Bool
    @State var wrongPassword = false
  
    
    public init(password: Binding<String>, key: String = "12345", unLocked: Binding<Bool>, wrongPassword: Bool = false) {
        self._password = password
        self.key = key
        self._unLocked = unLocked
        self.wrongPassword = wrongPassword
    }
    
    public var body: some View{
        
        VStack{
            
            HStack{
                
                Spacer(minLength: 0)
                
                Menu(content: {
                    
                    Label(
                        title: { Text("Help") },
                        icon: { Image(systemName: "info.circle.fill") })
                        .onTapGesture(perform: {
                            // perform actions...
                        })
                    
                    Label(
                        title: { Text("Reset Password") },
                        icon: { Image(systemName: "key.fill") })
                        .onTapGesture(perform: {
                            
                        })
                    
                }) {
                    
                    Image(systemName: "person")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 19, height: 19)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding(.leading)
            
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 95, height: 95)
                .padding(.top,20)
            
            Text("Enter Pin to Unlock")
                .font(.title2)
                .fontWeight(.heavy)
                .padding(.top,20)
            
            HStack(spacing: 22){
                
                // Password Circle View...
                
                ForEach(0..<6,id: \.self){index in
                    
                    PasswordView(index: index, password: $password)
                }
            }
            // for smaller size iphones...
            .padding(.top,UIScreen.main.bounds.width < 750 ? 20 : 30)
            
            // KeyPad....
            
            Spacer(minLength: 0)
            
            Text(wrongPassword ? "Incorrect Pin" : "")
                .foregroundColor(.red)
                .fontWeight(.heavy)
            
            Spacer(minLength: 0)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                
                // Password Button ....
                
                ForEach(1...9,id: \.self){value in
                    
                    PasswordButton(value: "\(value)",password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
                }
                
                PasswordButton(value: "delete.fill",password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
                
                PasswordButton(value: "0", password: $password, key: $key, unlocked: $unLocked, wrongPass: $wrongPassword)
            }
            .padding(.bottom)

        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct PasswordView : View {
    
    var index : Int
    @Binding var password : String
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.white,lineWidth: 2)
                .frame(width: 30, height: 30)
            
            // checking whether it is typed...
            
            if password.count > index{
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
            }
        }
    }
}

struct PasswordButton : View {
    
    var value : String
    @Binding var password : String
    @Binding var key : String
    @Binding var unlocked : Bool
    @Binding var wrongPass : Bool
    
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }
                else{
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
            .padding()

        })
    }
    
    func setPassword(){
        
        // checking if backspace pressed...
        
        withAnimation{
            
            if value.count > 1{
                
                if password.count != 0{
                    
                    password.removeLast()
                }
            }
            else{
                
                if password.count != 6{
                    
                    password.append(value)
                    
                    // Delay Animation...
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        
                        withAnimation{
                            
                            if password.count == 6{
                                
                                if password == key{
                                    
                                    unlocked = true
                                }
                                else{
                                    
                                    wrongPass = true
                                    password.removeAll()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
