//
//  ViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2017/10/09.
//  Copyright © 2017年 牧 良樹. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var songsTable: UITableView!
    var artistList:[String] = []
    var artistText = String()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        songsTable.dataSource = self    //追加
        songsTable.delegate = self // 追加
        
        test()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func test(){
        
        let artistQuery = MPMediaQuery.artists()
        
        artistQuery.addFilterPredicate(MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem))

        if let artists = artistQuery.collections {
            for artist in artists {
                for song in artist.items {
                    
                    // アーティスト名
                    guard let _artist = song.value(forProperty: MPMediaItemPropertyArtist) else {
                        continue
                    }
                    
                    // 楽曲のタイトル
                    guard let title = song.value(forProperty: MPMediaItemPropertyTitle) else {
                        continue
                    }

                    // 楽曲のタイトル
                    guard let albumTitle = song.value(forProperty: MPMediaItemPropertyAlbumTitle) else {
                        continue
                    }
                    artistText = _artist as! String
                }
                
                artistList.append(artistText)
                //print(artistList)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artistList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
        cell.textLabel?.text = artistList[indexPath.row]
        return cell
    }

}

