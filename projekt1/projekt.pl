:- module(se2,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2]).

sugerowane_miejsce(krakow) :-
    negatywne(lubisz, przebywac_na_swiezym_powietrzu),
    negatywne(lubisz, gory),
    negatywne(chcesz_mieszkac, zagranica).

sugerowane_miejsce(bieszczady) :-
    pozytywne(lubisz, przebywac_na_swiezym_powietrzu),
    pozytywne(lubisz, gory),
    nieistotne(komunikacja),
    nieistotne(edukacja),
    nieistotne(opieka_medyczna).

sugerowane_miejsce(londyn) :-
    negatywne(lubisz, przebywac_na_swiezym_powietrzu),
    nieistotne(opieka_medyczna),
    pozytywne(chcesz_mieszkac, zagranica).

sugerowane_miejsce(mazury) :-
    pozytywne(lubisz, przebywac_na_swiezym_powietrzu),
    pozytywne(lubisz, zeglowac),
    nieistotne(komunikacja),
    nieistotne(opieka_medyczna).

sugerowane_miejsce(wyspy_karaibskie) :-
    pozytywne(lubisz, przebywac_na_swiezym_powietrzu),
    pozytywne(lubisz, zeglowac),
    nieistotne(opieka_medyczna),
    nieistotne(edukacja),
    pozytywne(chcesz_mieszkac, zagranica).
 
sugerowane_miejsce(zakopane) :-
    negatywne(lubisz, przebywac_na_swiezym_powietrzu),
    pozytywne(lubisz, gory),
    nieistotne(komunikacja).

sugerowane_miejsce(innsbruck) :-
    pozytywne(lubisz, przebywac_na_swiezym_powietrzu),
    pozytywne(lubisz, gory),
    pozytywne(chcesz_mieszkac, zagranica).    

nieistotne(komunikacja) :-
    (pozytywne(czy, masz_auto));
    (negatywne(czy, duzo_podrozujesz)).

nieistotne(opieka_medyczna) :-
    negatywne(czy, czesto_chorujesz),
    negatywne(czy, masz_dzieci).
 
nieistotne(edukacja) :-
    negatywne(czy, masz_dzieci);
    pozytywne(czy, skonczyles_edukacje).

pozytywne(X, Y) :-
    xpozytywne(X, Y), !.

pozytywne(X, Y) :-
    not(xnegatywne(X, Y)),
    pytaj(X, Y, tak).

negatywne(X, Y) :-
    xnegatywne(X, Y), !.

negatywne(X, Y) :-
    not(xpozytywne(X, Y)),
    pytaj(X, Y, nie).

pytaj(X, Y, tak) :-
    !, write(X) , write(' '),  write(Y), write(' ? (t/n)\n'),
    readln([Replay]),
    pamietaj(X, Y, Replay), 
    odpowiedz(Replay, tak).

pytaj(X, Y, nie) :-
    !, write(X) , write(' '), write(Y), write(' ? (t/n)\n'),
    readln([Replay]),
    pamietaj(X, Y, Replay),
    odpowiedz(Replay, nie).    

odpowiedz(Replay, tak):-
    sub_string(Replay, 0, _, _, 't').

odpowiedz(Replay, nie):-
    sub_string(Replay, 0, _, _, 'n').

pamietaj(X, Y, Replay) :-
    odpowiedz(Replay, tak),
    assertz(xpozytywne(X, Y)).

pamietaj(X, Y, Replay) :-
    odpowiedz(Replay, nie),
    assertz(xnegatywne(X, Y)).

wyczysc_fakty :-
    write('\n\nNacisnij enter aby zakonczyc\n'),
    retractall(xpozytywne(_, _)),
    retractall(xnegatywne(_, _)),
    readln(_).

wykonaj :-
    sugerowane_miejsce(X), !,
    write('Sugerowanym miejscem zamieszkania jest '), write(X), nl,
    wyczysc_fakty.

wykonaj :-
    write('\nZadne miejsce w bazie wiedzy, '),
    write('nie odpowiada kryteriom jakie podales.\n\n'), wyczysc_fakty.


    
