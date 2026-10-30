-- Used by the printable course PDFs (e.g. bdata200/bdata200-notes.qmd).
-- Links between site pages ("pitfalls.qmd", "workflow.qmd#assignment-operators")
-- become links inside the PDF. Each page's top heading has the id "sec-<file name>".
-- Links to pages that aren't in the PDF (like the course home) keep their text only.

function Link(el)
  local target = el.target
  if target:match("^%a+:") then
    return nil -- external URL: leave alone
  end

  local file, anchor = target:match("^([^#]*%.qmd)#?(.*)$")
  if not file then
    return nil
  end

  local name = file:match("([^/]+)%.qmd$")
  if anchor ~= "" then
    el.target = "#" .. anchor
  elseif name ~= "index" then
    el.target = "#sec-" .. name
  else
    return el.content
  end
  return el
end
