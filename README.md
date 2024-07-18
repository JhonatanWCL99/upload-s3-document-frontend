# Aplicación Flutter Web para subir archivos

Aplicación web para registrar y listar usuarios y documentos (archivos). 
Utiliza BLoC para la gestión de estados y sigue los principios de la Arquitectura Limpia (Clean Architecture) para una estructura modular y mantenible.

## Capturas de Pantalla de Aplicacion

![image](https://github.com/user-attachments/assets/62808e6c-369b-408f-ad99-d63534f3623d)

![image](https://github.com/user-attachments/assets/9ad8dea7-b79b-4fd0-a200-73467e2d34d3)

## Arquitectura de la Aplicacion

```
📁core
    └── 📁screens
        └── home_screen.dart
    └── 📁services
        └── http_service.dart
📁features
    └── 📁documents
        └── 📁data
            └── 📁data_sources
                └── abstract_document_api.dart
                └── document_impl_api.dart
        └── 📁domain
            └── 📁dtos
                └── create_document_model.dart
            └── 📁models
                └── document_model.dart
            └── 📁usecases
                └── add_document_use_case.dart
                └── get_documents_use_case.dart
        └── 📁presentation
            └── 📁blocs
                └── document_bloc.dart
                └── document_event.dart
                └── document_state.dart
            └── 📁screens
                └── document_screen.dart
            └── 📁widgets
                └── add_document_modal.dart
                └── documents_datatable.dart
    └── 📁users
        └── 📁data
            └── 📁data_sources
                └── abstract_user_api.dart
                └── user_impl_api.dart
        └── 📁domain
            └── 📁models
                └── user_model.dart
            └── 📁usecases
                └── add_user_use_case.dart
                └── get_users_use_case.dart
        └── 📁presentation
            └── 📁blocs
                └── user_bloc.dart
                └── user_event.dart
                └── user_state.dart
            └── 📁screens
                └── user_screen.dart
            └── 📁widgets
                └── add_user_modal.dart
                └── users_datatable.dart
main.dart
config.dart
```

## Instrucciones para ejecutar localmente la aplicacion

### Instalación
1. Clona el repositorio en tu máquina local:
   ```bash
   git clone https://github.com/JhonatanWCL99/upload-s3-document-frontend
   
2. Navega al directorio del proyecto:
   ```bash
   cd upload-s3-document-frontend

3. Instala las dependencias:
   ```bash
   flutter pub get

4. Ejecutar la aplicacion en el navegador:
    ```bash
    flutter run
