
import SwiftUI


public struct LockScreenHaveConfirmPIN : View {
    
    @Binding var password:String
    @State var passwordBuoc1:String = ""

    @State var isShowConFirmPassCodeView:Bool = false
    
    var textAskUserDo:String
    
    public init(textAskUserDo:String,password: Binding<String>) {
        self._password = password
        self.textAskUserDo = textAskUserDo
    }
    
    public var body: some View{
        //Bước 1: hiện page cho user nhập mã PIN trước
        if (isShowConFirmPassCodeView == false){
            VStack{
                
                Image(systemName: "person")
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
                        
                        PasswordView2(index: index, password: $password)
                    }
                }
                // for smaller size iphones...
                .padding(.top,10)
                
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                    
                    // Password Button ....
                    
                    ForEach(1...9,id: \.self){value in
                        
                        PasswordButton2(value: "\(value)",password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                    }
                    
                    PasswordButton2(value: "delete.fill",password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                    
                    PasswordButton2(value: "0", password: $password, passwordBuoc1: $passwordBuoc1, isShowConFirmPassCodeView: $isShowConFirmPassCodeView)
                }
                .padding(.bottom)
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
        
        //Bước 2: hiện page cho user confirm mã PIN sau khi bước 1 ok
        else{
            VStack{
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.top,20)
                
                Text("Please Confirm your PIN number")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .padding(.top,20)
                    .foregroundColor(.red)
                
                HStack(spacing: 22){
                    
                    // Password Circle View...
                    
                    ForEach(0..<6,id: \.self){index in
                        
                        PasswordView3(index: index, password: $password)
                    }
                }
                // for smaller size iphones...
                .padding(.top,10)
                
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),spacing: UIScreen.main.bounds.width < 750 ? 5 : 15){
                    
                    // Password Button ....
                    
                    ForEach(1...9,id: \.self){value in
                        
                        PasswordButton3(value: "\(value)",password: $password, passwordBuoc1: $passwordBuoc1)
                    }
                    
                    PasswordButton3(value: "delete.fill",password: $password, passwordBuoc1: $passwordBuoc1)
                    
                    PasswordButton3(value: "0", password: $password, passwordBuoc1: $passwordBuoc1)
                }
                .padding(.bottom)
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

//================//////////

struct PasswordView2 : View {
    
    var index : Int
    @Binding var password : String
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.blue,lineWidth: 2)
                .frame(width: 30, height: 30)
            
            // checking whether it is typed...
            
            if password.count > index{
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 30, height: 30)
            }
        }
    }
}


//================//////////

struct PasswordView3 : View {
    
    var index : Int
    @Binding var password : String
    
    
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.red,lineWidth: 2)
                .frame(width: 30, height: 30)
            
            // checking whether it is typed...
            
            if password.count > index{
                
                Circle()
                    .fill(Color.red)
                    .frame(width: 30, height: 30)
            }
        }
    }
}


///////////////========================////////////
struct PasswordButton2 : View {
    
    var value : String
    @Binding var password : String
    @Binding var passwordBuoc1 : String
    @Binding var isShowConFirmPassCodeView:Bool
    
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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        
                        withAnimation{
                            
                            if password.count == 6{
                                
                                print(password)
                               //gọi tiếp view confirm passcode
                                self.isShowConFirmPassCodeView = true
                                //bắn password ra cho bên view bên trên
                                self.passwordBuoc1 = password
                                //reset lại password để cho view sau trống trơn
                                password.removeAll()
                            }
                        }
                    }
                }
            }
        }
    }
}




////==============================
struct PasswordButton3 : View {
    
    var value : String
    @Binding var password : String
    @Binding var passwordBuoc1 : String
    
    var body: some View{
        
        Button(action: setPassword, label: {
            
            VStack{
                
                if value.count > 1{
                    
                    // Image...
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 24))
                        .foregroundColor(.red)
                }
                else{
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.red)
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
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        
                        withAnimation{
                            
                            if password.count == 6{
                                print("password trước đó: ", passwordBuoc1)
                                print("password confirm: ",password)
                               //check if hai pass trùng hay không
                                if (passwordBuoc1 == password)
                                {
                                    print("OK PASS")
                                }
                                else{
                                    print("PASS CODE FAIL!")
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

