using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial2_LP3_AlanisCarlos
{
    public partial class Documento : System.Web.UI.Page
    {
        private const int LIMITE_BYTES = 5 * 1024 * 1024; // 5 MB por archivo
        private static readonly string[] EXTENSIONES_PERMITIDAS = { ".pdf", ".doc", ".docx", ".jpg", ".jpeg", ".png" };

        protected void Page_Load(object sender, EventArgs e)
        {
            // Solo puede entrar quien inició sesión
            if (Session["activo"] == null)
            {
                Response.Redirect("~/Login.aspx?acceso=requerido");
                return;
            }

            lblUsuario.Text = Server.HtmlEncode(Convert.ToString(Session["usuario"]));

            if (!IsPostBack)
            {
                CargarDocumentos();
            }
        }

        // ---------- CARGA DE DOCUMENTOS ----------
        protected void btnSubir_Click(object sender, EventArgs e)
        {
            // 1) ¿Se eligió un archivo?
            if (!fuArchivo.HasFile)
            {
                MostrarMensaje("Seleccioná un archivo para subir.", false);
                return;
            }

            // 2) Nombre seguro: se descarta cualquier ruta y se reemplazan caracteres no válidos
            string nombre = LimpiarNombre(Path.GetFileName(fuArchivo.FileName));
            string extension = Path.GetExtension(nombre).ToLower();

            // 3) Solo extensiones permitidas
            if (!EXTENSIONES_PERMITIDAS.Contains(extension))
            {
                MostrarMensaje("Formato no permitido. Subí un archivo PDF, DOC, DOCX, JPG o PNG.", false);
                return;
            }

            // 4) Tamaño: ni vacío ni mayor al límite
            int tamano = fuArchivo.PostedFile.ContentLength;
            if (tamano == 0)
            {
                MostrarMensaje("El archivo está vacío.", false);
                return;
            }
            if (tamano > LIMITE_BYTES)
            {
                MostrarMensaje("El archivo supera el tamaño máximo de 5 MB.", false);
                return;
            }

            // 5) Carpeta personal del usuario y ruta de destino
            string carpeta = ObtenerCarpetaUsuario();
            string ruta = Path.Combine(carpeta, nombre);

            // 6) Si ya existe un archivo con ese nombre, no se sobrescribe: se le agrega fecha y hora
            if (File.Exists(ruta))
            {
                nombre = Path.GetFileNameWithoutExtension(nombre)
                         + "_" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + extension;
                ruta = Path.Combine(carpeta, nombre);
            }

            // 7) Guardar en el servidor
            try
            {
                fuArchivo.SaveAs(ruta);
                MostrarMensaje("Documento subido correctamente: " + Server.HtmlEncode(nombre), true);
                CargarDocumentos();
            }
            catch (Exception)
            {
                MostrarMensaje("Ocurrió un error al guardar el documento. Intentá de nuevo.", false);
            }
        }

        // ---------- DESCARGAR / ELIMINAR ----------
        protected void gvDocumentos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Descargar" && e.CommandName != "Eliminar")
            {
                return;
            }

            // El nombre sale de las claves de la grilla (no se confía en datos del navegador)
            GridViewRow fila = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            string nombre = Path.GetFileName(gvDocumentos.DataKeys[fila.RowIndex].Value.ToString());
            string ruta = Path.Combine(ObtenerCarpetaUsuario(), nombre);

            if (!File.Exists(ruta))
            {
                MostrarMensaje("El documento ya no existe.", false);
                CargarDocumentos();
                return;
            }

            if (e.CommandName == "Descargar")
            {
                Response.Clear();
                Response.ContentType = "application/octet-stream";
                Response.AppendHeader("Content-Disposition",
                    "attachment; filename=\"" + nombre + "\"; filename*=UTF-8''" + Uri.EscapeDataString(nombre));
                Response.TransmitFile(ruta);
                Response.End();
            }
            else
            {
                File.Delete(ruta);
                MostrarMensaje("Documento eliminado: " + Server.HtmlEncode(nombre), true);
                CargarDocumentos();
            }
        }

        // ---------- AUXILIARES ----------

        // Carpeta propia del usuario dentro de App_Data (no se puede abrir escribiendo la URL)
        private string ObtenerCarpetaUsuario()
        {
            string usuario = Path.GetFileName(Convert.ToString(Session["usuario"]));
            string carpeta = Server.MapPath("~/App_Data/Documentos/" + usuario);
            Directory.CreateDirectory(carpeta); // si ya existe, no hace nada
            return carpeta;
        }

        private static string LimpiarNombre(string nombre)
        {
            foreach (char c in Path.GetInvalidFileNameChars())
            {
                nombre = nombre.Replace(c, '_');
            }
            return nombre;
        }

        private void CargarDocumentos()
        {
            DataTable tabla = new DataTable();
            tabla.Columns.Add("Nombre");
            tabla.Columns.Add("Tamano");
            tabla.Columns.Add("Fecha");

            DirectoryInfo carpeta = new DirectoryInfo(ObtenerCarpetaUsuario());
            foreach (FileInfo archivo in carpeta.GetFiles().OrderByDescending(f => f.CreationTime))
            {
                tabla.Rows.Add(
                    archivo.Name,
                    Math.Ceiling(archivo.Length / 1024.0).ToString("N0") + " KB",
                    archivo.CreationTime.ToString("dd/MM/yyyy HH:mm"));
            }

            gvDocumentos.DataSource = tabla;
            gvDocumentos.DataBind();
        }

        private void MostrarMensaje(string texto, bool correcto)
        {
            lblMensaje.Text = texto;
            lblMensaje.CssClass = correcto ? "mensaje" : "mensaje mensaje-error";
        }

    }
}