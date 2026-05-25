import SwiftUI
import SwiftData
import PhotosUI
import UIKit

struct NuevoAlumnoView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var apellido = ""
    @State private var nombre = ""
    @State private var dni = ""
    @State private var photoItem: PhotosPickerItem?
    @State private var selectedImageData: Data?

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Datos del Alumno")) {
                    TextField("Apellido", text: $apellido)
                    TextField("Nombre", text: $nombre)
                    TextField("DNI", text: $dni)
                        .keyboardType(.numberPad)
                    HStack {
                        PhotosPicker(selection: $photoItem, matching: .images, photoLibrary: .shared()) {
                            if let data = selectedImageData, let ui = UIImage(data: data) {
                                Image(uiImage: ui)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 72, height: 72)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } else {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.secondary.opacity(0.1))
                                        .frame(width: 72, height: 72)
                                    Image(systemName: "photo")
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        Text("Foto (opcional)")
                            .foregroundColor(.secondary)
                    }
                }

                Button("Guardar Alumno") {
                    let nuevoAlumno = Alumno(apellido: apellido, nombre: nombre, dni: dni, foto: selectedImageData)
                    modelContext.insert(nuevoAlumno)
                    do {
                        try modelContext.save()
                    } catch {
                        print("Error al guardar alumno: \(error)")
                    }
                    dismiss()
                }
                .disabled(apellido.isEmpty || nombre.isEmpty || dni.isEmpty)
            }
            .navigationTitle("Nuevo Alumno")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") { dismiss() }
                }
            }
            .onChange(of: photoItem) { newItem in
                Task {
                    if let item = newItem {
                        do {
                            if let data = try await item.loadTransferable(type: Data.self) {
                                await MainActor.run {
                                    selectedImageData = data
                                }
                            }
                        } catch {
                            print("Error loading image: \(error)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NuevoAlumnoView()
}

