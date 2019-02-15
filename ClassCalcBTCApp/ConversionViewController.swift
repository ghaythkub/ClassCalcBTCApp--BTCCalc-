//
//  ViewController.swift
//  ClassCalcBTCApp
//
//  Created by Ghayth Kubaisi on 2/13/19.
//  Copyright © 2019 Ghayth Kubaisi. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController {
    var currency = "" // choosen currency from previuos view
    var currencyString = "" // choosen currency striping BTC to put it on view
    var rateUrlString = "https://apiv2.bitcoinaverage.com/indices/global/ticker/"
    @IBOutlet weak var CurrencyLabelTop: UILabel!
    @IBOutlet weak var CurrencyLabelButtom: UILabel!
    @IBOutlet weak var BTCtoCurrencyLabel: UILabel!
    @IBOutlet weak var CurrencyToBTCLabel: UILabel!
    // return to previous view when the show more currencies button pressed
    @IBAction func ShowOtherCurrenciesButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil) // subscribe to this function when the view been not active to dismiss it and return to choose currency view
        currencyString = currency.replacingOccurrences(of: "BTC", with: "")
        // text setting and adjustments
        CurrencyLabelTop.text = currencyString
        CurrencyLabelButtom.text = currencyString
        BTCtoCurrencyLabel.adjustsFontSizeToFitWidth = true
        CurrencyToBTCLabel.adjustsFontSizeToFitWidth = true
        CurrencyToBTCLabel.minimumScaleFactor = 0.7
        // add choosen currency to the URL to retreive correct currency
        rateUrlString += currency
        guard let rateUrl = URL(string: rateUrlString) else {return}
        
        // connect to API and get the rate
        let networking = networkingClient()
        networking.executeRequest(Url: rateUrl) { (json , error) in
            if let error = error // if there is an error print it
            {
                print(error.localizedDescription)
            } else if let json = json
            {
                if let rate = json.object(forKey: "ask") as? Double // we have choosen the ask value to display
                {
                    self.BTCtoCurrencyLabel.text = String(rate)
                    self.CurrencyToBTCLabel.text = String(1/rate) // backward conversion from choosen currency to BTC
                        
                    }
                
                
                }
                    
                    
                else
                {
                    
                }
            }
        }

    @objc func willResignActive(_ notification: Notification) {
       self.dismiss(animated: true, completion: nil) // when the screen been not active, dismiss it (return to previous screeen) , wich means when the app gets in background or when you switch to other apps,have a call, ..... ,if the desired behaviour is only when entering background totaly, this should be handeled in appdelegate enterbackground function
    }
}

