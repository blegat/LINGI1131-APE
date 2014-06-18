declare
% 1.
fun {DelayG Xs}
   0|Xs
end
fun {NotG Xs}
   fun {NotLoop Xs}
      X|Xr = Xs
   in
      (1-X)|{NotLoop Xr}
   end
in
   thread {NotLoop Xs} end
end

% 2.
fun {Circuit}
   B = {NotG A}
   C = {DelayG B}
   A = {DelayG C}
in
   A
end

% 3. 0|0|1|1|0|0|1|1|... as we can see here
{Browse {Circuit}}

% 4.
% b(i)   = 1 - a(i) (1)
% c(i+1) = b(i)     (2)
% a(i+1) = c(i)     (3)
% Par (2) et (3), on a
% a(i+2) = c(i+1) = b(i)
% ce qui par (1) donne
% a(i+2) = a(i)
% On a donc, avec (a(0) et a(1) valant 0 ou 1)
% a(n) =
%       a(0) si n mod 4 == 0
%   1 - a(0) si n mod 4 == 2
%       a(1) si n mod 4 == 1
%   1 - a(1) si n mod 4 == 3

% Oui, il est périodique de période 4 car
% * ce n'est pas périodique de période
%   1 car ça signifierait qu'ils sont tous égaux mais a(0) \= 1 - a(0)
% * ni de période 2 car ça signifierait que a(0) == 1 - a(0)
% * ni de période 3 car ça signifierait que a(n+6) = a(n) ce qui est absurde car
%   a(n+6) = 1 - a(n+4) = a(n+2) = 1 - a(n), on a donc p > 3
% * de période 4 comme on l'a vu, on a donc p <= 4