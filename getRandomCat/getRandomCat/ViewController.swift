//
//  ViewController.swift
//  getRandomCat
//
//  Created by Галина Збитнева on 10.07.2021.
//

import UIKit

struct CatFact: Codable {
    var text: String
}

// var factAboutDogs: String?


var catFactsFromApi: [CatFact?] = [CatFact(text: "Кошки обнюхивают пищу перед едой, потому что так они определяют ее температуру"), CatFact(text: "По некоторым данным, Наполеон Бонапарт панически боялся кошек"), CatFact(text: "Треть владельцев кошек считает своих пушистых питомцев способными читать их мысли")]


class ViewController: UIViewController {
    
    struct Response: Codable {
        var file: String // важно!! переменную назвать как ключ в json файле  //пример  "file": //"https://purr.objects-us-east-1.dream.io/i/AwLr7.jpg"
    }
    
    struct DogFact: Codable {
        var fact: String
    }
    
    
    //let resourceURl = URL(string: "https://aws.random.cat/meow")
    let catResource = "https://aws.random.cat/meow"
    
    let dogsFactsUrl = "https://dog-facts-api.herokuapp.com/api/v1/resources/dogs/all"
    
    let catsFactsUrl = "https://cat-fact.herokuapp.com/facts"
    
    let catPicture = URL(string: "https://purr.objects-us-east-1.dream.io/i/1302922972589_f.jpg")
    
   
    //let testCatURL = URL(string: "https://purr.objects-us-east-1.dream.io/i/AwLr7.jpg")
    
    var currentIndexInArray = 1 // не 0, потому что с 0 индексом используем при загрузке сцены
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
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
            let catURL = URL(string: json.file) ??  URL(string: "https://purr.objects-us-east-1.dream.io/i/XnWrl.jpg")
           // print(catURL)
            
            
            self.downloadImage(from: catURL!) // это функция которая юрл преобразует в картинку
            
        })
        task.resume()
    }
    
    
   
    @IBOutlet weak var catImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //downloadImageUniversal(from: catPicture!, to: backgroundImage)
        
       // getCatHttp(from: catResource)
        
        factLabel.text = allfacts[0]?.text // в качестве начального массива будем использовать шаблонный массив
        
        // Do any additional setup after loading the view.
    }


    @IBAction func findCatButton(_ sender: UIButton) {
        
       getCatHttp(from: catResource)
      
}
    
    
    @IBAction func getFactButton(_ sender: Any) {
       // getDogFact(from: dogsFactsUrl)
        
        
        /*
        
         //здесь список подгружается без удаления
         
        if (currentIndexInArray<allfacts.count){
            factLabel.text = allfacts[currentIndexInArray]?.text
        }
        currentIndexInArray += 1
        
        if (currentIndexInArray == allfacts.count){
           // allfacts.append(contentsOf: catFactsFromApi)
            
            getCatFact(from: catsFactsUrl)
            
            
        }
 */
        //здесь показанные факты удаляются из массива, новые подгружаются когда останется только два факта
        allfacts.remove(at: 0)
        
        if (allfacts.count>1){
            factLabel.text = allfacts[0]?.text
            //allfacts.remove(at: 0)
        } else {
            factLabel.text = allfacts[0]?.text
            getCatFact(from: catsFactsUrl)
        }
        
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
    
    private func downloadImageUniversal(from url: URL, to Image: UIImageView) {
        print("download started")
        getData(from: url){data, response, error in
            guard let data = data, error == nil else {
                return
            }
            print("download finished")
            
            DispatchQueue.main.async {
                [weak self] in
                Image.image = UIImage(data: data)
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
       
       //factLabel.text = json[number].fact
        DispatchQueue.main.async {
            [weak self] in
            self?.factLabel.text = json[number].fact}
            
    })
    task.resume()
}

    
    
    func getCatFact(from url: String){

        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { [self]data, response, error in
            guard let data = data , error == nil else {
                print("something went wrong")
                return
            }
             //значит получили данные
            var result: [CatFact]?
            
            do{
                result = try JSONDecoder().decode([CatFact].self, from: data)
                
            }
            catch{
                print("faild to convert")
            }
            guard let json = result else {
                return
            }
            
            allfacts.append(contentsOf: json)
            
            /*
            let number = Int.random(in: 0...4)
            //print(json.count)
            DispatchQueue.main.async {
                [weak self] in
                self?.factLabel.text = catFactsFromApi[number]?.text}
             */
 
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


