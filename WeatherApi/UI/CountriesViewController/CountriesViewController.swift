//
//  CountriesViewController.swift
//  WeatherApi
//
//  Created by Alex Vorobiev on 1/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        self.rootView?.tableView?.dataSource = self
        self.rootView?.tableView?.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.rootView?.tableView?.dequeueReusableCell(withIdentifier: reuseIdentifier)
        
        cell?.textLabel?.text = "some text"
        
        return cell!
    }
}
