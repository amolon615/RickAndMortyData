//
//  DownloadWithEscaping.swift
//  RickAndMortyData
//
//  Created by Artem on 04/01/2023.
//

import SwiftUI


class DownloadWithEscapingViewModel: ObservableObject{
    @Published var wizards2: [Wizard] = []
    
    init() {
       loadWizards2()
    }
    
    
    func loadWizards2(){
        
        guard let url = URL(string: "https://wizard-world-api.herokuapp.com/Wizards") else { return }
        
        downloadData(fromURL: url) { returnedData in
            if let data = returnedData {
                guard let newWizards = try? JSONDecoder().decode([Wizard].self, from: data) else { return }
                DispatchQueue.main.async{ [weak self] in
                    self?.wizards2 = newWizards
                    print("docoded succes")
                    print(data)
                }
            } else {
                print("no data returned")
            }
        }
        
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping(_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                print("error downloading error")
            completionHandler(nil)
                print("download success")
                return
            }
            completionHandler(data)
        }.resume()
    }
   
    
}


struct DownloadWithEscaping: View {
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
            List{
                ForEach(vm.wizards2){wizard in
                    VStack{
                        Text(wizard.firstName ?? " ")
                        Text(wizard.lastName)
                    }
                }
            }
        
        
    }
}

struct DownloadWithEscaping_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscaping()
    }
}
