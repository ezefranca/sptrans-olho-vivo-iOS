//
//  SPTransOlhoVivo.swift
//  InstaAPI
//
//  Created by Ezequiel on 1/28/16.

import Foundation
import Alamofire

class SPTransOlhoVivo {
    
    let BASE_URL_SPTRANS = "http://api.olhovivo.sptrans.com.br/v0"
    let TOKEN = "cfd03d518181527ab8211864f0a436a705118b731569502a6420b7c0228daa4d"
    
    func autenticar(){
        Alamofire.request(.POST, BASE_URL_SPTRANS + "/Login/Autenticar?token=" + TOKEN)
            .response { response in
                print(response)  // original URL request
        }
    }
    
    func buscarDetalheLinha(termosBusca: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        genericGET("/Linha/Buscar?termosBusca=" + termosBusca, completionHandler: completionHandler)
    }
    
    func carregarDetalhesLinha(codigoLinha: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        genericGET("/Linha/CarregarDetalhes?codigoLinha=" + codigoLinha, completionHandler: completionHandler)
    }
    
    func buscarParada(termosBusca: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        genericGET("/Parada/Buscar?termosBusca=" + termosBusca, completionHandler: completionHandler)
    }
    
    func buscarParadaPorLinha(codigoLinha: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        genericGET("/Parada/BuscarParadasPorLinha?codigoLinha=" + codigoLinha, completionHandler: completionHandler)
    }
    
    func pegarPosicaoOnibus(codigoLinha: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        genericGET("/Posicao?codigoLinha=" + codigoLinha, completionHandler: completionHandler)
    }
    
    func pegarTempoDeChegadaDeUmOnibusNaParada(codigoLinha: String, codigoParada: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        genericGET("/Previsao?codigoParada=" + codigoParada + "&codigoLinha=" + codigoLinha, completionHandler: completionHandler)
    }
    
    func pegarTemposDeChegadaParada(codigoParada: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        genericGET("/Previsao/Parada?codigoParada=" + codigoParada, completionHandler: completionHandler)
    }
    
    
    func genericGET(url: String, completionHandler: (AnyObject?, NSError?) -> ()) {
        
        Alamofire.request(.GET, BASE_URL_SPTRANS + url)
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    print(value)
                    completionHandler(value as? AnyObject, nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
}