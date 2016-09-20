function gitpush(message)

eval('!git add .');
eval(sprintf('!git commit -m ''%s''', message));
eval('!git push');