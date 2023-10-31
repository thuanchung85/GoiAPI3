
import SwiftUI


public struct PasscodeView_Login : View {
    
    @Binding var isUserPass_PIN_login:Bool
    @State var password:String = ""
    @State var passwordSaved:String = ""

    var textAskUserDo:String
    
    public init(textAskUserDo:String,passwordSaved:String, isUserPass_PIN_login:Binding<Bool>) {
        self.passwordSaved = passwordSaved
        self.textAskUserDo = textAskUserDo
        self._isUserPass_PIN_login = isUserPass_PIN_login
    }
    
    public var body: some View{
        //Bước 1: hiện page cho user nhập mã PIN trước
            VStack{
                
                Text(textAskUserDo)
                    .font(.custom("Arial ", size: 18))
                    .padding(.top,10)
                
                HStack(spacing: 22){
                    
                    // Password Circle View...
                    
                    ForEach(0..<6,id: \.self){index in
                        
                        PasswordView2(index: index, password: $password)
                    }
                }
                // for smaller size iphones...
                .padding(.top,22)
                
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                    
                    // Password Button ....
                    
                    ForEach(1...9,id: \.self){value in
                        
                        PasswordButton2(value: "\(value)",password: $password, passwordSaved: passwordSaved, isUserPass_PIN_login: $isUserPass_PIN_login)
                    }
                    
                    PasswordButton2(value: "delete.fill",password: $password, passwordSaved: passwordSaved, isUserPass_PIN_login: $isUserPass_PIN_login)
                    
                    PasswordButton2(value: "0", password: $password, passwordSaved: passwordSaved, isUserPass_PIN_login: $isUserPass_PIN_login)
                }
                .padding(.bottom)
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        
        
       
    }
}

//================//////////

struct PasswordView2 : View {
    
    var index : Int
    @Binding var password : String
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.black,lineWidth: 1)
                .frame(width: 25, height: 25)
            
            // checking whether it is typed...
            
            if password.count > index{
                
                Circle()
                    .fill(Color.green)
                    .frame(width: 25, height: 25)
            }
        }
    }
}




///////////////========================////////////
struct PasswordButton2 : View {
    
    var value : String
    @Binding var password : String
   var passwordSaved : String
    @Binding var isUserPass_PIN_login:Bool
    
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.gray.opacity(0.2))
                            .frame(width: 55, height: 55)
                        Image(systemName: "delete.left")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }
                else{
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.gray.opacity(0.2))
                            .frame(width: 55, height: 55)
                        Text(value)
                            .font(.body)
                            .foregroundColor(.black)
                    }
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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        
                        withAnimation{
                            
                            if password.count == 6{
                                
                                print(password)
                                if(password == passwordSaved){
                                    self.isUserPass_PIN_login = true
                                }
                                else{
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


