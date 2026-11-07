<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Parcial2_LP3_AlanisCarlos.Login" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="Contenido" runat="server">
    <div class="tarjeta">
        <asp:Image ID="imgLogo" runat="server" CssClass="logo-tarjeta"
            ImageUrl="~/Imagenes/logo1.png" AlternateText="Asesoría Legal Global" />
        <h1>Iniciar sesión</h1>
        <p>Ingresá con el usuario y la contraseña con los que te registraste.</p>

        <asp:ValidationSummary ID="vsResumen" runat="server" CssClass="resumen-errores"
            HeaderText="Revisá los siguientes errores:" DisplayMode="BulletList" />

        <div class="campo">
            <asp:Label ID="lblUsuario" runat="server" Text="Nombre de usuario" AssociatedControlID="txtUsuario" />
            <asp:TextBox ID="txtUsuario" runat="server" MaxLength="20" />
            <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" ControlToValidate="txtUsuario"
                ErrorMessage="Ingresá tu nombre de usuario." Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Label ID="lblClave" runat="server" Text="Contraseña" AssociatedControlID="txtClave" />
            <asp:TextBox ID="txtClave" runat="server" TextMode="Password" MaxLength="50" />
            <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClave"
                ErrorMessage="Ingresá tu contraseña." Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Button ID="btnIngresar" runat="server" Text="Ingresar" CssClass="boton" OnClick="btnIngresar_Click" />
        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" />

        <div class="navegacion">
            <asp:HyperLink ID="lnkRegistro" runat="server" NavigateUrl="~/Registro.aspx"
                Text="¿Todavía no tenés cuenta? Registrate" />
        </div>
    </div>
</asp:Content>
