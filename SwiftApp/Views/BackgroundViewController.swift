//
//  BackgroundViewController.swift
//  SwiftApp
//
//  Created by Viktor van Hulle on 28/08/2023.
//

import UIKit

class BackgroundViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addOvalGradientLayers()
        addGradientBackground()
        // Do any additional setup after loading the view.
    }
    
    private func addGradientBackground() {
         let gradientLayer = CAGradientLayer()
         gradientLayer.colors = [UIColor(hex: "#FFEDE1").cgColor, UIColor(hex: "#D7F9FF").cgColor]
         gradientLayer.locations = [0.0, 1.0] // Customize your gradient locations
         gradientLayer.frame = view.bounds
         view.layer.insertSublayer(gradientLayer, at: 0)
     }
    
    private func addOvalGradientLayers() {
        let numberOfOvals = 5

        for i in 0..<numberOfOvals {
            let ovalLayer = createOvalGradientLayer(index: i, totalOvals: numberOfOvals)
            view.layer.insertSublayer(ovalLayer, at: 0)
        }
    }

    private func createOvalGradientLayer(index: Int, totalOvals: Int) -> CALayer {
        let ovalLayer = CAGradientLayer()
        //ovalLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor] // Custom gradient colors
        ovalLayer.colors = [UIColor(hex: "#FFEDE1").cgColor, UIColor.white.cgColor] // Custom gradient colors
        ovalLayer.locations = [0.0, 1.0] // Custom gradient locations

        let ovalWidth = view.bounds.width * 0.5
        let ovalHeight = view.bounds.height * 0.5
        let ovalX = -ovalWidth / 2.0 + CGFloat(index) * view.bounds.width / CGFloat(totalOvals - 1)
        let ovalY = -ovalHeight / 2.0 + view.bounds.height * CGFloat(index) / CGFloat(totalOvals - 1)

        ovalLayer.frame = CGRect(x: ovalX, y: ovalY, width: ovalWidth, height: ovalHeight)
        ovalLayer.cornerRadius = ovalHeight / 2.0 // oval shape

        return ovalLayer
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// UIColor extension to create colors from hex values
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgb & 0x0000FF) / 255.0,
                  alpha: 1.0)
    }
}

