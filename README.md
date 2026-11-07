# Asesoría Legal Global - Parcial 2

Sitio web para la empresa ficticia **Asesoría Legal Global**, realizado para el Parcial 2 (TP4) de **Laboratorio de Programación 3** (ISSD - Desarrollo de Software, 2026).

Permite que un cliente se registre, inicie sesión y suba sus documentos legales en un espacio personal.

* **Autor:** Carlos Gabriel Alanis Luna

**Video explicativo:** https://drive.google.com/file/d/1R4fC2CtH4Qs6BHQ1pfLbhp-\_V9Rx2u2Y/view?usp=sharingTecnologías

* ASP.NET Web Forms (.NET Framework 4.8), lenguaje C#
* Visual Studio 2022
* CSS externo y responsivo
* No usa base de datos: los datos de registro se guardan en cookie y sesión, y los documentos en el servidor

## Funcionalidades

|Página|Qué hace|
|-|-|
|`Default.aspx`|Página de inicio con el banner de la empresa y accesos al registro y al login|
|`Registro.aspx`|Formulario de registro de clientes con validaciones|
|`Login.aspx`|Inicio de sesión: compara el usuario y la contraseña con los datos del registro|
|`Documentos.aspx`|Espacio personal: carga, listado, descarga y eliminación de documentos|
|`Site.master`|Master Page con la barra de navegación y el pie de página compartidos por todas las páginas|

### Registro de usuarios

Datos que se piden: nombre, apellido, correo electrónico, nombre de usuario, edad, contraseña y confirmación de contraseña.

Validaciones:

* Todos los campos son obligatorios.
* El correo debe tener un formato válido.
* El nombre de usuario admite solo letras, números y guion bajo (3 a 20 caracteres).
* La edad debe ser un número entero y solo se aceptan mayores de 15 años.
* La contraseña debe tener al menos 6 caracteres, con letras y números (validación personalizada).
* La confirmación debe coincidir con la contraseña.

Al presionar "Registrar", la **contraseña se guarda en una cookie** (con vencimiento de 1 hora y marcada como `HttpOnly`) y el **nombre de usuario en una variable de sesión**.

### Gestión de documentos

* Solo accede quien inició sesión; si no, se redirige al login.
* Cada usuario tiene su propia carpeta en el servidor (`App\_Data/Documentos/<usuario>`), que se crea automáticamente.
* Medidas de seguridad en la carga: extensiones permitidas (PDF, DOC, DOCX, JPG, JPEG y PNG), tamaño máximo de 5 MB, rechazo de archivos vacíos, limpieza del nombre del archivo y renombrado automático con fecha y hora si ya existe uno con el mismo nombre (no se sobrescribe).
* Los archivos se guardan en `App\_Data`, que no se puede abrir escribiendo una URL: solo se descargan desde el sitio, con la sesión iniciada.
* El listado muestra nombre, tamaño y fecha de carga, con opciones para descargar y para eliminar (con confirmación).

### Diseño

* Master Page con barra de navegación (con saludo y cierre de sesión cuando hay sesión iniciada) y pie de página.
* Uso de las imágenes de la empresa: logo en la barra de navegación, banner en el inicio y logo en los formularios.
* Diseño responsivo con una hoja de estilos externa (`Estilos/estilos.css`), adaptado a escritorio, tablet y celular.

## Cómo ejecutar el proyecto

1. Abrí la solución (`.sln`) con **Visual Studio 2022** (con la carga de trabajo "Desarrollo de ASP.NET y web").
2. Establecé `Default.aspx` como página de inicio.
3. Ejecutá con **Ctrl+F5**.

No hace falta configurar base de datos. En `Web.config` ya están los ajustes necesarios: la validación sin jQuery (`UnobtrusiveValidationMode`) y el límite de tamaño de carga (`maxRequestLength`).

## Limitaciones

* **La contraseña se guarda en una cookie porque así lo pide la consigna del trabajo.** En una aplicación real esto no es seguro: la cookie queda en el navegador y viaja en cada petición. Lo correcto sería guardar solo un hash de la contraseña en una base de datos.
* **Almacenamiento temporal:** el usuario registrado vive en la sesión (se pierde tras unos 20 minutos de inactividad o al reiniciar la aplicación) y la contraseña en una cookie de 1 hora. Pasado ese tiempo hay que registrarse de nuevo. El sitio guarda un solo registro por navegador.
* No hay base de datos de usuarios.

## Estructura del proyecto

```
Site.master              Master Page (navbar y footer)
Default.aspx             Inicio
Registro.aspx            Registro de usuarios
Login.aspx               Inicio de sesión
Documentos.aspx          Gestión de documentos
Estilos/estilos.css      Hoja de estilos responsiva
Imagenes/                Logos de la empresa
Web.config               Configuración del sitio
App\_Data/Documentos/     Documentos subidos (se crea al usarlo)
```

