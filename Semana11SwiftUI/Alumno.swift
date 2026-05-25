
import Foundation
import SwiftData

@Model
final class Alumno: Identifiable {
    var idAlumno: UUID
    var apellido: String
    var nombre: String
    var dni: String
    // Optional photo data for the alumno (stored as binary data)
    var foto: Data?

    var id: UUID { idAlumno }

    init(idAlumno: UUID = UUID(), apellido: String, nombre: String, dni: String, foto: Data? = nil) {
        self.idAlumno = idAlumno
        self.apellido = apellido
        self.nombre = nombre
        self.dni = dni
        self.foto = foto
    }
}
