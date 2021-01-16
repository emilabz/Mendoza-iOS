//
//  GameRoomTableView.swift
//  Game_Assignment1
//
//  Created by Emil Abraham Zachariah on 2020-02-12.
//  Copyright © 2020 Emil Abraham Zachariah. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit
class GameRoomTableView: UITableView,UITableViewDelegate,UITableViewDataSource {
    var items: [String] = [String]()
    var items2: [Int] = [Int]()
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setData(tnames: [String], tscores: [Int] ){
        items=tnames
        items2=tscores
        print("items-\(items[0]) items2-\(items2.count)")
    }
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("items.count = \(items.count)")
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = "\(self.items[indexPath.row])\t\t\t\(self.items2[indexPath.row])\n"
        cell.backgroundColor=UIColor.orange
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Name\t\tScore"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
