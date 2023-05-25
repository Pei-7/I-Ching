//
//  ViewController.swift
//  I Ching
//
//  Created by 陳佩琪 on 2023/5/24.
//

import UIKit

class ViewController: UIViewController {
    
//圖表
    let trigrams = Trigram.data
    let hexagrams = Hexagram.data
    
    let gramLabel = UILabel(frame: CGRect(x: 100, y: 555, width: 190, height: 150))
    let combinationLabel = UILabel(frame: CGRect(x: 100, y: 690, width: 190, height: 60))
    let baGuaImage = UIImageView(frame: CGRect(x: 87, y: 575, width: 216, height: 144))
    
    @IBOutlet var diagramView: UIView!
    
//卦象
    @IBOutlet var matchView: UIView!
    
    @IBOutlet var aboveTrigram: UILabel!
    @IBOutlet var lowerTrigram: UILabel!
    @IBOutlet var generatedHexagram: UILabel!
    @IBOutlet var generatedHexName: UILabel!
    @IBOutlet var generatedHexBrief: UILabel!
    var upperIndex = 0
    var lowerIndex = 0
    var hexIndex = 0
    var hexagramNumber = "000000"
    
    
    
    @IBOutlet var upperIcon: [UILabel]!
    @IBOutlet var lowerIcon: [UILabel]!
    @IBOutlet var hexIconView: UIView!
    
    @IBOutlet var gramsLables: [UILabel]!
    
    
//tab
    
    @IBOutlet var showTableButton: UIButton!
    @IBOutlet var showMatchButton: UIButton!
    
    
    
    
    let themeGray = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//圖表
        //首欄
        for (index,trigrams) in trigrams.enumerated() {
            let label = UILabel()
            label.text = trigrams.symbol
                        
            diagramView.addSubview(label)
            let positionY = 174 + 44 * index
            label.frame = CGRect(x: 6, y: positionY, width: 42, height: 42)
            label.textAlignment = .left
        }
        
        //首列
        for (index,trigrams) in trigrams.enumerated() {
            let label = UILabel()
            label.text = trigrams.symbol
            
            
            diagramView.addSubview(label)
            let positionX = 32 + 44 * index
            label.frame = CGRect(x: positionX, y: 134, width: 42, height: 42)
            label.textAlignment = .center
        }
        
        //表格內容
        var buttons = [UIButton()]
        let blackBottomView = UIView()
        diagramView.addSubview(blackBottomView)
        blackBottomView.frame = CGRect(x: 30, y: 172, width: 354, height: 354)
        blackBottomView.backgroundColor = UIColor.black
        
        for i in 0...7 {
            for j in 0...7 {
                let hexagramNumber = trigrams[j].number+trigrams[i].number
                let index = hexagrams.firstIndex(where: {$0.number == hexagramNumber})
                let string = hexagrams[index!].name
                
                let button = UIButton(type: .system, primaryAction: UIAction(handler: { [unowned self] action in
                    gramLabel.text = hexagrams[index!].hexagramImage
                    combinationLabel.text = hexagrams[index!].combination
                    gramLabel.isHidden = false
                    combinationLabel.isHidden = false
                    baGuaImage.isHidden = true
                }))
                
                
                button.setTitle(string, for: .normal)
                
                let positionX = 32 + 44 * j
                let positionY = 174 + 44 * i
                button.frame = CGRect(x: positionX, y: positionY, width: 42, height: 42)
                diagramView.addSubview(button)

                buttons.append(button)
                
            }
                        
        }
        
        for button in buttons {
            button.backgroundColor = themeGray
            button.tintColor = UIColor.black
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            
        }
        
        //下方說明
        diagramView.addSubview(gramLabel)
        diagramView.addSubview(combinationLabel)
        gramLabel.font = UIFont.systemFont(ofSize: 150)
        gramLabel.textAlignment = .center
        combinationLabel.font = UIFont.systemFont(ofSize: 30)
        combinationLabel.textAlignment = .center

        
        //預設圖形
        
        baGuaImage.image = UIImage(named: "bagua")
        diagramView.addSubview(baGuaImage)
        
        
//卦象
       
        generateHexagram()
        
        
        for icons in upperIcon {
            icons.isHidden = true
        }
        for icons in lowerIcon {
            icons.isHidden = true
        }
        hexIconView.isHidden = true
        
    }
    
    
    fileprivate func generateHexagram() {
        aboveTrigram.text = trigrams[upperIndex].trigramImage
        lowerTrigram.text = trigrams[lowerIndex].trigramImage
        hexagramNumber = trigrams[upperIndex].number+trigrams[lowerIndex].number
        hexIndex = hexagrams.firstIndex(where: {$0.number == hexagramNumber})!
        generatedHexagram.text = hexagrams[hexIndex].hexagramImage
        generatedHexName.text = hexagrams[hexIndex].combination
        generatedHexBrief.text = hexagrams[hexIndex].brief
        
        for icons in upperIcon {
            icons.text = trigrams[upperIndex].icon
        }
        for icons in lowerIcon {
            icons.text = trigrams[lowerIndex].icon
        }
    }

    
    func generateTrigram(hexagramNumber: String, index: Int){
        
        generatedHexagram.text = hexagrams[index].hexagramImage
        generatedHexName.text = hexagrams[index].combination
        generatedHexBrief.text = hexagrams[index].brief
        
        let aboveNumber = hexagramNumber.prefix(3)
        upperIndex = trigrams.firstIndex(where: {$0.number == aboveNumber})!
        aboveTrigram.text = trigrams[upperIndex].trigramImage
        
        
        let lowerNumber = hexagramNumber.suffix(3)
        lowerIndex = trigrams.firstIndex(where: {$0.number == lowerNumber})!
        lowerTrigram.text = trigrams[lowerIndex].trigramImage
        
        for icons in upperIcon {
            icons.text = trigrams[upperIndex].icon
        }
        for icons in lowerIcon {
            icons.text = trigrams[lowerIndex].icon
        }

    }
    
    
    @IBAction func shuffleHexagram(_ sender: UIButton) {
        let randomIndex = Int.random(in: 0...63)
        hexagramNumber = hexagrams[randomIndex].number
        
        generateTrigram(hexagramNumber: hexagramNumber, index: randomIndex)
    }
    
    
    @IBAction func upperPrevious(_ sender: UIButton) {
        upperIndex = (upperIndex + 8 - 1) % 8
        generateHexagram()
    }
    
    @IBAction func upperNext(_ sender: UIButton) {
        upperIndex = (upperIndex + 1) % 8
        generateHexagram()
    }
    
    
    @IBAction func lowerPrevious(_ sender: UIButton) {
        lowerIndex = (lowerIndex + 8 - 1) % 8
        generateHexagram()
    }
    
    
    @IBAction func lowerNext(_ sender: UIButton) {
        lowerIndex = (lowerIndex + 1) % 8
        generateHexagram()
    }
    
    @IBAction func hexPrevious(_ sender: UIButton) {
        hexIndex = hexagrams.firstIndex(where: {$0.number == hexagramNumber})!
        hexIndex = (hexIndex + 64 - 1) % 64
        hexagramNumber = hexagrams[hexIndex].number
        generateTrigram(hexagramNumber: hexagramNumber, index:hexIndex )
        
    }
    
    @IBAction func hexNext(_ sender: UIButton) {
        hexIndex = hexagrams.firstIndex(where: {$0.number == hexagramNumber})!
        hexIndex = (hexIndex + 1) % 64
        hexagramNumber = hexagrams[hexIndex].number
        generateTrigram(hexagramNumber: hexagramNumber, index:hexIndex )
    }
    
    
    

    @IBAction func fanGua(_ sender: UIButton) {
        let hexagramNumber = trigrams[upperIndex].number + trigrams[lowerIndex].number
        let reversedNumber = String(hexagramNumber.reversed())
        hexIndex = hexagrams.firstIndex(where: {$0.number == reversedNumber})!
        
        generateTrigram(hexagramNumber: reversedNumber, index: hexIndex)
        
    }
    
    
    @IBAction func exchange(_ sender: UIButton) {
        let tempIndex = upperIndex
        upperIndex = lowerIndex
        lowerIndex = tempIndex
        generateHexagram()
    }
    
    
    @IBAction func duiGua(_ sender: UIButton) {
        let hexagramNumber = trigrams[upperIndex].number + trigrams[lowerIndex].number
        let replacedNumber = hexagramNumber.replacingOccurrences(of: "0", with: "x").replacingOccurrences(of: "1", with: "0").replacingOccurrences(of: "x", with: "1")
        hexIndex = hexagrams.firstIndex(where: {$0.number == replacedNumber})!
        
        generateTrigram(hexagramNumber: replacedNumber, index: hexIndex)
        
    }
    
    @IBAction func showTableView(_ sender: UIButton) {
        diagramView.isHidden = false
        matchView.isHidden = true
        gramLabel.isHidden = true
        combinationLabel.isHidden = true
        baGuaImage.isHidden = false
        showTableButton.setImage(UIImage(systemName: "tablecells.fill"), for: .normal)
        showMatchButton.setImage(UIImage(systemName: "doc.text.below.ecg"), for: .normal)
    }
    
    @IBAction func showMatchView(_ sender: UIButton) {
        diagramView.isHidden = true
        matchView.isHidden = false
        upperIndex = 0
        lowerIndex = 0
        generateHexagram()
        showTableButton.setImage(UIImage(systemName: "tablecells"), for: .normal)
        showMatchButton.setImage(UIImage(systemName: "doc.text.below.ecg.fill"), for: .normal)
    }
    
    
    @IBAction func iconSegmentControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            for icons in upperIcon {
                icons.isHidden = true
            }
            for icons in lowerIcon {
                icons.isHidden = true
            }
            hexIconView.isHidden = true
            for grams in gramsLables {
                grams.isHidden = false
            }
        } else {
            for icons in upperIcon {
                icons.isHidden = false
                icons.text = trigrams[upperIndex].icon
            }
            for icons in lowerIcon {
                icons.isHidden = false
                icons.text = trigrams[lowerIndex].icon
            }
            hexIconView.isHidden = false
            for grams in gramsLables {
                grams.isHidden = true
            }
        }
        
    }
    
    
    
    
    
    
    
}

