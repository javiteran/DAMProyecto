# PowerApps - Incidencias Informáticas

Este directorio contiene los archivos YAML que definen las pantallas de la aplicación PowerApps para gestión de incidencias informáticas.

## Archivos

### 1. PantallaPrincipal.yaml

**Descripción:** Pantalla principal de la aplicación que muestra el listado de incidencias.

**Funcionalidades:**

- **Galería de Incidencias (GaleriaInc):** Muestra todas las incidencias en formato de lista con:
  - Asunto de la incidencia
  - Descripción completa
  - Estado (con código de colores: Rojo=Nuevo, Azul=En progreso, Amarillo=En espera, Verde=Cerrado)
  - Ubicación
  - Fecha de incidencia

- **Barra de búsqueda (TextSearchBox1):** Permite filtrar incidencias por texto en el asunto

- **Toggle NoCerradas:** Alterna entre:
  - Mostrar todas las incidencias
  - Mostrar solo incidencias no cerradas (Nuevo, En progreso, En espera)

- **Botones de acción:**

  - **Actualizar (IconRefresh1):** Refresca la lista de incidencias
  - **Ordenar (IconSortUpDown1):** Ordena por fecha de forma ascendente/descendente
  - **Nueva incidencia (IconNewItem1):** Abre el formulario para crear una nueva incidencia

- **Navegación:** Al seleccionar una incidencia, navega a la pantalla de detalle

### 2. DetalleIncidencia.yaml

**Descripción:** Pantalla de visualización detallada de una incidencia seleccionada.

**Funcionalidades:**

- **Visualización completa:** Muestra todos los campos de la incidencia seleccionada:
  - Asunto
  - Descripción de la incidencia
  - Fecha de incidencia
  - Creado por
  - Ubicación
  - Nº Serie Consejería
  - Estado
  - Tipo de incidencia
  - Prioridad
  - Asignado a
  - Descripción de la solución
  - Duración (minutos)
  - Días de antigüedad
  - Fecha de solución

- **Botones de acción:**

  - **Volver (IconBackarrow1):** Regresa a la pantalla principal
  - **Editar (IconEdit1):** Abre el formulario de edición para la incidencia actual
  - **Eliminar (IconDelete1):** Elimina la incidencia (con permisos requeridos)

- **FormularioDetalleInc:** Formulario en modo lectura que presenta todos los datos

### 3. EdicionIncidencia.yaml

**Descripción:** Pantalla de edición y creación de incidencias.

**Funcionalidades:**

- **Formulario de edición (FormularioEdicionInc):** Permite crear nuevas incidencias o editar existentes con los siguientes campos:
  - **Asunto:** Campo de texto obligatorio
  - **Descripción Incidencia:** Campo de texto extendido
  - **Fecha Incidencia:** Selector de fecha obligatorio
  - **Ubicación:** Lista desplegable obligatoria
  - **Nº Serie Consejería:** Campo de texto opcional
  - **Estado:** Lista desplegable obligatoria (Nuevo, En progreso, En espera, Cerrado)
  - **Tipo Incidencia:** Lista desplegable
  - **Prioridad:** Lista desplegable
  - **Asignado A:** Lista desplegable para asignar responsable
  - **Descripción Solución:** Campo de texto extendido
  - **Duración (Minutos):** Campo numérico
  - **Fecha Solución:** Selector de fecha

- **Botones de acción:**
  - **Cancelar (IconCancel1):** Cancela la operación y regresa a la pantalla anterior
  - **Enviar (IconAccept1):** Guarda los cambios y regresa a la pantalla anterior

- **Validación:** El formulario valida campos obligatorios y formatos de datos antes de permitir el envío

## Flujo de Navegación

```
PantallaPrincipal
    ├── Ver detalle → DetalleIncidencia
    │                     ├── Volver → PantallaPrincipal
    │                     └── Editar → EdicionIncidencia
    │
    └── Nueva incidencia → EdicionIncidencia
                              └── Enviar/Cancelar → PantallaPrincipal
```

## Colores del Tema

- **Color principal:** Verde (#36B04B / RGBA(54, 176, 75, 1))
- **Color secundario:** Azul oscuro (#00126B / RGBA(0, 18, 107, 1))
- **Colores de estado:**
  - Rojo: Nuevo
  - Azul: En progreso
  - Amarillo: En espera
  - Verde: Cerrado

## Origen de Datos

Todos los formularios y galerías se conectan a la fuente de datos de SharePoint:

- **Lista:** `Incidencias Informáticas`
