-- Intelephense formatea el HTML/XML incrustado en los .php y parte etiquetas
-- como <cbc:Name><![CDATA[...]]></cbc:Name> en tres lineas. Esos saltos de
-- linea entran como espacios dentro del valor del XML que se envia a SUNAT.
--
-- Intelephense es cerrado y no admite extensiones, asi que se encadena un
-- post-procesador: conform deja formatear al LSP primero (lsp_format = "first")
-- y luego este formateador vuelve a unir en una sola linea las etiquetas con
-- namespace (cbc:, cac:, sac:, ...) cuyo contenido es texto, CDATA o un echo
-- de PHP. Los contenedores cuyo hijo es otra etiqueta (<cac:PartyName>, etc.)
-- se dejan indentados como estaban.
--
-- Solo se activa en las plantillas backend/views/**/xml_*.php; el resto de los
-- archivos .php sigue formateandose igual que antes.
return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters = opts.formatters or {}
    opts.formatters.sunat_xml_join = {
      command = "perl",
      args = {
        "-0777",
        "-pe",
        [==[s{^([ \t]*)<((?:cbc|cac|sac|ext|ds|qdt|udt):[\w.-]+)([^<>\n]*)>[ \t]*\n[ \t]*((?![ \t])(?!<[A-Za-z])[^\n]*?)[ \t]*\n[ \t]*</\2>}{$1<$2$3>$4</$2>}gm]==],
      },
      stdin = true,
      condition = function(_, ctx)
        return ctx.filename:match("xml_[^/]*%.php$") ~= nil
      end,
    }

    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.php = { "sunat_xml_join", lsp_format = "first" }

    return opts
  end,
}
