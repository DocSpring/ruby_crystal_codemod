#~# ORIGINAL load_path

$LOAD_PATH.unshift __dir__

#~# EXPECTED

#~# ERRORS

"ERROR: Can't use $LOAD_PATH in a Crystal program!"
"You might be able to replace this with CRYSTAL_PATH if needed."

#~# ORIGINAL load_path_short

$:.unshift __dir__

#~# EXPECTED

#~# ERRORS

"ERROR: Can't use $: in a Crystal program!"
"You might be able to replace this with CRYSTAL_PATH if needed."
