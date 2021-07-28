//
//  ViewController.swift
//  getRandomCat
//
//  Created by Галина Збитнева on 10.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    struct Response: Codable {
        var file: String // важно!! переменную назвать как ключ в json файле  //пример  "file": //"https://purr.objects-us-east-1.dream.io/i/AwLr7.jpg"
    }
    
    struct DogFact: Codable {
        var fact: String
    }
    
    var factAboutDogs: String?
    
    
        //let resourceURl = URL(string: "https://aws.random.cat/meow")
    let catResource = "https://aws.random.cat/meow"
    
    let dogsFactsUrl = "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs/all"
    
   
    //let testCatURL = URL(string: "https://purr.objects-us-east-1.dream.io/i/AwLr7.jpg")
    
    
    @IBOutlet weak var factLabel: UILabel!
    
    func getCatHttp(from url: String){
    
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data , error == nil else {
                print("something went wrong")
                return
            }
             //значит получили данные
            var result: Response? //создаем переменную типа Response из созданной структуры, которая содержит искомую переменную file
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
                print("faild to convert")
            }
            guard let json = result else {
                return
            }
           // print(json.file)// здесь как раз и будет искомая ссылка на рандомную картинку
            let catURL = URL(string: json.file)!
           // print(catURL)
            
            
            self.downloadImage(from: catURL) // это функция которая юрл преобразует в картинку
            
        })
        task.resume()
    }
    
    
   
    @IBOutlet weak var catImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCatHttp(from: catResource)
        
        // Do any additional setup after loading the view.
    }


    @IBAction func findCatButton(_ sender: UIButton) {
        
       getCatHttp(from: catResource)
      
}
    
    
    @IBAction func getFactButton(_ sender: Any) {
        getDogFact(from: dogsFactsUrl)
        //factLabel.text = factAboutDogs
        
        //добавить
    }
    
    func getData (from url: URL, completion: @escaping (Data?, URLResponse?, Error?)->()){
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL) {
        print("download started")
        getData(from: url){data, response, error in
            guard let data = data, error == nil else {
                return
            }
            print("download finished")
            
            DispatchQueue.main.async {
                [weak self] in
                self?.catImage.image = UIImage(data: data)
            }
        }
    }

    


func getDogFact(from url: String){

    let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self]data, response, error in
        guard let data = data , error == nil else {
            print("something went wrong")
            return
        }
         //значит получили данные
        var result: [DogFact]? //создаем переменную типа DogFact из созданной структуры, которая содержит искомую переменную var fact: DogFact?
        do{
            result = try JSONDecoder().decode([DogFact].self, from: data)
            
        }
        catch{
            print("faild to convert")
        }
        guard let json = result else {
            return
        }
        let number = Int.random(in: 0...430)
        print(json[number].fact)// здесь как раз и будет искомая ссылка на рандомную картинку
        //print(json.count)// 435
        self.factAboutDogs = json[number].fact
       //factLabel.text = json[number].fact
        DispatchQueue.main.async {
            [weak self] in
            self?.factLabel.text = json[number].fact}
            
    })
    task.resume()
}

}

    
extension UIImageView {
    func loadImageFromURL(url: URL){
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                    
                }
                
            }
        }
    }
}


