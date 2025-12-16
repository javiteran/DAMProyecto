# DAM Proyecto - Sistema de Gestión de Incidencias Informáticas

Proyecto de Desarrollo de Aplicaciones Multiplataforma para la gestión de incidencias informáticas en un centro educativo mediante SharePoint Online.

## 📋 Descripción

Este proyecto permite crear y gestionar un sistema de incidencias informáticas utilizando SharePoint Online (Microsoft 365) mediante PowerShell y el módulo PnP. El sistema incluye la creación automatizada de listas, campos personalizados y la importación masiva de datos desde archivos CSV utilizando varias listas de Sharepoint para ello.

## 🗂️ Estructura del Proyecto

### Scripts PowerShell

#### 1. `00IncidenciasInformaticasOffice365.ps1`

Script principal que crea toda la estructura de listas en SharePoint Online:

- **IncTecnico**: Lista de técnicos asignados
- **IncUbicaciones**: Lista de ubicaciones del centro
- **IncTipos**: Lista de tipos de incidencias
- **IncInformaticas**: Lista principal de incidencias informáticas

**Características:**

- Crea listas con campos personalizados (texto, fecha, lookup, calculados, etc.)
- Establece relaciones entre listas mediante campos Lookup
- Configura campos calculados (ej: cálculo automático del curso escolar)
- Define valores por defecto y descripciones para los campos

#### 2. `EjemploImportaDatos.ps1`

Script para importar datos desde archivos CSV a las listas de SharePoint.
Script de ejemplo simplificado para importar datos de prueba desde archivos CSV de ejemplo.

**Características:**

- Importa ubicaciones desde `EjemploUbicaciones.csv`
- Importa incidencias desde `EjemploIncidenciasInformaticas.csv`
- Gestiona conversión de fechas con formato español (dd/MM/yyyy)
- Soporta múltiples formatos de fecha: `dd/MM/yyyy`, `d/M/yyyy`, `dd-MM-yyyy`, `d-M-yyyy`

### Archivos de Datos

#### `EjemploUbicaciones.csv`

Archivo CSV con ubicaciones del centro educativo (62 ubicaciones):

- Aulas (102-109, 202-205)
- Departamentos (Ciencias, Informática, Idiomas, etc.)
- Espacios comunes (Biblioteca, Gimnasio, Salón de Actos, etc.)

**Formato:**

```csv
Id;Title;UbicacionCompleta
1;Aula102;Aula 102
2;Biblioteca;Biblioteca
```

#### `EjemploIncidenciasInformaticas.csv`

Archivo CSV con incidencias informáticas de ejemplo (278 registros):

**Campos incluidos:**

- `Id`: Identificador único
- `Title`: Asunto/título de la incidencia
- `DescripIncidencia`: Descripción detallada
- `FechaIncidencia`: Fecha de la incidencia (formato dd/MM/yyyy)
- `UbicacionId`: ID de la ubicación
- `Prioridad`: 1-Media, 2-Alta, 3-Baja
- `NumSerieConsejeria`: Número de serie del equipo
- `IncidenciaAsignadaAId`: ID del técnico asignado
- `TipoIncidenciaId`: ID del tipo de incidencia
- `Estado`: Nuevo, En Progreso, En Espera, Cerrado
- `FechaSolucion`: Fecha de resolución
- `DescripSolucion`: Descripción de la solución aplicada
- `Duracion`: Tiempo en minutos
- `LlamadaServicioTecnico`: VERDADERO/FALSO
- `FechaLlamadaServTecnico`: Fecha de llamada al servicio técnico

## 🚀 Requisitos Previos

### Software Necesario

- PowerShell 5.1 o superior
- Módulo SharePointPnPPowerShellOnline

### Instalación del Módulo PnP

```powershell
Install-Module SharePointPnPPowerShellOnline
```

### Permisos

- Acceso a SharePoint Online
- Permisos de administrador en el sitio de SharePoint
- Credenciales de Office 365

## 📦 Configuración

### URL del Sitio SharePoint

Todos los scripts están configurados para conectarse a:

```html
https://educantabria.sharepoint.com/sites/IESAlisalDatos/DAMProyecto
```

Para usar en tu propio sitio, modifica esta URL en los scripts.

## 🔧 Uso

### 1. Crear la Estructura de Listas

Ejecuta el script principal para crear todas las listas y campos:

```powershell
.\00IncidenciasInformaticasOffice365.ps1
```

Este script:

1. Solicita credenciales de Office 365
2. Se conecta al sitio de SharePoint
3. Crea las listas: IncTecnico, IncUbicaciones, IncTipos, IncInformaticas
4. Añade campos personalizados a cada lista
5. Configura relaciones entre listas
6. Establece valores por defecto

### 2. Importar Datos desde CSV

Después de crear la estructura, importa los datos:

```powershell
.\EjemploImportaDatos.ps1
```

## 📊 Estructura de Datos

### Lista: Incidencias Informáticas

| Campo | Tipo | Descripción | Obligatorio |
|-------|------|-------------|-------------|
| Asunto (Title) | Texto | Descripción corta de la incidencia | Sí |
| Descripción Incidencia | Texto largo | Descripción detallada | Sí |
| Fecha Incidencia | Fecha | Fecha de la incidencia | Sí |
| Ubicación | Lookup | Lugar donde ocurre la incidencia | Sí |
| Prioridad | Opción | 1-Media, 2-Alta, 3-Baja | No |
| Nº Serie Consejería | Texto | Número de serie del equipo | No |
| Incidencia Asignada A | Lookup | Técnico asignado | No |
| Tipo Incidencia | Lookup | Categoría de la incidencia | No |
| Estado | Opción | Nuevo, En Progreso, En Espera, Cerrado | No |
| Fecha Solución | Fecha | Fecha de resolución | No |
| Descripción Solución | Texto largo | Solución aplicada | No |
| Duración (min) | Número | Tiempo de resolución en minutos | No |
| Llamada Servicio Técnico | Sí/No | Indica si se llamó al servicio técnico | No |
| Fecha Llamada | Fecha | Fecha de llamada al servicio técnico | No |
| Curso | Calculado | Curso escolar (calculado automáticamente) | - |

### Campo Calculado: Curso

El campo "Curso" se calcula automáticamente según la fecha de la incidencia:

- Si la incidencia es antes de septiembre: año anterior/año actual
- Si la incidencia es desde septiembre: año actual/año siguiente

**Fórmula:**

```powershell
=IF(MONTH([Fecha Incidencia])<9,YEAR([Fecha Incidencia])-1&"/"&YEAR([Fecha Incidencia]),YEAR([Fecha Incidencia])&"/"&YEAR([Fecha Incidencia])+1)
```

## 🔍 Formatos de Fecha

Los scripts aceptan fechas en formato español con los siguientes patrones:

- `dd/MM/yyyy` (ejemplo: 08/02/2018)
- `d/M/yyyy` (ejemplo: 8/2/2018)
- `dd-MM-yyyy` (ejemplo: 08-02-2018)
- `d-M-yyyy` (ejemplo: 8-2-2018)

## 📝 Ejemplos de Uso

### Conectarse a SharePoint

```powershell
$credential = Get-Credential
Connect-PnPOnline -Url https://educantabria.sharepoint.com/sites/IESAlisalDatos/DAMProyecto -Credential $credential
```

### Importar Ubicaciones

```powershell
$QueLista = "IncUbicaciones"
$ejemplo = Import-Csv EjemploUbicaciones.csv -Delimiter ';'

foreach ($fila in $ejemplo) {
    Add-PnPListItem -List $QueLista -Values @{
        "Title" = $fila.Title
        "UbicacionCompleta" = $fila.UbicacionCompleta
    }
}
```

### Importar Incidencias

```powershell
$QueLista = "IncInformaticas"
$ejemplo = Import-Csv EjemploIncidenciasInformaticas.csv -Delimiter ';'

foreach ($fila in $ejemplo) {
    Add-PnPListItem -List $QueLista -Values @{
        "Title" = $fila.Title
        "DescripIncidencia" = $fila.DescripIncidencia
        "FechaIncidencia" = [datetime]::ParseExact($fila.FechaIncidencia,'d/M/yyyy', $null)
        "Ubicacion" = $fila.UbicacionId
        "Prioridad" = $fila.Prioridad
        # ... más campos
    }
}
```

## 🛠️ Solución de Problemas

### Error: "Unable to access the site"

Verifica:

- Que tienes permisos en el sitio de SharePoint
- Que la URL del sitio es correcta
- Que tus credenciales de Office 365 son válidas

## 📚 Referencias

- [SharePoint PnP PowerShell](https://docs.microsoft.com/en-us/powershell/module/sharepoint-pnp/)
- [Trabajar con listas de SharePoint Online usando PnP PowerShell](https://channel9.msdn.com/Blogs/MVP-Azure/Work-with-SharePoint-Online-lists-with-PNP-PowerShell)
- [Opciones de campos de SharePoint](https://msdn.microsoft.com/en-us/library/office/aa979575.aspx)
- [Fórmulas de campos calculados](https://msdn.microsoft.com/es-es/library/office/bb862071(v=office.14).aspx)

## 👥 Autor

Proyecto desarrollado por Javier Terán para fines educativos en el contexto del curso de Desarrollo de Aplicaciones Multiplataforma (DAM).

## 📄 Licencia

Este proyecto está diseñado para uso educativo en el contexto de Desarrollo de Aplicaciones Multiplataforma.
