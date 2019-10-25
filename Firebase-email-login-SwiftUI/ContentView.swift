



import SwiftUI
import Firebase
struct ContentView: View {
    
    @State var email = ""
    @State var password = ""
    @State var show = false
    @State var message = ""
    
 var body: some View {
  
        
        VStack {
            TextField("email", text:$email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
               

            SecureField("password", text:$password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
             
            
            HStack {
                
                Button(action: {
                    if self.email  == "" && self.password == "" {
                        self.message = " Boşlukları doldurun"
                        self.show.toggle()
                        return
                 
                    }
                    Auth.auth().signIn(withEmail: self.email, password: self.password) { (res, err) in
                        
                        if err  != nil {
                            print((err!.localizedDescription))
                            self.message = err!.localizedDescription
                            self.show.toggle()
                            return
                        }
                        self.message = "Başarılı Giriş"
                        self.show.toggle()
                    }
                   
                })  {
                        Text("Sign in")
                
                    
                }
                Button(action: {
                    
                    if self.email  == "" && self.password == "" {
                                       
                                          self.message = " Boşlukları doldurun"
                                          self.show.toggle()
                                          return
                    }
                    
                    Auth.auth().createUser(withEmail: self.email, password: self.password) { (res, err)  in
                        
                        if err != nil {
                            print(err!.localizedDescription)
                            self.message = err!.localizedDescription
                            self.show.toggle()
                            return
                        }
                        self.message = "Yeni Kayıt oluşturuldu!!"
                        self.show.toggle()
                    }
                }) {
                        Text("Sign up")
                
                }
            }.alert(isPresented: $show) {
                
                return Alert(title: Text(self.message))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
