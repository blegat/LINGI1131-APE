declare
% 1)
fun {DelayG Xs}
   0|Xs
end
fun lazy {Add Xs Ys}
   X|Xr = Xs
   Y|Yr = Ys
in
   (X+Y)|{Add Xr Yr}
end
fun lazy {Prod N}
   N|{Prod N+1}
end
proc {Circuit ?A ?B ?C}
   A = {Prod 0}
   B = {DelayG C}
   C = {Add A B}
end
% 2)
% b_{i+1} = c_i and b_0 = 0
% a_i = i
% c_i = b_i + a_i
% 3)
% therefore
% b_{i+1} = b_{i} + i
% so, since b_0 = 0
% b_{i+1} = 1 + 2 + ... + i = i * (i+1)/2
% In conclusion
% c_i = i * (i+1)/2
% b_i = i * (i-1)/2 and b_0 = 0
% a_i = i
% 4)
proc {Touch C N}
   if N > 0 then
      {Touch C.2 N-1}
   end
end

% Tests
A B C
{Circuit A B C}
{Browse C}
{Touch C 10}