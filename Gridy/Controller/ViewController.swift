//
//  ViewController.swift
//  Gridy
//
//  Created by James on 24/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var moves = 0
    var gridyBrain = GridyBrain()
    var shadowView = ShadowView()
    var palette = Palette()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(shadowView)
        
        gridyBrain.setup()
        gridyBrain.delegate = self
        
        for i in imageCollection {
            addPanGesture(view: i)
        }
        
        // Put the shuffled images onto the board
        
        for i in 0...gridyBrain.numberOfTiles - 1 {

            imageCollection[i].image = gridyBrain.imageTiles[i].image

        }
        
            newGameButton.layer.cornerRadius = 5
            gridyTitleLabel.font = UIFont(name: "TimeBurner", size: 38)
            gridyTitleLabel.adjustsFontForContentSizeCategory = true
            gridyTitleLabel.textColor = palette.gridyLightGreen
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        for i in backViews {
            
            i.layer.borderWidth = 1
            i.layer.borderColor = palette.gridyPink.cgColor
            
            i.removeAllConstraints()
        }
        
        for image in imageCollection {
            
            image.removeAllConstraints()
        }
        
        // Set up the board
        
        for (index,i) in viewCollection.enumerated() {
        
            i.addBorder(toEdges: [.left, .top], color: palette.gridyPink, thickness: 1)
            
            switch index {
            
            case 12...15:
            
                viewCollection[index].addBorder(toEdges: .bottom, color: palette.gridyPink, thickness: 1)
                
            case 3,7,11:
                
                viewCollection[index].addBorder(toEdges: .right, color: palette.gridyPink, thickness: 1)
                
            default:
                    break
            }

            viewCollection[15].addBorder(toEdges: [.bottom,.right], color: palette.gridyPink, thickness: 1)
        }
    }

    @IBOutlet var viewCollection: [UIView]!
    @IBOutlet var imageCollection: [UIImageView]!
    @IBOutlet var backViews: [UIView]!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var gridyTitleLabel: UILabel!
    @IBOutlet weak var score: UILabel!

    func addPanGesture(view: UIView) {

      let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
      view.addGestureRecognizer(pan)

    }

    @objc func handlePan(sender: UIPanGestureRecognizer) {

        let touchedImage = sender.view!
        let translation = sender.translation(in: view)

        switch sender.state {

        case .began, .changed:

            shadowView.alpha = 1
            touchedImage.center = CGPoint(x: touchedImage.center.x + translation.x, y: touchedImage.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            shadowView.frame = touchedImage.frame
            view.bringSubviewToFront(touchedImage)

        case .ended:

            gridyBrain.updateBrain(viewCollection: viewCollection, imageCollection: imageCollection, backViews: backViews, touchedImage: touchedImage)
            shadowView.alpha = 0

        default:
            break
        }
    }
}

extension ViewController: GridyBrainDelegate {

    func tileAndEmptyViewDidIntersect(tile: UIView, view: UIView) {

        tile.frame = view.frame
        moves += 1
        score.text = String(moves)
    }

    func didFinishGame() {

    let alert = UIAlertController.customAlertController(title: "Yay!", message: "Well done!")
    self.present(alert, animated: true) {
        
        }
    }
}

