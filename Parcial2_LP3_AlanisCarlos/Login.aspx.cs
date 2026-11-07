using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial2_LP3_AlanisCarlos
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["registro"] == "ok")
                {
                    lblMensaje.Text = "Registro exitoso. Ahora podés iniciar sesión.";
                }
                else if (Request.QueryString["acceso"] == "requerido")
                {
                    lblMensaje.Text = "Iniciá sesión para acceder a tus documentos.";
                }
            }
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            // Datos guardados al registrarse: usuario en la sesión y contraseña en la cookie
            string usuarioRegistrado = Session["usuario"] as string;
            HttpCookie cookieClave = Request.Cookies["clave"];

            if (usuarioRegistrado == null || cookieClave == null)
            {
                lblMensaje.Text = "No hay un registro vigente. Registrate para poder ingresar.";
                return;
            }

            string claveRegistrada = Server.UrlDecode(cookieClave.Value);

            if (txtUsuario.Text.Trim() == usuarioRegistrado && txtClave.Text == claveRegistrada)
            {
                // Credenciales correctas: se marca la sesión como iniciada
                Session["activo"] = true;
                Response.Redirect("~/Documentos.aspx");
            }
            else
            {
                lblMensaje.Text = "Usuario o contraseña incorrectos.";
            }
        }

    }
}