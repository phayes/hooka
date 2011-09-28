this.inc = 
  dir: (dirpath) ->
    dir = fs.readdirSync(dirpath)
    for filename in dir
      do (filename) ->
        fullpath = dirpath + '/' + filename
        if is_coffee(fullpath)
          include_file(fullpath)
  
  file: (filepath) ->
    if is_coffee(filepath)
      include_file(filepath)


# Private methods
# ---------------

is_coffee = (filepath) ->
  stat = fs.statSync(filepath)
  if stat.isFile() and filepath.substring(filepath.length - 7) == '.coffee'
    return true

include_file = (filepath) ->
  pathparts = filepath.split('/')
  filename  = pathparts.pop()
  pathparts = filename.split('.')
  
  # Remove the extension and throw it away
  pathparts.pop()
  
  # There are two to three parts to the filename: section, (maybe) subsection, module-name
  # TODO: Allow for infinite nesting
  section = pathparts[0]
  
  # Fill in any missing container objects on the hooka-runtime
  if pathparts[2]?
    if not hooka[section][pathparts[1]]?
      hooka[section][pathparts[1]] = {}
  
  # Stich in the object into the hooka-runtime
  if pathparts[2]?
    hooka[section][pathparts[1]][pathparts[2]] = require('../' + filepath)[pathparts[2]]
  else
    hooka[section][pathparts[1]] = require('../' + filepath)[pathparts[1]]
