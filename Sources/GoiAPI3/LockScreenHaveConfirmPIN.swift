
import SwiftUI


public struct LockScreenHaveConfirmPIN : View {
    
    @Binding var password:String
 
    var textAskUserDo:String
    
    public init(textAskUserDo:String,password: Binding<String>) {
        self._password = password
        self.textAskUserDo = textAskUserDo
    }
    
    public var body: some View{
        
        VStack{
            
            Image(systemName: "global.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .padding(.top,20)
            
            Text(textAskUserDo)
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
            .padding(.top,10)
            
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                
                // Password Button ....
                
                ForEach(1...9,id: \.self){value in
                    
                    PasswordButton2(value: "\(value)",password: $password)
                }
                
                PasswordButton2(value: "delete.fill",password: $password)
                
                PasswordButton2(value: "0", password: $password)
            }
            .padding(.bottom)

        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}


struct PasswordButton2 : View {
    
    var value : String
    @Binding var password : String
    
    
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.blue)
                }
                else{
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.blue)
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
                                
                                print(password)
                               
                            }
                        }
                    }
                }
            }
        }
    }
}
