# Load functions
for function in ~/.functions/*; do
  source $function
done

# Load aliases
[[ -f ~/.aliases ]] && source ~/.aliases
