# Política de Seguridad

## Versiones Soportadas

Este proyecto mantiene las siguientes versiones con actualizaciones de seguridad:

| Versión | Soportada          |
| ------- | ------------------ |
| 2.0.x   | :white_check_mark: |
| 1.0.x   | :x:                |

## Medidas de Seguridad Implementadas

### 1. Content Security Policy (CSP)

El sitio implementa una política de seguridad de contenido estricta:

```
Content-Security-Policy:
  default-src 'self';
  style-src 'self' 'unsafe-inline';
  img-src 'self' data: https:;
  font-src 'self';
  script-src 'self';
  frame-ancestors 'self';
```

**Protección contra**:
- Cross-Site Scripting (XSS)
- Inyección de código malicioso
- Clickjacking
- Recursos externos no autorizados

### 2. Headers de Seguridad HTTP

Implementados en todas las respuestas:

- **X-Content-Type-Options**: `nosniff`
  - Previene MIME type sniffing

- **X-Frame-Options**: `SAMEORIGIN`
  - Protección contra clickjacking
  - Solo permite embeber en el mismo origen

- **X-XSS-Protection**: `1; mode=block`
  - Protección adicional contra XSS en navegadores antiguos

- **Referrer-Policy**: `strict-origin-when-cross-origin`
  - Controla información compartida en headers Referer

### 3. Configuración de Servidor

#### Apache (.htaccess)
- Deshabilitación de listado de directorios
- Headers de seguridad configurados
- Protección de archivos sensibles
- Prevención de ataques comunes

#### Nginx (Recomendado)
- Headers de seguridad en configuración
- Rate limiting
- Protección contra DoS básica

### 4. Validación y Sanitización

- HTML5 semántico y validado
- Sin entradas de usuario procesadas sin validación
- Estructura de datos bien definida
- Sin JavaScript externo o inline ejecutable por usuarios

### 5. Protección de Datos

- **Datos Públicos**: Los datos en este proyecto son estadísticos y públicos
- **Sin Datos Sensibles**: No se almacenan datos personales de usuarios
- **Archivos Seguros**: Todos los archivos de datos son de solo lectura
- **Sin Bases de Datos**: Portal estático sin conexiones a BD

### 6. HTTPS/TLS

**Recomendaciones de Despliegue**:
- Usar HTTPS en producción (obligatorio)
- Certificado SSL/TLS válido (Let's Encrypt recomendado)
- TLS 1.2 o superior
- Configuración segura de cifrado

```nginx
# Ejemplo configuración Nginx
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers HIGH:!aNULL:!MD5;
ssl_prefer_server_ciphers on;
```

## Reporte de Vulnerabilidades

### Proceso de Reporte

Si descubres una vulnerabilidad de seguridad, por favor sigue estos pasos:

1. **NO abras un issue público** en GitHub
2. Envía un reporte privado a: **seguridad@ucr.ac.cr**
3. Incluye en tu reporte:
   - Descripción detallada de la vulnerabilidad
   - Pasos para reproducir el problema
   - Impacto potencial
   - Versión afectada
   - Capturas de pantalla o logs (si aplica)

### Qué Esperar

- **Confirmación**: Respuesta inicial en 48 horas hábiles
- **Evaluación**: Análisis de la vulnerabilidad en 7 días
- **Corrección**: Parche de seguridad en 14-30 días (dependiendo de severidad)
- **Crédito**: Reconocimiento público al descubridor (si lo desea)

### Severidad de Vulnerabilidades

Clasificamos las vulnerabilidades según:

| Nivel | Descripción | Tiempo de Respuesta |
|-------|-------------|---------------------|
| **Crítica** | Permite acceso no autorizado completo, ejecución remota de código | 24 horas |
| **Alta** | Afecta confidencialidad/integridad de datos, bypass de autenticación | 7 días |
| **Media** | Vulnerabilidades que requieren condiciones específicas | 14 días |
| **Baja** | Problemas menores de seguridad o información | 30 días |

## Buenas Prácticas para Desarrolladores

### Al Contribuir al Proyecto

1. **Nunca commits**:
   - Credenciales o claves API
   - Datos personales sensibles
   - Información de configuración de producción

2. **Siempre**:
   - Validar todas las entradas
   - Sanitizar datos antes de mostrarlos
   - Usar HTTPS en producción
   - Mantener dependencias actualizadas

3. **Revisar**:
   - Código antes de hacer commit
   - Headers de seguridad en respuestas
   - Configuración de CSP
   - Permisos de archivos

### Checklist de Seguridad

Antes de desplegar cambios:

- [ ] HTML validado (W3C Validator)
- [ ] Sin scripts inline sin autorización
- [ ] Headers de seguridad configurados
- [ ] CSP actualizado si es necesario
- [ ] Archivos sensibles protegidos
- [ ] Sin datos sensibles en el código
- [ ] HTTPS configurado (producción)
- [ ] Permisos de archivos correctos (644 archivos, 755 directorios)
- [ ] .htaccess o configuración Nginx actualizada

## Vulnerabilidades Conocidas y Mitigadas

### Versión 1.0 (Resueltas)

| Vulnerabilidad | Severidad | Estado | Versión Corregida |
|----------------|-----------|--------|-------------------|
| Falta CSP | Media | ✅ Corregida | 2.0.0 |
| Sin headers de seguridad | Media | ✅ Corregida | 2.0.0 |
| Listado de directorios | Baja | ✅ Corregida | 2.0.0 |

## Contacto de Seguridad

**Universidad de Costa Rica**
Equipo de Seguridad - Observatorio del Desarrollo

- 📧 Email principal: seguridad@ucr.ac.cr
- 📧 Email alternativo: observatorio@ucr.ac.cr
- 🔒 PGP Key: [Si aplica]

**Tiempo de respuesta esperado**: 48 horas hábiles

## Recursos Adicionales

### Para Administradores

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Mozilla Observatory](https://observatory.mozilla.org/)
- [Security Headers](https://securityheaders.com/)
- [SSL Labs](https://www.ssllabs.com/ssltest/)

### Para Investigadores de Seguridad

Agradecemos investigaciones de seguridad responsables. Por favor:

- ✅ Realizar pruebas solo en entornos de desarrollo/staging
- ✅ Reportar vulnerabilidades de forma responsable
- ✅ Dar tiempo razonable para corregir antes de divulgación pública
- ❌ No realizar DoS o ataques destructivos
- ❌ No acceder a datos no autorizados
- ❌ No divulgar públicamente antes de la corrección

## Auditorías de Seguridad

Este proyecto realiza:

- **Revisiones de código**: Cada Pull Request
- **Escaneo de vulnerabilidades**: Mensual
- **Actualizaciones de seguridad**: Según sea necesario
- **Auditoría completa**: Anual

**Última auditoría**: Enero 2026
**Próxima auditoría**: Enero 2027

## Cumplimiento y Normativas

Este proyecto cumple con:

- ✅ Mejores prácticas OWASP
- ✅ Estándares de seguridad web modernos
- ✅ Políticas de seguridad UCR
- ✅ Regulaciones de protección de datos aplicables

## Historial de Cambios de Seguridad

### Enero 2026 (v2.0.0)
- ✅ Implementación completa de CSP
- ✅ Agregados todos los headers de seguridad HTTP
- ✅ Configuración de servidor segura (.htaccess)
- ✅ Documentación de seguridad completa
- ✅ Mejoras en estructura HTML

### 2025 (v1.0.0)
- ⚠️ Versión inicial sin medidas de seguridad completas

---

**© 2026 Universidad de Costa Rica**

*Última actualización: Enero 2026*

Para más información sobre el proyecto, consulta [README.md](README.md)
