% Auteur: Francois Robinet
declare

% Question 1
proc {ReadList Xs}
   case Xs
   of nil then skip
   [] X|Xr then {Browse X} {ReadList Xr}
   end
end

% Question 2
% Si on browse le stream du port on obtient juste un stream
% qui se remplit au fur et à mesure des Send.
% browser le port lui même donne juste "<Port>"

% Question 3
% Fonction qui renvoit un nouveau port
% et qui utilise ReadList sur son input stream
% pour browse chaque élément envoyé au port
fun {PortBrowser}
   Sin in
   thread {ReadList Sin} end
   {NewPort Sin}
end

P = {PortBrowser}
{Send P coucou}
{Send P hello}
