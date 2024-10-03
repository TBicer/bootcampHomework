//
//  ViewController.swift
//  Homework6
//
//  Created by Tunay Biçer on 2.10.2024.
//

import UIKit

class ListenNow: UIViewController {
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var recentCollectionView: UICollectionView!
    
    var newsList = [News]()
    var recentAlbumList = [Album]()
    var periodsAlbumList = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsCollectionView.dataSource = self
        newsCollectionView.delegate = self
        
        recentCollectionView.dataSource = self
        recentCollectionView.delegate = self
        
        setupLists()
        designCells()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named: "LabelPrimary")!]
        
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            
            appearance.backgroundColor = UIColor(named: "BgChrome")
            
            let selectedColor = UIColor(named: "IconSelected")
            let normalColor = UIColor(named: "LabelSecondary")
            
            changeTabBarItemAppearance(itemAppearance: appearance.stackedLayoutAppearance, selectedColor: selectedColor, normalColor: normalColor)
            changeTabBarItemAppearance(itemAppearance: appearance.inlineLayoutAppearance, selectedColor: selectedColor, normalColor: normalColor)
            changeTabBarItemAppearance(itemAppearance: appearance.compactInlineLayoutAppearance, selectedColor: selectedColor, normalColor: normalColor)
            
            // TabBar görünümünü ayarlıyoruz
            tabBarController?.tabBar.standardAppearance = appearance
            if #available(iOS 15.0, *) {
                tabBarController?.tabBar.scrollEdgeAppearance = appearance
            }
        } else {
            tabBarController?.tabBar.tintColor = UIColor(named: "IconSelected")
        }
        
        
        
    }
    
    func changeTabBarItemAppearance(itemAppearance: UITabBarItemAppearance, selectedColor: UIColor?, normalColor: UIColor?) {
        itemAppearance.selected.iconColor = selectedColor
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor!]
        
        itemAppearance.normal.iconColor = normalColor
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor!]
    }
    
    
    func setupLists(){
        let n1 = News(id: 1, headline: "NEW ALBUM", title: "Locatelli: il virtuoso, il poeta (Violin Concertos & Concerti Grossi)", image: "news-1")
        let n2 = News(id: 1, headline: "EXCLUSIVE ALBUM", title: "Debussy: Three Nocturnes – Berlioz: Symphonie Fantastique (Live)", image: "news-2")
        let n3 = News(id: 1, headline: "FEATURED PLAYLIST", title: "Classical Motivation", image: "news-3")
        let n4 = News(id: 1, headline: "WORLD PREMIERE RECORDING", title: "Bernstein: Music for String Quartet", image: "news-4")
        newsList.append(n1)
        newsList.append(n2)
        newsList.append(n3)
        newsList.append(n4)
        
        let a1 = Album(id: 1, title: "Classical Motivation", image: "classical-motivation")
        let a2 = Album(id: 2, title: "Pure Piano", image: "pure-piano")
        let a3 = Album(id: 3, title: "The Works", image: "the-works")
        let a4 = Album(id: 4, title: "Classical Edge", image: "classical-edge")
        let a5 = Album(id: 5, title: "Child Prodigies", image: "child-prodigies")
        let a6 = Album(id: 6, title: "Classical Sleep", image: "classical-sleep")
        recentAlbumList.append(a1)
        recentAlbumList.append(a2)
        recentAlbumList.append(a3)
        recentAlbumList.append(a4)
        recentAlbumList.append(a5)
        recentAlbumList.append(a6)
        
    }
    
    func designCells(){
        let newsCellDesign = UICollectionViewFlowLayout()
        newsCellDesign.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 0, right: 20)
        newsCellDesign.minimumInteritemSpacing = 11
        newsCellDesign.itemSize = CGSize(width: 353, height: 315)
        newsCellDesign.scrollDirection = .horizontal
        newsCollectionView.collectionViewLayout = newsCellDesign
        
        let recentCellDesign = UICollectionViewFlowLayout()
        recentCellDesign.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        recentCellDesign.minimumInteritemSpacing = 11
        recentCellDesign.itemSize = CGSize(width: 171, height: 195)
        recentCellDesign.scrollDirection = .horizontal
        recentCollectionView.collectionViewLayout = recentCellDesign
    }

}

extension ListenNow : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
            case 1:
                return newsList.count
            case 2:
                return recentAlbumList.count
            default:
                return 0
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
                let news = newsList[indexPath.row]
                
                cell.healineLabel.text = news.headline
                cell.titleLabel.text = news.title
                cell.newsImageView.image = UIImage(named: news.image!)
                
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as! AlbumCell
                let album = recentAlbumList[indexPath.row]
                    
                cell.albumImageView.image = UIImage(named: album.image!)
                cell.albumTitleLabel.text = album.title
                
                return cell
            default:
                return UICollectionViewCell()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = newsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        let estimatedIndex = targetContentOffset.pointee.x / cellWidthIncludingSpacing
        let index = round(estimatedIndex)
        
        targetContentOffset.pointee = CGPoint(x: index * cellWidthIncludingSpacing, y: 0)
    }
}
