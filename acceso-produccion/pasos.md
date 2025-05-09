# Acceso Seguro a Servidor FTP mediante Túnel SSH

Este documento resume los pasos seguidos para desplegar y probar un sistema de acceso seguro a un servidor FTP dentro de una red interna, a través de un contenedor intermedio SSH que actúa como punto de acceso.

---

## ♻ Despliegue de Contenedores

Se ejecutó el siguiente comando desde la raíz del proyecto:

```bash
docker-compose up --build -d
```

Esto construyó y levantó tres contenedores:

* `ssh-client`: contenedor de acceso seguro (SSH), expone el puerto 2222.
* `fsamba-ftp`: servidor FTP/Samba, solo accesible internamente.
* `cliente-test`: contenedor de pruebas en la red interna.

---

## 🔐 Conexión SSH

Desde el host (Windows), se accedió al contenedor `ssh-client` mediante:

```bash
ssh -i ~/.ssh/id_rsa -p 2222 anonymous@localhost
```

Se aceptó la huella del servidor y se accedió correctamente con clave pública.

---

## 🔄 Creación de Túnel SSH

Se ejecutó el script:

```bash
./ftp-tunnel.sh
```

Este estableció un túnel SSH que redirige:

* `localhost:2121` → `fsamba-ftp:21` (comandos FTP)
* `localhost:30000-30009` → `fsamba-ftp:30000-30009` (modo pasivo FTP)

La terminal quedó esperando, indicando que el túnel está activo.

---

## 📢 Conexión al Servidor FTP a través del Túnel

En una nueva terminal:

```bash
ftp
ftp> open localhost 2121
```

Inicio de sesión como `anonymous`:

```
331 Please specify the password.
230 Login successful.
```

---

## 📅 Prueba de Descarga (Modo Pasivo)

Desde el prompt `ftp>`:

```ftp
ls
get archivo.txt
```

La descarga fue exitosa, confirmando el correcto funcionamiento del modo pasivo.

---

## ❌ Intento de Subida Fallido

```ftp
put prueba.txt
```

Errores obtenidos:

```
500 Bad EPRT protocol.
550 Permission denied.
```

### Explicación:

* `500 Bad EPRT protocol.`: el cliente intentó usar un protocolo extendido no soportado; puede solucionarse con `quote PASV`.
* `550 Permission denied.`: el usuario `anonymous` solo tiene permisos de lectura.

---

## 📄 Conclusión

El sistema cumple con los requisitos:

* Acceso restringido a través de `ssh-client`.
* Servidor FTP oculto y protegido.
* Túnel seguro activo para modo pasivo.
* Usuario anónimo con permisos limitados, como medida de seguridad.

---

> ✅ El entorno está correctamente desplegado y funcional para acceso seguro a FTP mediante túnel SSH.
