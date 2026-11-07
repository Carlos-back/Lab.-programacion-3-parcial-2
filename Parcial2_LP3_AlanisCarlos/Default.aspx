<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Parcial2_LP3_AlanisCarlos.Default" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="Contenido" runat="server">
    <section class="hero">
        <asp:Image ID="imgBanner" runat="server" CssClass="hero-img"
            ImageUrl="~/Imagenes/logo3.png" AlternateText="Asesoría Legal Global" />

        <h1>Asesoría Legal Global</h1>
        <p>Asesoramiento en temas legales y gestión segura de tus documentos, en un solo lugar.</p>

        <div class="acciones">
            <asp:HyperLink ID="lnkCrearCuenta" runat="server" CssClass="boton"
                NavigateUrl="~/Registro.aspx" Text="Crear una cuenta" />
            <asp:HyperLink ID="lnkIngresar" runat="server" CssClass="boton boton-secundario"
                NavigateUrl="~/Login.aspx" Text="Iniciar sesión" />
        </div>
    </section>
</asp:Content>
