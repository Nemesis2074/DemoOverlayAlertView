//
//  ViewController.swift
//  DemoAlerts
//
//  Created by Adair de Jesús Castillo Meza on 4/10/19.
//  Copyright © 2019 Adair Castillo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var inputDirection: UISegmentedControl!
    @IBOutlet weak var inputType: UIPickerView!
    @IBOutlet weak var inputAlwaysVisible: UISwitch!
    
    // Listado de tipos de alertas que puede mostrar un OverlayAlert
    private var types:[OverlayAlertView.AlertType] = OverlayAlertView.AlertType.allAsArray()
    
    private var selectedDirection:OverlayAlertView.AlertDirection = .GoDown
    private var selectedType:OverlayAlertView.AlertType = .Info
    private var alwasVisible:Bool = false
    
    // Controlador de alertas que se encarga de mostra las alertas en pantalla.
    private lazy var alertsController:OverlayAlertsController = {
        return OverlayAlertsController(insideView: self.view,
                                       belowView: nil,
                                       direction: .GoDown,
                                       style: .Default,
                                       margin: Styles.SizeConstants.StatusBarSize)
    }()
    
    
    private func initComponents(){
        inputType.dataSource = self
        inputType.delegate = self
    }
    
    // Cambia la dirección en que se muestran las alertas.
    @IBAction func changeDirection(){
        if(inputDirection.selectedSegmentIndex == 0){
            selectedDirection = .GoDown
            alertsController.changeDirection(to: .GoDown)
        }else{
            selectedDirection = .GoUp
            alertsController.changeDirection(to: .GoUp)
        }
    }
    
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        self.alwasVisible = inputAlwaysVisible.isOn
        
        // Mensaje a mostrar en la alerta.
        let message = "Dirección: \(selectedDirection), Tipo: \(selectedType), Siempre Visible: \(alwasVisible)"
        
        // Se muestra la alerta con la configuración seleccionada en pantalla.
        alertsController.showAlert(message, ofType: selectedType, alwaysVisible: inputAlwaysVisible.isOn)
    }
    
    @IBAction func hideAlert(_ sender: UIButton) {
        // Oculta la alerta. Si esta ya está oculta, no ocurre nada.
        alertsController.hideAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(types[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = types[row]
        
    }

}

