using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Parcial2_LP3_AlanisCarlos
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // "activo" lo marca la página de login cuando las credenciales son correctas
            bool activo = Session["activo"] != null;

            lblSaludo.Visible = activo;
            lnkSalir.Visible = activo;

            if (activo)
            {
                lblSaludo.Text = "Hola, " + Server.HtmlEncode(Convert.ToString(Session["usuario"]));
            }
        }

        protected void lnkSalir_Click(object sender, EventArgs e)
        {
            // Se cierra la sesión de trabajo, pero se conserva el usuario registrado
            Session.Remove("activo");
            Response.Redirect("~/Default.aspx");
        }
    }
}