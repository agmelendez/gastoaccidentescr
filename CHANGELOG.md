# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato está basado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/),
y este proyecto adhiere a [Semantic Versioning](https://semver.org/lang/es/).

## [2.0.0] - 2026-01-08

### 🔒 Seguridad (Security)

#### Agregado
- **Content Security Policy (CSP)**: Implementación completa para prevenir ataques XSS
- **Headers de Seguridad HTTP**:
  - `X-Frame-Options: SAMEORIGIN` (protección clickjacking)
  - `X-Content-Type-Options: nosniff` (prevención MIME sniffing)
  - `X-XSS-Protection: 1; mode=block` (protección XSS)
  - `Referrer-Policy: strict-origin-when-cross-origin` (control de información)
- **Archivo .htaccess**: Configuración completa de seguridad para Apache
  - Deshabilitación de listado de directorios
  - Protección de archivos sensibles
  - Prevención de inyección SQL en URLs
  - Compresión y cache optimizado
  - Rate limiting básico
- **nginx-security.conf**: Configuración de seguridad para Nginx
  - Configuración SSL/TLS recomendada
  - Rate limiting avanzado
  - Protección contra ataques comunes
- **SECURITY.md**: Política de seguridad completa
  - Proceso de reporte de vulnerabilidades
  - Clasificación de severidad
  - Contactos de seguridad
  - Buenas prácticas
- **security.txt**: Archivo estándar RFC 9116
  - Ubicado en raíz y en /.well-known/
  - Contactos de seguridad
  - Política de divulgación
- **robots.txt**: Configuración SEO y seguridad
  - Bloqueo de bots maliciosos
  - Protección de directorios sensibles

### 📚 Documentación

#### Agregado
- **README.md completo**: Documentación exhaustiva del proyecto
  - Descripción detallada del proyecto
  - Estructura del repositorio
  - Guías de instalación y despliegue
  - Metodología de cálculo de indicadores
  - Principales hallazgos y estadísticas
  - Instrucciones de uso
  - Información de contacto
- **CHANGELOG.md**: Historial de cambios del proyecto

### 🎨 Mejoras Visuales y Funcionales

#### Agregado
- **Meta tags SEO**: Optimización para motores de búsqueda
  - Description, keywords, author
  - Open Graph para redes sociales
  - Meta tags de robots
- **Sección de Indicadores Principales**: Nueva sección explicativa
  - AVPP (Años de Vida Potencialmente Perdidos)
  - AVD (Años Vividos con Discapacidad)
  - Impacto Económico
- **Sección de Datos Relevantes**: Estadísticas clave destacadas
  - Récord histórico 2023
  - AVPP del año 2023
  - Porcentaje de casos en motocicletas

#### Mejorado
- **HTML semántico**: Estructura mejorada y validada
- **Accesibilidad**: Mejoras en estructura y navegación
- **Responsive design**: Optimización para dispositivos móviles

### 🔧 Configuración

#### Agregado
- Configuración de compresión (gzip/deflate)
- Configuración de cache de navegador
- Protección contra hotlinking
- Timeouts y límites optimizados
- Charset UTF-8 configurado correctamente

### 📊 Datos

#### Actualizado
- Datos actualizados hasta 2025
- Estadísticas consolidadas 2011-2025
- Indicadores principales calculados

## [1.0.0] - 2025

### Agregado
- Lanzamiento inicial del portal web
- Página principal (index.html) con información básica
- Estructura de directorios del proyecto
- Datos de accidentes de tránsito 2011-2024
- Cálculos de AVPP y AVD
- Análisis de costos económicos
- Scripts de análisis en R
- Documentación técnica

### Características Iniciales
- Portal informativo básico
- Estructura HTML con CSS inline
- Información institucional
- Objetivos del proyecto
- Datos estadísticos básicos

---

## Tipos de Cambios

- **Agregado** (Added): Nuevas características
- **Cambiado** (Changed): Cambios en funcionalidad existente
- **Deprecado** (Deprecated): Características que se eliminarán pronto
- **Eliminado** (Removed): Características eliminadas
- **Corregido** (Fixed): Corrección de bugs
- **Seguridad** (Security): Mejoras de seguridad

## Enlaces

- [Repositorio del Proyecto](https://github.com/usuario/gastoaccidentescr)
- [Política de Seguridad](SECURITY.md)
- [README](README.md)
- [Universidad de Costa Rica](https://www.ucr.ac.cr/)

---

**Mantenido por**: Universidad de Costa Rica - Observatorio del Desarrollo
**Última actualización**: 2026-01-08
