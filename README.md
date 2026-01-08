# Impacto Económico y en la Salud Pública de los Accidentes de Tránsito en Costa Rica

[![Universidad de Costa Rica](https://img.shields.io/badge/UCR-Observatorio%20del%20Desarrollo-003087)](https://www.ucr.ac.cr/)
[![Estado](https://img.shields.io/badge/Estado-Activo-success)](https://github.com)
[![Licencia](https://img.shields.io/badge/Licencia-UCR-blue)](https://www.ucr.ac.cr/)

## 📋 Descripción del Proyecto

Este repositorio contiene el portal web y los datos de investigación sobre el **impacto económico y en la salud pública de los accidentes de tránsito en Costa Rica**, desarrollado como parte de una práctica profesional en la **Escuela de Estadística** de la Universidad de Costa Rica, en colaboración con el **Centro de Investigación Observatorio del Desarrollo**.

El proyecto analiza y documenta tres indicadores clave para el período 2011-2025:

1. **Años de Vida Potencialmente Perdidos (AVPP)**
2. **Años Vividos con Discapacidad (AVD)**
3. **Costo de atención como porcentaje del PIB**

## 🎯 Objetivos

- **Análisis Estadístico**: Recopilación y análisis de datos sobre accidentes de tránsito en Costa Rica
- **Impacto Económico**: Evaluación de los costos económicos asociados a los accidentes viales
- **Salud Pública**: Estudio del impacto en el sistema de salud y la población
- **Políticas Públicas**: Generar información para la toma de decisiones en seguridad vial

## 📊 Principales Hallazgos

### Años de Vida Potencialmente Perdidos (AVPP)

- **2023**: Récord histórico con **936 fallecidos** y **42,120 AVPP**
- **Tendencia**: Incremento sostenido de 30,510 AVPP (2011) a 42,120 AVPP (2023)
- **Población más afectada**: Hombres jóvenes entre 20-35 años
- **Impacto COVID-19**: Reducción significativa en 2020 (13,500 AVPP)

### Años Vividos con Discapacidad (AVD)

- **Rango anual**: 5,400-7,500 años vividos con discapacidad
- **Causas principales**: Accidentes en motocicleta (67% de casos críticos)
- **Tasa de discapacidad**: 15% de heridos graves desarrollan discapacidad permanente
- **Promedio**: 20 años vividos con discapacidad por persona afectada

### Impacto Económico

- **Porcentaje del PIB**: Entre 1.8% y 2.8% anual
- **Costo total 2011-2025**: Aproximadamente ₡13.8 billones
- **Componentes principales**:
  - Atención médica: 40%
  - Pérdida de productividad: 35%
  - Congestión vehicular: 25%

## 🗂️ Estructura del Proyecto

```
gastoaccidentescr/
│
├── index.html                    # Página principal del portal
├── README.md                     # Este archivo
├── SECURITY.md                   # Política de seguridad
├── .htaccess                     # Configuración de seguridad Apache
│
├── AVPP y AVAP/                  # Cálculos de indicadores
│   ├── indicadores-accidentes-transito-CR-2011-2025.md
│   ├── resumen_consolidado_accidentes_transito_2011_2025.csv
│   └── accidentes_transito_costa_rica.csv
│
├── BICIMOTOS/                    # Datos de bicimotos y vehículos
│   ├── COMEX/                    # Datos de comercio exterior
│   └── REGISTRO NACIONAL/        # Estadísticas de registro
│
├── CALCULOS/                     # Scripts y análisis estadísticos
│   ├── BASES DISCAPACITADOS/     # Datos de discapacitados
│   ├── COSTOS/                   # Modelos de costos
│   ├── ENCUESTAS/                # Análisis de encuestas (ENIGH, ENAHO)
│   ├── FALLECIDOS EN SITIO/      # Datos de fallecidos
│   └── INDICADORES/              # Cálculo de AVPP y AVD
│
├── DATOS/                        # Datos fuente
│   ├── COSEVI/                   # Datos del Consejo de Seguridad Vial
│   └── Documentos de manejo de datos/
│
├── Costos Atención/              # Documentación médica y costos
└── LECTURAS/                     # Material bibliográfico
```

## 🚀 Cómo Usar Este Proyecto

### Requisitos Previos

- Navegador web moderno (Chrome, Firefox, Safari, Edge)
- Para análisis de datos: R/RStudio con los paquetes necesarios
- Servidor web (Apache/Nginx) para despliegue en producción

### Visualización Local

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/usuario/gastoaccidentescr.git
   cd gastoaccidentescr
   ```

2. **Abrir el archivo HTML**:
   - Opción 1: Doble clic en `index.html`
   - Opción 2: Usar un servidor local
     ```bash
     # Python 3
     python -m http.server 8000

     # PHP
     php -S localhost:8000
     ```

3. **Acceder en el navegador**:
   ```
   http://localhost:8000
   ```

### Despliegue en Producción

#### Apache

1. Copiar archivos al directorio del servidor:
   ```bash
   sudo cp -r * /var/www/html/gastoaccidentes/
   ```

2. Configurar permisos:
   ```bash
   sudo chown -R www-data:www-data /var/www/html/gastoaccidentes/
   sudo chmod -R 755 /var/www/html/gastoaccidentes/
   ```

3. El archivo `.htaccess` incluye configuraciones de seguridad automáticas

#### Nginx

Agregar a la configuración del servidor:

```nginx
server {
    listen 80;
    server_name tu-dominio.com;
    root /var/www/html/gastoaccidentes;
    index index.html;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

## 🔒 Seguridad

Este proyecto implementa múltiples capas de seguridad:

### Implementaciones de Seguridad

1. **Content Security Policy (CSP)**
   - Prevención de ataques XSS
   - Control de recursos externos
   - Políticas estrictas de scripts

2. **Headers de Seguridad HTTP**
   - `X-Frame-Options`: Protección contra clickjacking
   - `X-Content-Type-Options`: Prevención de MIME type sniffing
   - `X-XSS-Protection`: Protección adicional contra XSS
   - `Referrer-Policy`: Control de información de referencia

3. **Configuración de Servidor**
   - `.htaccess` con reglas de seguridad para Apache
   - Configuración nginx recomendada
   - Deshabilitación de listado de directorios

4. **Validación de Datos**
   - Estructura HTML5 semántica
   - Validación de formularios (si aplica)
   - Sanitización de entradas

### Reporte de Vulnerabilidades

Si encuentras una vulnerabilidad de seguridad, por favor:

1. **NO** abras un issue público
2. Contacta a: [correo-seguridad@ucr.ac.cr]
3. Proporciona detalles específicos y pasos para reproducir
4. Recibirás una respuesta en 48 horas

Ver [SECURITY.md](SECURITY.md) para más detalles.

## 📈 Datos y Metodología

### Fuentes de Datos

- **PRODUS UCR**: Estudios base de 2012
- **Observatorio del Desarrollo UCR**: Investigaciones actuales
- **COSEVI**: Consejo de Seguridad Vial
- **MOPT**: Ministerio de Obras Públicas y Transportes
- **INEC**: Instituto Nacional de Estadística y Censos
- **CCSS**: Caja Costarricense de Seguro Social
- **INS**: Instituto Nacional de Seguros
- **Cruz Roja Costarricense**: Datos de atención prehospitalaria

### Metodología de Cálculo

#### AVPP (Años de Vida Potencialmente Perdidos)
```
AVPP = Número de fallecidos × (Esperanza de vida - Edad promedio de muerte)
AVPP = Fallecidos × (80 - 35) = Fallecidos × 45 años
```

#### AVD (Años Vividos con Discapacidad)
```
Heridos graves = Lesionados totales × 12%
Discapacitados = Heridos graves × 15%
AVD = Discapacitados × 20 años promedio
```

#### Costos
- **Directos**: Atención médica, hospitalizaciones, rehabilitación
- **Indirectos**: Pérdida de productividad, congestión, pensiones

## 🛠️ Análisis de Datos con R

Los scripts de análisis están en la carpeta `CALCULOS/`. Para ejecutarlos:

```r
# Instalar paquetes necesarios
install.packages(c("dplyr", "ggplot2", "readr", "tidyr"))

# Cargar bases de datos
source("CALCULOS/FALLECIDOS EN SITIO/Muertes.Rmd")
source("CALCULOS/BASES DISCAPACITADOS/Bases discapacitados.Rmd")
source("CALCULOS/COSTOS/COSTOS BASE.Rmd")

# Generar indicadores
source("CALCULOS/INDICADORES/AVPP.Rmd")
source("CALCULOS/INDICADORES/AVD.Rmd")
```

## 📝 Principales Cambios y Actualizaciones

### Versión 2.0 (Enero 2026)
- ✅ Implementación completa de medidas de seguridad y ciberseguridad
- ✅ Agregado Content Security Policy (CSP)
- ✅ Headers de seguridad HTTP
- ✅ Mejoras en accesibilidad y SEO
- ✅ Documentación completa en README
- ✅ Archivo de política de seguridad (SECURITY.md)
- ✅ Configuración de servidor segura (.htaccess)
- ✅ Actualización de datos hasta 2025
- ✅ Mejoras visuales en la interfaz
- ✅ Agregados indicadores clave en la página principal

### Versión 1.0 (2025)
- Lanzamiento inicial del portal
- Integración de datos 2011-2024
- Cálculo de indicadores principales
- Estructura básica del sitio web

## 👥 Equipo

### Responsable de Proyecto
**Centro de Investigación Observatorio del Desarrollo**
Universidad de Costa Rica

### Práctica Profesional
**Maria Fernanda Quesada Chavarría**
Estudiante - Escuela de Estadística
Universidad de Costa Rica

### Supervisión Académica
**Universidad de Costa Rica**
Escuela de Estadística

## 📚 Referencias y Documentación

1. **PRODUS UCR (2012)**: "Costos de los accidentes de tránsito en Costa Rica"
   - Dr. Jonathan Agüero Valverde
   - Lic. Leonardo Sánchez Hernández

2. **Segreda, D. (2012)**: "Costos de los accidentes de tránsito en Costa Rica durante el 2012"
   - Tesis de Licenciatura, UCR

3. **Observatorio del Desarrollo UCR**: Estudios continuos 2011-2025

4. **Estado de la Nación**: Informes anuales de seguridad vial

## 🤝 Contribuciones

Este es un proyecto de investigación académica. Para contribuir:

1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/NuevaCaracteristica`)
3. Commit tus cambios (`git commit -m 'Agregar nueva característica'`)
4. Push a la rama (`git push origin feature/NuevaCaracteristica`)
5. Abre un Pull Request

### Guía de Estilo

- Código HTML: Indentación de 4 espacios
- Comentarios: En español
- Commits: Mensajes descriptivos en español
- Documentación: Markdown con formato consistente

## 📄 Licencia

Este proyecto es propiedad de la **Universidad de Costa Rica** y está destinado para fines académicos y de investigación. El uso de los datos debe citar apropiadamente las fuentes.

**Citación sugerida**:
```
Quesada Chavarría, M.F. & Observatorio del Desarrollo UCR (2026).
Impacto Económico y en la Salud Pública de los Accidentes de Tránsito en Costa Rica.
Universidad de Costa Rica. https://github.com/[usuario]/gastoaccidentescr
```

## 📞 Contacto

**Universidad de Costa Rica**
Centro de Investigación Observatorio del Desarrollo
Escuela de Estadística

- 🌐 Web: [www.ucr.ac.cr](https://www.ucr.ac.cr/)
- 📧 Email: observatorio@ucr.ac.cr
- 📍 San José, Costa Rica

## 🙏 Agradecimientos

Este proyecto ha sido posible gracias a:

- Universidad de Costa Rica
- Centro de Investigación Observatorio del Desarrollo
- Escuela de Estadística UCR
- COSEVI, MOPT, INEC, CCSS, INS, Cruz Roja Costarricense
- Todas las instituciones que proporcionaron datos

---

**© 2026 Universidad de Costa Rica - Todos los derechos reservados**

*Última actualización: Enero 2026*
