#$credential = get-credential
connect-pnponline -url https://educantabria.sharepoint.com/sites/IESAlisalDatos/DAMProyecto -Credential $credential

$QueLista       = "IncUbicaciones"
###############################################################################
#Bucle para añadir Ubicaciones a partir de un excel 
###############################################################################
Write-Host "       Cargar datos Inicio Ubicaciones" -ForegroundColor yellow -BackgroundColor red
$ejemplo=Import-Csv EjemploUbicaciones.csv -Delimiter ';' 

foreach ($fila in $ejemplo){ 
    Add-PnPListItem -List $QueLista -Values @{             
        "Title"                     =	$fila.Title
        ; "UbicacionCompleta"    =	$fila.UbicacionCompleta
    }
}

$QueLista       = "IncInformaticas"
###############################################################################
#Bucle para añadir incidencias Informáticas a partir de un excel 
###############################################################################
Write-Host "       Cargar datos Ejemplo Incidencias Informaticas " -ForegroundColor yellow -BackgroundColor red
$ejemplo=Import-Csv EjemploIncidenciasInformaticas.csv -Delimiter ';' 

foreach ($fila in $ejemplo){ 
    Add-PnPListItem -List $QueLista -Values @{             
        "Title"                     =	$fila.Title
        ; "DescripIncidencia"       =	$fila.DescripIncidencia
        ; "FechaIncidencia"         =   [datetime]::parseexact($fila.FechaIncidencia,'d/M/yyyy', $null).ToString("yyyy-MM-dd hh:mm:ss")
        ; "Ubicacion"               =	$fila.UbicacionId
        ; "Prioridad"               =	$fila.Prioridad
        ; "NumSerieConsejeria"      =	$fila.NumSerieConsejeria
        ; "IncidenciaAsignadaA"     =	$fila.IncidenciaAsignadaAId
        ; "TipoIncidencia"          =	$fila.TipoIncidenciaId
        ; "Estado"                  =	$fila.Estado
        ; "FechaSolucion"           =   [datetime]::parseexact($fila.FechaSolucion,'d/M/yyyy', $null).ToString("yyyy-MM-dd hh:mm:ss")
        ; "DescripSolucion"         =	$fila.DescripSolucion
        ; "Duracion"                =	$fila.Duracion
        ; "LlamadaServicioTecnico"  =	$fila.LlamadaServicioTecnico
        ; "FechaLlamadaServTecnico" =   [datetime]::parseexact($fila.FechaLlamadaServTecnico,'d/M/yyyy', $null).ToString("yyyy-MM-dd hh:mm:ss")
    }
}
Write-Host "       Cargar datos Fin Incidencias Informaticas" -ForegroundColor yellow -BackgroundColor red