/*
//Declaro la clase Participante
class Participante {
    //Declaro un atributo, cómo no tiene valor es OBLIGATORIO inicializarlo en el contructor (método init)
    var nombre: String;
    //Constructor que se invocará sin etiqueta el nombre del param (porque tiene guión bajo)
    init (_ nombre:String) { //Participante("Lalo")
        self.nombre = nombre;
    }
}
//Declaro la clase ListaParticipantes
class ListaParticipantes {
    //Declaramos atributos, cómo no tiene valor es OBLIGATORIO inicializarlo en el contructor (método init)
    var listaParticipantes:[Participante]
    var posicionJugadorEnTurno:Int
    var listaDesordenada:[Participante]
    //Constructor que se invocará sin etiqueta el nombre del param (porque tiene guión bajo)
    init (_ listaParticipantes:[Participante]) {//ListaParticipantes([Participante("Lalo")])
        //Recibimos cómo parámetro un arreglo de Participantes y lo asignamos al atributo "self.listaParticipantes"
        self.listaParticipantes = listaParticipantes
        //Iniciamos en 0 (el primer elemento de un arreglo) el juegador en turno
        self.posicionJugadorEnTurno = 0
        //La lista desordenada será un arreglo vacío
        self.listaDesordenada = []
        //Invocamos el método reiniciarPartida que mezcla los participantes y lo asigna a la lista desordenada
        self.reiniciarPartida()
    }
    //Método que agrega un participante al arreglo
    func agregarParticipante (_ nuevoParticipante:Participante) {
        //Método "append" que se encuentra en todos los arreglos, el param debe coincidir con el tipo del arreglo
        listaParticipantes.append(nuevoParticipante)
    }
    //Método que retorna el siguiente jugador en el arreglo desordenado y avanza en 1 la posición del jugador en turno
    func siguienteJugador() {
        //let siguienteJugador = self.listaParticipantes[self.posicionJugadorEnTurno]
        self.posicionJugadorEnTurno += 1
        //Sentencia "return" es OBLIGATORIA cuando un método especifica que retorna un dato (-> Participante), debe coincidir con el valor en la sentencia de return
       // return siguienteJugador
    }
    //Muestra el nombre del jugador en turno
    func mostrarJugadorEnTurno () {
        //En Swift en lugade concatenar cadenas, usamos la "Interpolación", donde dentro de la misma cadena especificamos el tipo de valor a mostrar con la siguiente \(nombre_variable) esto debe ir dentro de la comilla doble
        print("Jugador en turno \(self.listaDesordenada[self.posicionJugadorEnTurno].nombre)")
    }
    //Método que llena el arreglo "listaDesordenada" y lo mezcla
    func revolverJugadores() {
        listaDesordenada = []
        for participante in self.listaParticipantes {
            listaDesordenada.append(participante)
        }
        self.listaDesordenada.shuffle()
    }
    //Vuelve a inicializar en 0 el turno de jugador e invoca revolverJugadores()
    func reiniciarPartida() {
        self.posicionJugadorEnTurno = 0
        self.revolverJugadores()
    }
    func isNotUltimoParticipante() -> Bool {
        return self.posicionJugadorEnTurno != self.listaDesordenada.count - 1
    }
}
//Define un enumerador para los tipos de paneles
enum TipoPanel {
    case Sol
    case Aguila
    case Invalido
}

class Tablero {
    var listaPanelesTemplados:[TipoPanel]
    var posicionPeldaño:Int
    //Declaramos atributos, cómo no tiene valor es OBLIGATORIO inicializarlo en el contructor (método init)
    init (_ totalParticpantes:Int) {
        self.listaPanelesTemplados = []
        self.posicionPeldaño = 0
        self.iniciarPartida(totalParticpantes)
    }
    //Constructor que se invocará SIN etiqueta el nombre del param (porque tiene guión bajo)
    func iniciarPartida (_ totalParticpantes:Int) {
        self.listaPanelesTemplados = []
        self.posicionPeldaño = 0
        self.generarListaPanelesTempladosAleatorios(totalParticpantes)
    }
    //Generamos una lista de paneles del tamaño total de participantes multiplicado por 3
    func generarListaPanelesTempladosAleatorios (_ totalParticpantes:Int) {
        //Variable axuliar para el ciclo while
        var indice = 0
        //Ciclo "while" que se repetirá el total de jugadores por 3
        while (indice < (totalParticpantes * 3)) {
            //for index in 1...(totalParticpantes * 3) {
            //Insertamos de forma aleatoria el valor del panel
            if (Bool.random()) {
                self.listaPanelesTemplados.append(TipoPanel.Sol)
            } else {
                self.listaPanelesTemplados.append(TipoPanel.Aguila)
            }
            //Aumentamos en uno, IMPORTANTE que este dentro del "while" y fuera de "if" o "else"
            indice += 1
        }
    }
    //Método que retorna si el usuario acerto (resultado true) al panel templado y avanza al siguiente peldaño
    func seleccionarPanel(eleccionUsuario:TipoPanel) -> Bool{
        //Comparamos la elección del usuario con la posición del panel actual en la "listaPanelesTemplados"
        let resultadoEleccionParticipante = eleccionUsuario == listaPanelesTemplados[posicionPeldaño]
        
        return resultadoEleccionParticipante
    }
    //Avanzamos un peldaño (posicionPeldaño más 1)
    func avanzarPeldaño () {
        self.posicionPeldaño += 1
    }
    //Mostramos la lista de paneles templados
    func mostrarListaPanelesTemplados() {
        for panel in self.listaPanelesTemplados {
            print("Panel \(panel)")
        }
    }
    func isNotUltimoPeldaño() -> Bool {
        
        return self.posicionPeldaño != self.listaPanelesTemplados.count - 1
        
    }
  func mostrarPeldañoActual(){
    print("El peldaño actual es el \(self.posicionPeldaño)")
  }
}
//Clase controlador que orquestará la lógica de los objetos Tablero y ListaParticipantes
class ControladorJuegoVidrios {
    var tablero:Tablero
    var listaParticipantes:ListaParticipantes
    //Recibe un objeto de tipo ListaParticipantes que NO ES IGUAL a un arreglo de participantes
    init (_ listaParticipantes:ListaParticipantes) {
        self.listaParticipantes = listaParticipantes
        self.tablero = Tablero(listaParticipantes.listaParticipantes.count)
    }
    //Solicita al usuario que ingrese una opción para el que considera es el Panel templado
    func solicitarOpcionParticipante() -> TipoPanel {
        print("Ingrese una opción Sol [S] - Aguila [A]: ")
        //La función readLine() puede capturar cadenas del teclado, y retornar el resultado en ese mismo tipo de dato
        let opcion = readLine()
        var resultadoSeleccionJugador:Bool = false
        //Si el usuario selecciona "S" invocaremos el método seleccionarPanel() con TipoPanel.Sol
        if (opcion == "S") {
            resultadoSeleccionJugador = self.tablero.seleccionarPanel(eleccionUsuario: .Sol)
            print("Resultado selección usuario: \(resultadoSeleccionJugador)")
            return .Sol
            //Si el usuario selecciona "A" invocaremos el método seleccionarPanel() con TipoPanel.Aguila
        } else { //Opcion=='A'
            resultadoSeleccionJugador = self.tablero.seleccionarPanel(eleccionUsuario: .Aguila)
            print("Resultado selección usuario: \(resultadoSeleccionJugador)")
            return .Aguila
        }        //Mostramos el resultado
        
        
    }
    
    func evaluarOpcionParticipante(_ seleccionParticipanteParam: TipoPanel) -> Bool {
        return tablero.seleccionarPanel(eleccionUsuario: seleccionParticipanteParam)
        
    }
  func jugar(){
    
    repeat {
      self.listaParticipantes.mostrarJugadorEnTurno() //Mensaje para indicar a quien le toca
      //self.tablero.mostrar
      if(!self.evaluarOpcionParticipante(self.solicitarOpcionParticipante())){ // Si la opcion elegida es incorrecta y por ende el participante no acertó, entonces realizamos las sentencias dentro del condicional
        self.listaParticipantes.siguienteJugador() // Pasamos al siguiente jugador de nuestra lista
        print("No Avanza jugador")
      } else {
        
        print("Avanza jugador")
      }
      self.tablero.avanzarPeldaño() //Avanzamos un lugar del tablero
      self.tablero.mostrarPeldañoActual()
    } while(self.tablero.isNotUltimoPeldaño() && self.listaParticipantes.isNotUltimoParticipante()) //Mientras no hayamos llegado al final del tablero y haya más participantes realizamos las sentencias dentro del ciclo
  
  }
}
//Creamos un objeto de tipo Participante
var arregloJugadores:[Participante] = [
    Participante("Participante 1"),
    Participante("Participante 2"),
    Participante("Participante 3"),
    Participante("Participante 4")
]
//Creamos un objeto de tipo ControladorJuegoVidrios, en la misma línea crea un objeto de ListaParticipantes(arregloJugadores) y lo manda como parámetro
var controlador = ControladorJuegoVidrios(ListaParticipantes(arregloJugadores))
//Invocamos el método mostrarListaPanelesTemplados() a través del atributo tablero del objeto controlador
controlador.tablero.mostrarListaPanelesTemplados();
//Invocamos el método mostrarJugadorEnTurno() a través del atributo listaParticipantes del objeto controlador
controlador.jugar()
//controlador.listaParticipantes.mostrarJugadorEnTurno()

//controlador.solicitarOpcionParticipante()
*/



