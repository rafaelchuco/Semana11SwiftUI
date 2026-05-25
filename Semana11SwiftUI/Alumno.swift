import Foundation
import SwiftData

@Model
final class Alumno: Identifiable {
    var idAlumno: UUID
    var apellido: String
    var nombre: String
    var dni: String

    var id: UUID { idAlumno }

    init(idAlumno: UUID = UUID(), apellido: String, nombre: String, dni: String) {
        self.idAlumno = idAlumno
        self.apellido = apellido
        self.nombre = nombre
        self.dni = dni
    }
}
