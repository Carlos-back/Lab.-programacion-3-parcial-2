using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial2_LP3_AlanisCarlos
{
    public partial class Registro : System.Web.UI.Page
    {
        // Validación personalizada (CustomValidator): al menos 6 caracteres, con letras y números
        protected void cvClave_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string clave = args.Value;
            args.IsValid = clave.Length >= 6
                           && clave.Any(char.IsLetter)
                           && clave.Any(char.IsDigit);
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            // Si alguna validación falla, no se guarda nada
            if (!Page.IsValid)
            {
                return;
            }

            // Almacenamiento temporal pedido en la consigna:
            // 1) la contraseña se guarda en una cookie
            HttpCookie cookieClave = new HttpCookie("clave", Server.UrlEncode(txtClave.Text));
            cookieClave.Expires = DateTime.Now.AddHours(1);   // vencimiento corto
            cookieClave.HttpOnly = true;                      // el JavaScript de la página no puede leerla
            Response.Cookies.Add(cookieClave);

            // 2) el nombre de usuario se guarda en una variable de sesión
            Session["usuario"] = txtUsuario.Text.Trim();

            // Se pasa a la página de login avisando que el registro fue exitoso
            Response.Redirect("~/Login.aspx?registro=ok");
        }

    }
}