//
//  ArtistsViewController.swift
//  UNKO_Library
//
//  Created by 牧 良樹 on 2018/06/27.
//  Copyright © 2018年 牧 良樹. All rights reserved.
//

import UIKit
import MediaPlayer

class ArtistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
  
  @IBOutlet weak var list: UITableView!
  
  var artistList: [String:[MPMediaItem]] = [:]
  var albumList: [MPMediaItem] = []
  var nameList: [String] = []
  var passList : [MPMediaItem] = []
  var artistSong = "Song"
  var artistName = "Name"
  var passTitle = "渡したい値"
  var count = 0
  var _count = 0
  var player : MPMusicPlayerController?
  var passUrl : [MPMediaItemCollection] = []
  var selectUrl: [MPMediaItemCollection] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    list.delegate = self
    
    player = MPMusicPlayerController.applicationMusicPlayer()
    
    test()
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func test(){
    let artistsQuery = MPMediaQuery.artists()
    
    artistsQuery.addFilterPredicate(MPMediaPropertyPredicate(value: false, forProperty: MPMediaItemPropertyIsCloudItem))
    
    if let artists = artistsQuery.collections {
      
      passUrl = artists
      
      for artist in artists {
        
        for song in artist.items {
          
          _count += 1
          
          // アーティスト名
          guard let sTitle = song.value(forProperty: MPMediaItemPropertyAlbumTitle) else {
            continue
          }
          
          // アーティストの名前
          guard let aName = song.value(forProperty: MPMediaItemPropertyArtist) else {
            continue
          }
          
          artistSong = sTitle as! String
          artistName = aName as! String
          
          albumList.append(song)
        }
        
        artistList[artistName] = albumList
        nameList.append(artistName)
        albumList = []
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nameList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "td")
    cell.textLabel?.text = nameList[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectUrl = [passUrl[indexPath.row]]
    segueToSecondViewController()
  }
  
  func segueToSecondViewController() {
    self.performSegue(withIdentifier: "artistAlbumViewController", sender: selectUrl)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "artistAlbumViewController" {
      let _artistAlbumViewController = segue.destination as! artistAlbumViewController
      _artistAlbumViewController.selectUrl = sender as! [MPMediaItemCollection]
    }
  }
  
}

