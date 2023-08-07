PROMPT=" %{%F{yellow}%}%~ %f%}%# "
#PROMPT="%{%F{cyan}%}%n%{%f%}@%{%F{blue}%}%m%{%f%}:%{%F{yellow}%}%~ %f%}%# "

# Load functions
for function in ~/.functions/*; do
  source $function
done

# Load aliases
[[ -f ~/.aliases ]] && source ~/.aliases
