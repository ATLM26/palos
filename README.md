# Palos · puesta en marcha

Tres archivos, dos servicios gratis, unos 20 minutos.

- `index.html` — la app entera
- `config.js` — las dos claves de tu proyecto (lo único que tenés que editar)
- `schema.sql` — las tablas y los permisos

---

## 1. Base de datos y login (Supabase)

1. Entrá a **supabase.com**, creá una cuenta y hacé **New project**.
   Elegí la región **South America (São Paulo)**: es la más cercana y la app va a ir más rápida.
   Guardá la contraseña de la base que te pide, aunque para esto no la vas a usar.
2. Esperá a que termine de crearse (un par de minutos).
3. Menú izquierdo → **SQL Editor** → **New query** → pegá todo el contenido de `schema.sql` → **Run**.
   Tiene que decir *Success*.
4. Menú izquierdo → **Authentication** → **Sign In / Providers** → **Email**: dejalo habilitado.
   - Si querés que la gente entre sin tener que confirmar el mail, desactivá **Confirm email**. Es más cómodo para tus amigos, y para esto no hay riesgo real.
   - Si lo dejás activado, cada uno tiene que abrir el mail de confirmación antes de poder entrar. Ojo: el servidor de mails que viene incluido manda muy pocos mensajes por hora, así que si se anotan varios juntos, mejor desactivalo.
5. Menú izquierdo → **Project Settings** → **API**. Copiá:
   - **Project URL**
   - la clave **anon / public**
6. Pegá esos dos valores en `config.js`, reemplazando los textos de ejemplo.

Sobre la clave: la `anon key` es pública a propósito, viaja en el navegador de todos. Lo que protege los datos son las políticas RLS que creó el `schema.sql` — cada consulta solo devuelve las filas del usuario logueado. **Nunca** pongas ahí la `service_role key`.

---

## 2. Publicar (GitHub Pages)

1. Creá un repo nuevo, público, por ejemplo `palos`.
2. Subí los tres archivos a la raíz (`index.html`, `config.js`, `schema.sql`).
3. **Settings** → **Pages** → *Source*: **Deploy from a branch** → rama `main`, carpeta `/ (root)` → **Save**.
4. En un minuto te da la URL: `https://TU-USUARIO.github.io/palos/`.

## 3. Cerrar el círculo

En Supabase → **Authentication** → **URL Configuration**:
- **Site URL**: `https://TU-USUARIO.github.io/palos/`
- **Redirect URLs**: agregá esa misma dirección.

Listo. Mandá el link, cada uno se crea su cuenta con su mail y ve solo sus patadas.

---

## Cómo se usa

- **Registrar**: elegís el partido, tocás la cancha en el punto exacto y marcás Entró o Erró. La cancha de esta pestaña muestra solo las patadas del partido activo.
- **Estadísticas**: tildás los partidos que querés mirar (uno, varios o todos), y el mapa de calor, las tablas por distancia y por ángulo y la curva partido a partido se recalculan con esa selección.
- **Partidos**: alta y baja de partidos, y export a CSV.

Si registrás una patada sin señal, queda guardada en el celular y se sube sola cuando vuelve la conexión. Mientras tanto aparece con un anillo gris punteado y un aviso arriba.

## Si algo no anda

- **"Falta la configuración"** → `config.js` sigue con los valores de ejemplo.
- **Entra pero no guarda nada** → falta correr el `schema.sql`, o se corrió a medias. Volvé a ejecutarlo entero.
- **"Invalid login credentials" al crear cuenta** → esa cuenta ya existe; usá Entrar.
- **Se creó la cuenta pero no entra** → está activado *Confirm email* y falta abrir el mail.
- **Pantalla en blanco** → abrí la consola del navegador (F12) y fijate el error; casi siempre es la URL del proyecto mal pegada.

## Ideas para más adelante

- Condiciones de la patada: viento, cancha mojada, minuto del partido, si fue con el partido al límite.
- Comparar tu efectividad con la de otros pateadores del club (requiere una tabla de equipo y decidir quién ve qué).
- Objetivo por zona y seguimiento de entrenamientos, separado de los partidos.
