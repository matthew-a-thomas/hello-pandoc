-- This is a Pandoc filter written in Lua.
-- You can learn more about Pandoc's Lua filters here:
-- https://pandoc.org/lua-filters.html

-- This specific filter replaces all occurrences of "\newpage" and "\pagebreak"
-- with a page break in the style of the destination document format. This is
-- heavily inspired by this StackOverflow answer:
-- https://stackoverflow.com/a/52131435/3063273

-- Return a block element causing a page break in the given format.
local function newpage(format)
  if format == 'docx'
  then
    return pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')
  elseif format:match('html.*')
  then
    return pandoc.RawBlock('html', '<p style="page-break-after: always;"></p>')
  elseif format:match('tex$')
  then
    return pandoc.RawBlock('tex', '\\newpage{}')
  elseif format:match('epub')
  then
    return pandoc.RawBlock('html', '<p style="page-break-after: always;"></p>')
  else
    -- fall back to insert a form feed character
    return pandoc.Para(pandoc.Str('\f'))
  end
end

-- Filter function called on each RawBlock element.
function RawBlock(el)
  -- check that the block is TeX or LaTeX and contains only \newpage or
  -- \pagebreak.
  if el.text:match('\\newpage') or el.text:match('\\pagebreak')
  then
    -- use format-specific pagebreak marker. FORMAT is set by pandoc to
    -- the targeted output format.
    return newpage(FORMAT)
  end
  -- otherwise, leave the block unchanged
  return nil
end