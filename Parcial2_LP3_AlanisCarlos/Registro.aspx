<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="Parcial2_LP3_AlanisCarlos.Registro" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="Contenido" runat="server">
    <div class="tarjeta">
        <asp:Image ID="imgLogo" runat="server" CssClass="logo-tarjeta"
            ImageUrl="~/Imagenes/logo1.png" AlternateText="Asesoría Legal Global" />
        <h1>Registro de usuarios</h1>
        <p>Completá todos los campos para crear tu cuenta.</p>

        <asp:ValidationSummary ID="vsResumen" runat="server" CssClass="resumen-errores"
            HeaderText="Revisá los siguientes errores:" DisplayMode="BulletList" />

        <div class="campo">
            <asp:Label ID="lblNombre" runat="server" Text="Nombre" AssociatedControlID="txtNombre" />
            <asp:TextBox ID="txtNombre" runat="server" MaxLength="50" />
            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre"
                ErrorMessage="El nombre es obligatorio." Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Label ID="lblApellido" runat="server" Text="Apellido" AssociatedControlID="txtApellido" />
            <asp:TextBox ID="txtApellido" runat="server" MaxLength="50" />
            <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                ErrorMessage="El apellido es obligatorio." Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Label ID="lblCorreo" runat="server" Text="Correo electrónico" AssociatedControlID="txtCorreo" />
            <asp:TextBox ID="txtCorreo" runat="server" MaxLength="100" />
            <asp:RequiredFieldValidator ID="rfvCorreo" runat="server" ControlToValidate="txtCorreo"
                ErrorMessage="El correo electrónico es obligatorio." Text="*" CssClass="error" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revCorreo" runat="server" ControlToValidate="txtCorreo"
                ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                ErrorMessage="El formato del correo electrónico no es válido (ejemplo: nombre@dominio.com)."
                Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Label ID="lblUsuario" runat="server" Text="Nombre de usuario" AssociatedControlID="txtUsuario" />
            <asp:TextBox ID="txtUsuario" runat="server" MaxLength="20" />
            <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" ControlToValidate="txtUsuario"
                ErrorMessage="El nombre de usuario es obligatorio." Text="*" CssClass="error" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revUsuario" runat="server" ControlToValidate="txtUsuario"
                ValidationExpression="^[A-Za-z0-9_]{3,20}$"
                ErrorMessage="El usuario debe tener entre 3 y 20 caracteres: solo letras, números y guion bajo."
                Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Label ID="lblEdad" runat="server" Text="Edad" AssociatedControlID="txtEdad" />
            <asp:TextBox ID="txtEdad" runat="server" MaxLength="3" />
            <asp:RequiredFieldValidator ID="rfvEdad" runat="server" ControlToValidate="txtEdad"
                ErrorMessage="La edad es obligatoria." Text="*" CssClass="error" Display="Dynamic" />
            <asp:RangeValidator ID="rvEdad" runat="server" ControlToValidate="txtEdad"
                Type="Integer" MinimumValue="16" MaximumValue="120"
                ErrorMessage="La edad debe ser un número entero y solo se aceptan mayores de 15 años."
                Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Label ID="lblClave" runat="server" Text="Contraseña" AssociatedControlID="txtClave" />
            <asp:TextBox ID="txtClave" runat="server" TextMode="Password" MaxLength="50" />
            <asp:RequiredFieldValidator ID="rfvClave" runat="server" ControlToValidate="txtClave"
                ErrorMessage="La contraseña es obligatoria." Text="*" CssClass="error" Display="Dynamic" />
            <asp:CustomValidator ID="cvClave" runat="server" ControlToValidate="txtClave"
                OnServerValidate="cvClave_ServerValidate"
                ErrorMessage="La contraseña debe tener al menos 6 caracteres e incluir letras y números."
                Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Label ID="lblConfirmar" runat="server" Text="Confirmar contraseña" AssociatedControlID="txtConfirmar" />
            <asp:TextBox ID="txtConfirmar" runat="server" TextMode="Password" MaxLength="50" />
            <asp:RequiredFieldValidator ID="rfvConfirmar" runat="server" ControlToValidate="txtConfirmar"
                ErrorMessage="Confirmá la contraseña." Text="*" CssClass="error" Display="Dynamic" />
            <asp:CompareValidator ID="cmpClaves" runat="server" ControlToValidate="txtConfirmar"
                ControlToCompare="txtClave" Operator="Equal" Type="String"
                ErrorMessage="Las contraseñas no coinciden." Text="*" CssClass="error" Display="Dynamic" />
        </div>

        <div class="campo">
            <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="boton" OnClick="btnRegistrar_Click" />
        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" />

        <div class="navegacion">
            <asp:HyperLink ID="lnkYaTengoCuenta" runat="server" NavigateUrl="~/Login.aspx"
                Text="¿Ya te registraste? Iniciá sesión" />
        </div>
    </div>
</asp:Content>
