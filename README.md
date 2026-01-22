# DAM Proyecto - Sistema de Gestión de Incidencias Informáticas

Proyecto de **Desarrollo de Aplicaciones Multiplataforma (DAM)** que implementa un completo sistema de gestión de incidencias informáticas para un centro educativo utilizando tecnologías de Microsoft 365.

## 📋 Descripción General

Este proyecto proporciona una solución integral para el registro, seguimiento y gestión de incidencias informáticas. El sistema permite crear, editar, visualizar y analizar incidencias, así como organizarlas por tipos, ubicaciones y técnicos asignados.

## 📁 Estructura del Proyecto

El proyecto se divide en tres módulos principales:

### 1. **Powershell/** 🔧

**Scripts de Administración y Automatización**

Contiene scripts PowerShell para crear y gestionar la infraestructura en SharePoint Online. Incluye:

- **00IncidenciasInformaticasMicrosoft365.ps1**: Script principal que crea toda la estructura de listas en SharePoint (técnicos, ubicaciones, tipos de incidencias e incidencias)
- **EjemploImportaDatos.ps1**: Script para importar datos masivamente desde archivos CSV
- **Archivos CSV de ejemplo**: Datos de prueba para ubicaciones e incidencias

**Características**:

- Creación automatizada de listas personalizadas
- Campos personalizados con validaciones
- Relaciones entre listas mediante Lookup
- Campos calculados automáticos
- Importación masiva de datos con manejo de fechas

**Uso**: Configuración inicial, mantenimiento y administración de la infraestructura en Microsoft 365. Solo para personal TIC.

**Acceso por usuarios**: Las listas de SharePoint pueden ser accedidas directamente o a través de Microsoft Forms para entrada de datos.

---

### 2. **PowerApps/** 📱

**Aplicación Multiplataforma en la Nube**

Contiene los archivos YAML que definen las pantallas de la aplicación PowerApps integrada con SharePoint Online. Incluye:

- **PantallaPrincipal**: Galería de incidencias con búsqueda, filtrado y ordenamiento
- **DetalleIncidencia**: Visualización completa de una incidencia individual
- **EdicionIncidencia**: Formulario para crear y editar incidencias

**Características**:

- Interfaz responsive optimizada para escritorio, tablet y móvil
- Integración con SharePoint Online para almacenamiento de datos
- Validación de campos obligatorios
- Sistema de estados con códigos de color
- Navegación intuitiva entre pantallas

**Uso**: Opción principal para usuarios finales. Aplicación web moderna accesible desde cualquier dispositivo con navegador.

**Alternativas de acceso para usuarios**:

- **SharePoint Lists**: Acceso directo a las listas de incidencias en SharePoint
- **Microsoft Forms**: Formularios simplificados para entrada rápida de nuevas incidencias

---

### 3. **PowerBI/** 📈

**Dashboard de Análisis y Visualización de Datos**

Contiene el dashboard de PowerBI para la visualización e análisis avanzado de incidencias. Incluye:

- **Dashboard de Incidencias Informáticas**: Visualización interactiva con métricas clave, gráficos y análisis en tiempo real

**Características**:

- Análisis visual de incidencias por tipo, ubicación y técnico
- Seguimiento de estados y tendencias
- Reportes interactivos
- Acceso desde navegador web

**Uso**: Proporciona una vista estratégica de las incidencias para gerencia y supervisores. Complementa los análisis de Access con visualizaciones modernas.

**Acceso**: [Dashboard de PowerBI - Incidencias Informáticas](https://app.powerbi.com/view?r=eyJrIjoiOThmOGQ1YTQtOTMwYi00M2ViLTg4NzItZTA3ZDI5NWI2MDRhIiwidCI6ImY3NjEzNDhlLTExZDYtNDMzYy05YmQwLTg0YjNiODc4MWJjYSIsImMiOjh9)

---

### 4. **MicrosoftAccess/** 📊

**Sistema de Base de Datos de Escritorio (Solo para Personal TIC)**

Contiene el código exportado de Microsoft Access que implementa la base de datos relacional para la gestión administrativa de incidencias. Incluye:

- **Formularios**: Interfaz de usuario para gestionar tipos de incidencias, ubicaciones y análisis de datos
- **Informes**: Reportes detallados de incidencias organizadas por tipo, ubicación y técnico
- **Consultas SQL**: Queries para análisis, auditoría e identificación de registros incompletos
- **Módulos VBA**: Funciones para exportar e importar automáticamente objetos de Access, permitiendo control de versiones

**Uso**: Herramienta exclusiva para personal TIC. Gestión administrativa, análisis profundo, reportes avanzados y mantenimiento de la base de datos.

---

## 🏗️ Arquitectura General

```text
┌──────────────────────────────────────────────────────────────────┐
│                      USUARIOS FINALES                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐            │
│  │   PowerApps  │  │  SharePoint  │  │    Forms     │            │
│  │              │  │    Lists     │  │              │            │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘            │
└─────────┼──────────────────┼────────────────┼────────────────────┘
          │                  │                │
    ┌─────▼──────────────────▼────────────────▼──────────┐
    │   SharePoint Online / Microsoft 365                   │
    │ (Listas: Incidencias, Técnicos, Ubicaciones, Tipos)│
    └──────┬─────────────────────────────────────────────┘
           │
           │  Sincronización / Consultas
           │  (Personal TIC)
           │
    ┌──────▼──────────────┐        ┌────────────────────┐
    │ Microsoft Access    │        │  PowerShell Scripts│
    │ (Análisis, Reports) │        │ (Admin, Automación)│
    │ (Solo Personal TIC) │        │ (Solo Personal TIC)│
    └─────────────────────┘        └────────────────────┘
```

## 🔄 Flujo de Datos

### Para Usuarios Finales

1. **Entrada de datos** → PowerApps, SharePoint Lists, o Microsoft Forms → SharePoint Online
2. **Visualización** → PowerApps, SharePoint Lists

### Para Personal TIC

1. **Configuración inicial** → PowerShell Scripts → SharePoint Online (Setup de listas)
2. **Administración** → Microsoft Access (análisis, reportes avanzados, mantenimiento)
3. **Importación masiva** → PowerShell Scripts → SharePoint Online (carga de datos)

## 🚀 Requisitos Previos

### Software
- **PowerShell** 5.1 o superior
- **Microsoft Access** 2016 o posterior
- **Navegador moderno** (Chrome, Edge, Safari)
- **Módulo PnP PowerShell**: `Install-Module SharePointPnPPowerShellOnline`

### Permisos
- Acceso a **SharePoint Online**
- Permisos de administrador en el sitio de SharePoint
- Credenciales de **Microsoft 365**

## 📚 Documentación Adicional

Para información detallada sobre cada módulo, consulta:
- [Powershell/README.md](Powershell/README.md) - Documentación de scripts PowerShell
- [PowerApps/README.md](PowerApps/README.md) - Documentación de la aplicación PowerApps
- [MicrosoftAccess/README.md](MicrosoftAccess/README.md) - Documentación de la base de datos Access

## 📝 Licencia

Proyecto académico de DAM

## 👤 Autor

Javier Terán

---

**Última actualización:** Enero 2026
