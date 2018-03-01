//: Playground - noun: a place where people can play

import UIKit

protocol Receptor : class {
    associatedtype TipoMensaje
    func recibir(mensaje:TipoMensaje)
}

protocol Remitente {
    associatedtype TipoMensaje
    associatedtype TipoReceptor:Receptor
    
    var destinatarios:[TipoReceptor] { get }
    
    func send(mensaje:TipoMensaje)
}

// El programador es el que recibe el mensaje
class GenericReceptor : Receptor {
    
    typealias TipoMensaje = String
    
    func recibir(mensaje: String) {
        print("acaba de recibir el siguiente mensaje \(mensaje)")
    }
}

class Programador : GenericReceptor {
    let name:String = "Randall"
    
    override func recibir(mensaje:String) {
        print("El Programador \(name) acaba de recibir el siguiente mensaje \(mensaje)")
    }
}

class Diseñador : GenericReceptor {
    let name:String = "Marlon"
    
    override func recibir(mensaje:String) {
        print("El Diseñador \(name) acaba de recibir el siguiente mensaje \(mensaje)")
    }
}


final class MensajeMediador : Remitente {
    
    internal var destinatarios:[GenericReceptor] = []
    
    func agrega(destinatario:GenericReceptor){
        destinatarios.append(destinatario)
    }
    
    func send(mensaje:String) {
        for destinatario in destinatarios {
            destinatario.recibir(mensaje: mensaje)
        }
    }
}

func spamMonster(mensaje: String, run: MensajeMediador) {
    run.send(mensaje: mensaje)
}

let mensajeMediador = MensajeMediador()

let user0 = Programador()
//let user1 = Diseñador(name: "Avadis 'Avie' Tevanian")
let user2 = Diseñador()
mensajeMediador.agrega(destinatario: user0)
mensajeMediador.agrega(destinatario: user2)

spamMonster(mensaje: "Hola", run: mensajeMediador)






