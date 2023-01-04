//
//  test.swift
//  BucketList
//
//  Created by Artem on 03/12/2022.
//

import SwiftUI
import Combine



class WizardViewModel: ObservableObject{
    @Published var wizards: [Wizard] = []
    var cancellables = Set<AnyCancellable>()
    
    init(){
        loadWizards()
    }
    
    func loadWizards(){
        guard let url = URL(string: "https://wizard-world-api.herokuapp.com/Wizards") else { return }
        
        
        //Combine discussion
        //1. sign up for monthly subscriptuon for package to be delivered
        //2. the company would make the package behind the scene
        //3. receive the package at your front door
        //4. make sure the boz isn't damaged
        //5. open and make sure the item is correct
        //6. use the item
        //7. cancellable at any time!
        
        //1. create the publisher
        //2. subscribe the publisher on the background thread
        //3. receive on main thread
        //4. tryMap (check that the data is good)
        //5. decode data into PostModels
        //6. sink (put the item into our app)
        //7. store (cancel subscriptuon if needed)
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [Wizard].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print("There was an error \(error)")
                }
            } receiveValue: { [weak self] (returnedPosts) in
                self?.wizards = returnedPosts
            }
            .store(in: &cancellables)
       
    }
    
    func handleOutput (output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode <= 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}




struct ContentView: View {
    // The characters array that will store the fetched data
    @StateObject var vm = WizardViewModel()
    
    
 

    var body: some View {
        // Use a List to display the characters
        NavigationView{
            VStack{
                List(vm.wizards) { wizard in
                    HStack{
                        Text(wizard.firstName ?? "")
                        Text(wizard.lastName ?? "")
                        ForEach(wizard.elixirs){elixir in
                            Text(elixir.name)
                            
                        }
                    }

                   
                    }
            }
        }
      
    }

}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



