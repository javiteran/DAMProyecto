Option Compare Database
Option Explicit

'Public Const Ruta As String = "W:\Educación\DistanciaAGL\Proyecto\DAMProyecto\MicrosoftAccess\"
'Public Const Ruta As String = "D:\Educación\DistanciaAGL\Proyecto\Fase4\Codigo\"

'Exportar todos los objetos Access para poder hacer versionado con GIT
Public Sub ExportarObjetosAccess(Ruta As String)
    On Error GoTo Err_Global
    
    Dim obj As AccessObject
    Dim qdf As DAO.QueryDef
    
    If Dir(Ruta, vbDirectory) = "" Then
        MkDir Ruta
    End If
       
    ' Exportar formularios
    For Each obj In CurrentProject.AllForms
        Debug.Print "Exportando formulario: " & obj.Name
        SaveAsText acForm, obj.Name, Ruta & obj.Name & ".vba"
        'ConvertUTF16ToUTF8 Ruta & obj.Name & ".vba"
    Next obj
    
    ' Exportar informes
    For Each obj In CurrentProject.AllReports
        Debug.Print "Exportando informe: " & obj.Name
        SaveAsText acReport, obj.Name, Ruta & obj.Name & ".vba"
        'ConvertUTF16ToUTF8 Ruta & obj.Name & ".vba"
    Next obj
    
    ' Exportar módulos
    For Each obj In CurrentProject.AllModules
        Debug.Print "Exportando informe: " & obj.Name
        SaveAsText acModule, obj.Name, Ruta & obj.Name & ".vba"
        'ConvertUTF16ToUTF8 Ruta & obj.Name & ".vba"
    Next obj
    
    For Each qdf In CurrentDb.QueryDefs
        If Left(qdf.Name, 1) <> "~" And Left(qdf.Name, 4) <> "MSys" Then
            Application.SaveAsText acQuery, qdf.Name, Ruta & qdf.Name & ".vba"
            'ConvertUTF16ToUTF8 Ruta & qdf.Name & ".vba"
        End If
    Next qdf
    
    MsgBox "Exportación completada", vbInformation

Err_Global:
    MsgBox "Error: " & Err.Description, vbCritical
End Sub

'Importar todos los objetos Access para poder hacer versionado con GIT

Sub ImportarObjetosAccess(Ruta As String)
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
        
        ' Usamos un manejador de errores local para no detener el bucle
        On Error Resume Next
        
        If Left(strNombre, 4) = "frm_" Then
            Application.LoadFromText acForm, strNombre, Ruta & strArchivo
        ElseIf Left(strNombre, 4) = "inf_" Then
            Application.LoadFromText acReport, strNombre, Ruta & strArchivo
        ElseIf Left(strNombre, 4) = "mod_" Then
            Application.LoadFromText acModule, strNombre, Ruta & strArchivo
        Else
            ' Caso opcional: archivos que no cumplen el patrón
            GoTo SiguienteArchivo
        End If

        ' Verificar si hubo error en la carga de este archivo específico
        If Err.Number <> 0 Then
            intContadorError = intContadorError + 1
            strErrores = strErrores & "- " & strArchivo & " (Error: " & Err.Description & ")" & vbCrLf
            Err.Clear
        Else
            intContadorOK = intContadorOK + 1
        End If
        
        On Error GoTo Err_Global ' Volver al control general
        
SiguienteArchivo:
        strArchivo = Dir()
    Loop

    ' Informe final
    MsgBox "Proceso finalizado." & vbCrLf & _
           "Exitosos: " & intContadorOK & vbCrLf & _
           "Errores: " & intContadorError, vbInformation
           
    If strErrores <> "" Then
        Debug.Print "DETALLE DE ERRORES:" & vbCrLf & strErrores
        MsgBox "Hubo errores en algunos archivos. Revisa la ventana Inmediato (Ctrl+G) para ver los detalles.", vbInformation
    End If

    Exit Sub

Err_Global:
    MsgBox "Error: " & Err.Description, vbCritical
End Sub

' Para que suba a git en UTF8
Private Sub ConvertUTF16ToUTF8(filePath As String)
    Dim inS As Object, outS As Object
    Set inS = CreateObject("ADODB.Stream")
    Set outS = CreateObject("ADODB.Stream")

    With inS
        .Type = 2
        .Charset = "unicode"      ' UTF-16 LE
        .Open
        .LoadFromFile filePath
    End With

    With outS
        .Type = 2
        .Charset = "utf-8"
        .Open
        .WriteText inS.ReadText
        .Position = 0
        .Type = 1
        .SaveToFile filePath, 2    ' Sobrescribir
    End With

    inS.Close: outS.Close
End Sub


Private Sub ConvertUTF8ToUTF16(src As String, dst As String)
    Dim inS As Object, outS As Object
    Set inS = CreateObject("ADODB.Stream")
    Set outS = CreateObject("ADODB.Stream")

    With inS
        .Type = 2: .Charset = "utf-8": .Open: .LoadFromFile src
    End With
    With outS
        .Type = 2: .Charset = "unicode": .Open
        .WriteText inS.ReadText
        .Position = 0: .Type = 1: .SaveToFile dst, 2
    End With
    inS.Close: outS.Close
End Sub

'===================================================================================
'Copiar tablas vinculadas en Local
'===================================================================================

Sub ConvertirTodasLasTablasVinculadas()
    Dim db As DAO.Database
    Dim td As DAO.TableDef

    Set db = CurrentDb

    For Each td In db.TableDefs
        If td.Connect <> "" And Left(td.Name, 4) <> "MSys" Then
            ConvertirTablaVinculadaEnLocal td.Name
        End If
    Next td
End Sub

Sub ConvertirTablaVinculadaEnLocal(NombreTabla As String)
    Dim db As DAO.Database
    Dim td As DAO.TableDef
    Dim stringSQL As String

    Set db = CurrentDb
    Set td = db.TableDefs(NombreTabla)

    ' Comprobar que es una tabla vinculada
    If td.Connect = "" Then
        MsgBox "La tabla no está vinculada", vbExclamation
        Exit Sub
    End If
    stringSQL = "SELECT * INTO " & NombreTabla & "_Local FROM [" & NombreTabla & "]"
    ' 1?? Copiar estructura + datos como tabla local
    'db.Execute "SELECT * INTO " & NombreTabla & "_Local FROM [" & NombreTabla & "]", dbFailOnError
    db.Execute stringSQL, dbFailOnError

    ' 2?? Eliminar la tabla vinculada
    'db.TableDefs.Delete NombreTabla

    ' 3?? Renombrar la tabla local con el nombre original
    'db.TableDefs(NombreTabla & "_Local").Name = NombreTabla

    MsgBox "Tabla convertida en local correctamente", vbInformation
End Sub