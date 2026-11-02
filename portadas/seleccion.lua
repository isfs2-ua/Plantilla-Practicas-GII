-- Selecciona el diseño y añade la asignatura al subtítulo de la portada.
function Meta(meta)
  local cabeceras = meta['header-includes'] or pandoc.MetaList({})
  if pandoc.utils.type(cabeceras) ~= 'List' and pandoc.utils.type(cabeceras) ~= 'MetaList' then
    cabeceras = pandoc.MetaList({cabeceras})
  end
  cabeceras:insert(pandoc.MetaBlocks({pandoc.RawBlock('latex', '\\input{formato.tex}')}))
  meta['header-includes'] = cabeceras

  local ajustes = {}
  local campos = {
    {'grupo', 'portadagrupo'},
    {'profesorado', 'portadaprofesorado'},
    {'fecha-entrega', 'portadafechaentrega'},
    {'numero-practica', 'portadanumeropractica'}
  }
  for _, campo in ipairs(campos) do
    local valor = meta[campo[1]]
    if valor and pandoc.utils.stringify(valor) ~= '' then
      local texto = pandoc.utils.stringify(valor)
      local contenido = pandoc.write(pandoc.Pandoc({pandoc.Plain({pandoc.Str(texto)})}), 'latex'):gsub('%s+$', '')
      table.insert(ajustes, '\\renewcommand{\\' .. campo[2] .. '}{' .. contenido .. '}')
    end
  end
  if meta['logo-ua'] ~= nil and pandoc.utils.stringify(meta['logo-ua']) == 'false' then
    table.insert(ajustes, '\\portadalogofalse')
  end
  if #ajustes > 0 then
    cabeceras:insert(pandoc.MetaBlocks({pandoc.RawBlock('latex', table.concat(ajustes, '\n'))}))
  end
  if not meta.portada then return meta end
  local id = pandoc.utils.stringify(meta.portada)
  if id == '' or id == 'general' then return meta end

  local archivo = assert(io.open('portadas/asignaturas.tsv', 'r'),
    'No se encuentra portadas/asignaturas.tsv; ejecuta Pandoc desde la carpeta de la plantilla.')
  local nombre, color, estilo
  for linea in archivo:lines() do
    local clave, n, c, e = linea:match('^([^|]+)|([^|]+)|([0-9A-F]+)|([0-3])$')
    if clave == id then nombre, color, estilo = n, c, e; break end
  end
  archivo:close()
  if not nombre then
    error('Portada desconocida: ' .. id .. '. Consulta portadas/asignaturas.tsv.')
  end

  local subtitulo = {pandoc.Str(nombre)}
  if meta.subtitle and pandoc.utils.stringify(meta.subtitle) ~= '' then
    table.insert(subtitulo, pandoc.Space())
    table.insert(subtitulo, pandoc.Str('·'))
    table.insert(subtitulo, pandoc.Space())
    if pandoc.utils.type(meta.subtitle) == 'Inlines' then
      for _, elemento in ipairs(meta.subtitle) do table.insert(subtitulo, elemento) end
    else
      table.insert(subtitulo, pandoc.Str(pandoc.utils.stringify(meta.subtitle)))
    end
  end
  meta.subtitle = pandoc.MetaInlines(subtitulo)

  local ajuste = '\\AtBeginDocument{\\definecolor{portadaacento}{HTML}{' .. color ..
    '}\\renewcommand{\\portadaestilo}{' .. estilo .. '}}'
  cabeceras:insert(pandoc.MetaBlocks({pandoc.RawBlock('latex', ajuste)}))
  meta['header-includes'] = cabeceras
  return meta
end
