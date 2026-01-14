# Microsoft Access - Gestión de Incidencias Informáticas

Esta carpeta contiene el código exportado de los formularios e informes de Microsoft Access para el sistema de gestión de incidencias informáticas.

## 📋 Descripción

Los archivos en esta carpeta contienen el código fuente de los objetos de Microsoft Access exportados como texto plano. Esto permite el control de versiones y la documentación del diseño de la base de datos Access.

## 📁 Contenido

### Formularios (frm_)

#### `frm_0Principal.vba`
Formulario principal de la aplicación. Sirve como panel de control central para navegar entre las diferentes secciones del sistema.

#### `frm_ExportarImportar.vba`
Formulario para gestionar la exportación e importación de datos entre Access y otros formatos (CSV, Excel, etc.).

#### `frm_IncTipos.vba`
Formulario para la gestión de tipos de incidencias. Permite crear, editar y eliminar categorías de incidencias.

#### `frm_IncTiposIncidenciasSub.vba`
Subformulario asociado a `frm_IncTipos` que muestra las incidencias relacionadas con cada tipo.

#### `frm_IncUbicaciones.vba`
Formulario para la gestión de ubicaciones del centro educativo (aulas, departamentos, espacios comunes).

#### `frm_IncUbicacionesIncidenciasSub.vba`
Subformulario asociado a `frm_IncUbicaciones` que muestra las incidencias ocurridas en cada ubicación.

#### `frm_sql_FaltanDatos.vba`
Formulario asociado a la consulta `sql_FaltanDatos` para visualizar y gestionar incidencias con datos incompletos.

#### `frm_IncidenciasInformaticas_ALTA.vba`
Formulario para la creación y registro de nuevas incidencias informáticas en el sistema.

#### `fmr_IncidenciasInformaticas_NOCERRADAS.vba`
Formulario para visualizar y gestionar incidencias informáticas que se encuentran abiertas (no cerradas). Permite un seguimiento rápido de los casos pendientes.

### Informes (inf_)

#### `inf_IncTiposCompleto.vba`
Informe completo que muestra todos los tipos de incidencias con sus incidencias asociadas.

#### `inf_IncUbicacionesCompleto.vba`
Informe completo que muestra todas las ubicaciones con sus incidencias asociadas.

### Consultas SQL (sql_)

#### `sql_FaltanDatos.vba`
Consulta que identifica incidencias con datos incompletos:
- Incidencias sin duración (Duración = 0)
- Incidencias sin fecha de solución
- Incidencias sin técnico asignado
- Incidencias sin tipo de incidencia

#### `sql_tbl_IncAsignadoA.vba`
Consulta tipo "crear tabla" para la tabla de técnicos asignados.

#### `sql_tbl_IncAuditoria.vba`
Consulta tipo "crear tabla" para la tabla de auditoría de incidencias.

#### `sql_tbl_IncidenciasInformaticas.vba`
Consulta tipo "crear tabla" principal que define la estructura de la tabla de incidencias informáticas con todos sus campos.

#### `sql_IncidenciasInformaticas_NOCERRADAS.vba`
Consulta que selecciona todas las incidencias informáticas que están abiertas (no cerradas), útil para reportes de incidencias pendientes.

### Módulos (mod_)

#### `mod_ImportarExportar.vba`
Módulo VBA que contiene funciones para:
- **ExportarObjetosAccess**: Exporta automáticamente todos los objetos de Access (formularios, informes, consultas y módulos) a archivos `.vba` para control de versiones con Git
- **ImportarObjetosAccess**: Importa objetos desde archivos `.vba` a la base de datos Access
- Gestión de conversión de codificación UTF-8/UTF-16. Esto habría que revisarlo para que GIT no considere estos archivos como binarios.

## 🔧 Uso de los Archivos

### Importar a Microsoft Access

Para reconstruir la base de datos desde los archivos `.vba`:

1. Abrir Microsoft Access y crear una nueva base de datos
2. Presionar `Alt + F11` para abrir el Editor de VBA
3. Ir a **Archivo > Importar archivo...** o usar el módulo `mod_ImportarExportar`
4. Utilizar la función `ImportarObjetosAccess(Ruta)` del módulo para importar todos los objetos automáticamente
5. Los objetos se importarán a la base de datos

### Exportar desde Microsoft Access

Para actualizar los archivos del repositorio con cambios en Access:

1. Abrir la base de datos de Access
2. Usar el formulario `frm_ExportarImportar` o ejecutar directamente el módulo VBA
3. Ejecutar la función `ExportarObjetosAccess(Ruta)` del módulo `mod_ImportarExportar`
4. Todos los objetos se exportarán automáticamente como archivos `.vba`
5. Los archivos estarán listos para commit en Git

## 🏗️ Estructura del Sistema

```
Base de Datos Access
│
├── Formularios
│   ├── frm_0Principal (Menú principal)
│   ├── frm_ExportarImportar (Gestión de exportación/importación)
│   ├── frm_IncidenciasInformaticas_ALTA (Crear nuevas incidencias)
│   ├── fmr_IncidenciasInformaticas_NOCERRADAS (Gestión de incidencias abiertas)
│   ├── frm_IncTipos + frm_IncTiposIncidenciasSub
│   ├── frm_IncUbicaciones + frm_IncUbicacionesIncidenciasSub
│   └── frm_sql_FaltanDatos (Visualización de datos incompletos)
│
├── Informes
│   ├── inf_IncTiposCompleto
│   └── inf_IncUbicacionesCompleto
│
├── Consultas SQL
│   ├── sql_FaltanDatos (Identificar incidencias incompletas)
│   ├── sql_IncidenciasInformaticas_NOCERRADAS (Mostrar incidencias abiertas)
│   ├── sql_tbl_IncAsignadoA (Crear tabla técnicos)
│   ├── sql_tbl_IncAuditoria (Crear tabla auditoría)
│   └── sql_tbl_IncidenciasInformaticas (Crear tabla principal)
│
└── Módulos VBA
    └── mod_ImportarExportar (Exportar/Importar objetos para Git)
```

## 🔗 Relación con otros componentes

Este sistema de Microsoft Access complementa el sistema principal de SharePoint Online:

- **SharePoint Online**: Sistema principal de gestión de incidencias (ver scripts PowerShell en la raíz del proyecto)
- **Microsoft Access**: Herramienta local para análisis, reportes y gestión offline de datos
- **PowerApps**: Interfaz móvil para registro de incidencias (ver carpeta PowerApps)

## 📝 Notas Técnicas

- Los archivos `.vba` contienen código VBA y definiciones de objetos exportados desde Access
- Formato de exportación: Texto plano con codificación UTF-16
- Formato de versión: Access 2007 o superior (Version = 21)
- **Prefijos de nomenclatura**:
  - `frm_` identifica formularios
  - `inf_` identifica informes
  - `sql_` identifica consultas SQL
  - `mod_` identifica módulos VBA
- Los archivos incluyen definiciones de:
  - Propiedades del objeto
  - Controles y sus propiedades
  - Código VBA asociado
  - Configuración de diseño y layout
  - Consultas SQL y operaciones de base de datos

### Tipos de Consultas SQL

- **Operation = 1**: Consultas de selección (SELECT)
- **Operation = 2**: Consultas de creación de tabla (CREATE TABLE)
- Las consultas incluyen definiciones de campos, tablas de entrada y columnas de salida

## ⚠️ Consideraciones

- Estos archivos son exportaciones de texto de objetos de Access y no se ejecutan directamente
- Para utilizar estos componentes, deben importarse a una base de datos de Microsoft Access
- Se recomienda mantener una copia de seguridad de la base de datos antes de importar cambios
- El código VBA puede requerir referencias a librerías específicas de Microsoft Office

## 🔄 Control de Versiones

Los archivos en esta carpeta están bajo control de versiones Git para:
- Seguimiento de cambios en el diseño de formularios, informes y consultas
- Colaboración en el desarrollo
- Historial de modificaciones del código VBA
- Restauración de versiones anteriores si es necesario
- Integración continua y despliegue automatizado

### Flujo de trabajo con Git

1. Realizar cambios en la base de datos Access
2. Ejecutar `mod_ImportarExportar.ExportarObjetosAccess(Ruta)` para exportar todos los objetos
3. Los archivos `.vba` se actualizarán automáticamente
4. Hacer commit de los cambios en Git
5. Para restaurar: clonar repositorio y ejecutar `mod_ImportarExportar.ImportarObjetosAccess(Ruta)`

## 📚 Recursos Adicionales

- [Documentación oficial de Microsoft Access](https://support.microsoft.com/access)
- Ver `README.md` principal del proyecto para información completa del sistema
- Ver carpeta `PowerApps/` para componentes de aplicación móvil

## 🟩 Ejemplos de Código VBA

### Exportar todos los objetos Access para versionado con GIT

```vb
Public Sub ExportarObjetosAccess(Ruta As String)
    On Error GoTo Err_Global
    
    Dim obj As AccessObject
    Dim qdf As DAO.QueryDef
    
    ' Crear directorio si no existe
    If Dir(Ruta, vbDirectory) = "" Then
        MkDir Ruta
    End If
       
    ' Exportar formularios
    For Each obj In CurrentProject.AllForms
        Debug.Print "Exportando formulario: " & obj.Name
        SaveAsText acForm, obj.Name, Ruta & obj.Name & ".vba"
    Next obj
    
    ' Exportar informes
    For Each obj In CurrentProject.AllReports
        Debug.Print "Exportando informe: " & obj.Name
        SaveAsText acReport, obj.Name, Ruta & obj.Name & ".vba"
    Next obj
    
    ' Exportar módulos
    For Each obj In CurrentProject.AllModules
        Debug.Print "Exportando módulo: " & obj.Name
        SaveAsText acModule, obj.Name, Ruta & obj.Name & ".vba"
    Next obj
    
    ' Exportar consultas (excluyendo las del sistema)
    For Each qdf In CurrentDb.QueryDefs
        If Left(qdf.Name, 1) <> "~" And Left(qdf.Name, 4) <> "MSys" Then
            Debug.Print "Exportando consulta: " & qdf.Name
            Application.SaveAsText acQuery, qdf.Name, Ruta & qdf.Name & ".vba"
        End If
    Next qdf
    
    MsgBox "Exportación completada", vbInformation

Err_Global:
    MsgBox "Error: " & Err.Description, vbCritical
End Sub
```

### Importar todos los objetos Access desde archivos VBA

```vb
Public Sub ImportarObjetosAccess(Ruta As String)
    On Error GoTo Err_Global
    
    Dim strArchivo As String, strNombre As String
    Dim intContadorOK As Integer: intContadorOK = 0
    Dim intContadorError As Integer: intContadorError = 0
    Dim strErrores As String
    
    ' Validar si la carpeta existe
    If Dir(Ruta, vbDirectory) = "" Then
        MsgBox "La ruta especificada no existe.", vbCritical
        Exit Sub
    End If

    strArchivo = Dir(Ruta & "*.vba")

    Do While strArchivo <> ""
        strNombre = Replace(strArchivo, ".vba", "")
        
        ' Manejador de errores local para no detener el bucle
        On Error Resume Next
        
        ' Importar según el prefijo del nombre
        If Left(strNombre, 4) = "frm_" Then
            Application.LoadFromText acForm, strNombre, Ruta & strArchivo
        ElseIf Left(strNombre, 4) = "inf_" Then
            Application.LoadFromText acReport, strNombre, Ruta & strArchivo
        ElseIf Left(strNombre, 4) = "mod_" Then
            Application.LoadFromText acModule, strNombre, Ruta & strArchivo
        ElseIf Left(strNombre, 4) = "sql_" Then
            Application.LoadFromText acQuery, strNombre, Ruta & strArchivo
        Else
            GoTo SiguienteArchivo
        End If

        ' Verificar si hubo error en la carga
        If Err.Number <> 0 Then
            intContadorError = intContadorError + 1
            strErrores = strErrores & "- " & strArchivo & _
                        " (Error: " & Err.Description & ")" & vbCrLf
            Err.Clear
        Else
            intContadorOK = intContadorOK + 1
        End If
        
        On Error GoTo Err_Global
        
SiguienteArchivo:
        strArchivo = Dir()
    Loop

    ' Informe final
    MsgBox "Importación completada:" & vbCrLf & _
           "✓ Correctos: " & intContadorOK & vbCrLf & _
           "✗ Errores: " & intContadorError & vbCrLf & vbCrLf & _
           IIf(strErrores <> "", "Detalles de errores:" & vbCrLf & strErrores, ""), _
           IIf(intContadorError = 0, vbInformation, vbExclamation)
    
    Exit Sub

Err_Global:
    MsgBox "Error general: " & Err.Description, vbCritical
End Sub
```

### Uso de las funciones

```vb
' Exportar todos los objetos a la carpeta MicrosoftAccess
Call ExportarObjetosAccess("C:\Users\usuario\Documents\GitHub\DAMProyecto\MicrosoftAccess\")

' Importar todos los objetos desde la carpeta MicrosoftAccess
Call ImportarObjetosAccess("C:\Users\usuario\Documents\GitHub\DAMProyecto\MicrosoftAccess\")
```

---

**Última actualización:** Enero 2026