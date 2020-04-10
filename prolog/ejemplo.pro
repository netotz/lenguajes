person(bill,male).
person(george,male).
person(alfred,male).
person(carol,female).
person(margaret,female).
person(jane,female).
couple(Woman,Man) :- person(Woman,female),person(Man,male),nl.
