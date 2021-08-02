//
//  AllFactsController.swift
//  getRandomCat
//
//  Created by Галина Збитнева on 29.07.2021.
//

import UIKit


    
   
    
    
var allfacts: [CatFact?] = [CatFact(text: "В сред­нем кош­ки тра­тят две трети своей жизни на сон. Получается, что, например, де­вяти­лет­ний кот бодрствовал лишь три го­да сво­ей жиз­ни"),
                           CatFact(text: "Оказывается, к нашему мозгу би­оло­гичес­ки бли­же мозг кошки, нежели со­баки. У нас с кошками за эмо­ции от­ве­ча­ют те же са­мые учас­тки моз­га"),
                           CatFact(text: "Самая крупная в наши дни кошка — это лигр. Он может вырасти до 4 м, а вес может превышать 300 кг. Самый крупный ныне живущий лигр Геркулес весит 450 кг"),
                           CatFact(text: "Са­мая ма­лень­кая современная ди­кая кош­ка — это чер­но­ногий кот. Сам­ки составляют менее 50 см в дли­ну и мо­гут ве­сить все­го 1,2 кг"),
                           CatFact(text: "Британцы и австралийцы считают встречу с черным котом большой удачей, тогда как в Европе и Се­вер­ной Америке это, наоборот, счи­та­ет­ся пло­хим зна­ком"),
                           CatFact(text: "Са­мая по­пуляр­ная в ми­ре по­рода — пер­сид­ская кош­ка, потом идут мейн-куны и си­ам­цы"),
                           CatFact(text: "Есть порода кошек, которая обожает воду. Это ту­рец­кий ва­н. Ее представители любят купаться из-за своей водонеп­ро­ница­емой шерсти"),
                           
    
    ]

var newfacts: [String?] = ["Кошки не способны чувствовать вкус сладкого","Кошки способны произносить около 100 звуков, а собаки – только десять", "В оригинальной версии сказки о Золушке феей-крёстной была кошка"]


class AllFactsController: UITableViewController  {
    
//var allCatfacts = allfacts

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allfacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! TableViewCell

        // Configure the cell...
        guard let currentFact = allfacts[indexPath.row]?.text else {
            return cell
        }
        
        //конфигурируем новую ячейк
        cell.factCatLabel.text = currentFact
        
        return cell
        //let fact = allfacts[indexPath.row]
        //cell.textLabel?.text = fact
        
        //return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
