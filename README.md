# Aplicacion Flutter Web para subir archivos

Aplicacion web para registrar y listar Usuarios y Documentos (Archivos), es una aplicacion que esta configurada con BLOC para la gestion de estados
y para la organizacion de los archivos y carpetas se esta usando CLEAN ARQUITECTURE

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

### Descripción de la aplicación Flutter
1. Usuarios

    
2. Documentos 
