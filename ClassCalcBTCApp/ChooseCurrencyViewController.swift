//
//  ChooseCurrencyViewController.swift
//  ClassCalcBTCApp
//
//  Created by Ghayth Kubaisi on 2/13/19.
//  Copyright © 2019 Ghayth Kubaisi. All rights reserved.
//

import UIKit
import Alamofire

class ChooseCurrencyViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var mytableView: UITableView!
    
    let symbolsUrlString = "https://apiv2.bitcoinaverage.com/symbols/indices/ticker"
    var currenciesAvailabeForBTC:[String] = [] // to store available conversions provided by the api
    var selectedCurrency = "" // the chosen currency detected by cell selection
    //cell background colors
    var DarkerColor  = UIColor.init(hex: "6B6B6B")
    var lighterColor = UIColor.init(hex: "5CC0A7")

    override func viewDidLoad() {
        super.viewDidLoad()
        // get the username saved before
        guard let userName = UserDefaults.standard.string(forKey: "userName") else {return}
        helloLabel.text = "Hello, " + userName
        // connect to API and get the availabe currencies to convert to
        let networking = networkingClient()
        guard let symbolsUrl = URL(string: symbolsUrlString ) else { return }
        networking.executeRequest(Url: symbolsUrl) { (json , error) in
            if let error = error // if there is an error print it
            {
                print(error.localizedDescription)
            } else if let json = json
            {
                // get the BTC only symbols from jason
              if let symbols = json.object(forKey: "global") as? NSDictionary
              {
                let symbolsStringArray = symbols.object(forKey: "symbols") as! [String]
                self.currenciesAvailabeForBTC = symbolsStringArray.filter{
                    $0.contains("BTC")
                  
                  
                }
                  self.mytableView.reloadData() // after the currencies are available refresh the view so we can see them on the table
                }
              else
              {
                
              }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCurrency = currenciesAvailabeForBTC[indexPath.row]
        performSegue(withIdentifier: "convert", sender: self)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of cell is equal to number of currencies available to convert
        return (currenciesAvailabeForBTC.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currencyCell = self.mytableView.dequeueReusableCell(withIdentifier: "currencyCell") as! ChoseCurrencyCell
        currencyCell.currency.text = currenciesAvailabeForBTC[indexPath.row].replacingOccurrences(of: "BTC", with: "") //set the cell text after strapping BTC from it ex. BTCUSD -> USD
        
        // alternate cell colors
        
        if (indexPath.row % 2) == 0
        {
            currencyCell.contentView.backgroundColor = lighterColor
            
        }
        else
        {
         currencyCell.contentView.backgroundColor = DarkerColor
        }
        return currencyCell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let convertViewController = segue.destination as! ConversionViewController
        convertViewController.currency = selectedCurrency // set the currect currency on the convert view controller to request its rate later when the view is loaded
    }
}
