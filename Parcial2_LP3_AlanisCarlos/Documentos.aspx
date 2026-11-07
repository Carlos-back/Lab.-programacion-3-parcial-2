<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Documentos.aspx.cs" Inherits="Parcial2_LP3_AlanisCarlos.Documento" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="Contenido" runat="server">
    <div class="tarjeta tarjeta-ancha">
        <h1>Mis documentos</h1>
        <p>
            Espacio personal de <strong><asp:Label ID="lblUsuario" runat="server" /></strong>.
            Formatos permitidos: PDF, DOC, DOCX, JPG y PNG (máximo 5 MB por archivo).
        </p>

        <!-- Carga de documentos -->
        <div class="campo">
            <asp:Label ID="lblArchivo" runat="server" Text="Seleccioná un documento"
                AssociatedControlID="fuArchivo" />
            <asp:FileUpload ID="fuArchivo" runat="server" accept=".pdf,.doc,.docx,.jpg,.jpeg,.png" />
        </div>

        <div class="campo">
            <asp:Button ID="btnSubir" runat="server" Text="Subir documento" CssClass="boton"
                OnClick="btnSubir_Click" />
        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="mensaje" />

        <!-- Listado de los documentos del usuario -->
        <h2>Documentos cargados</h2>

        <asp:GridView ID="gvDocumentos" runat="server"
            AutoGenerateColumns="False"
            DataKeyNames="Nombre"
            EmptyDataText="Todavía no subiste ningún documento."
            OnRowCommand="gvDocumentos_RowCommand">
            <Columns>
                <asp:BoundField DataField="Nombre" HeaderText="Documento" />
                <asp:BoundField DataField="Tamano" HeaderText="Tamaño" />
                <asp:BoundField DataField="Fecha" HeaderText="Fecha de carga" />
                <asp:TemplateField HeaderText="Acciones">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDescargar" runat="server" CommandName="Descargar"
                            CausesValidation="False" Text="Descargar" />
                        &nbsp;|&nbsp;
                        <asp:LinkButton ID="lnkEliminar" runat="server" CommandName="Eliminar"
                            CausesValidation="False" Text="Eliminar"
                            OnClientClick="return confirm('¿Seguro que querés eliminar este documento?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>