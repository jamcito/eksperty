:- module(se2,[wykonaj]).

:- dynamic([xpozytywne/2, xnegatywne/2]).

sugerowane_miejsce(krakow) :-
    negatywne(lubisz, przebywac_na_swiezym_powietrzu),
    negatywne(chcesz_mieszkac, zagranica),
    pozytywne(chcesz_mieszkac, miasto),
    atrakcyjne(spolecznie),
    atrakcyjne(kultura).

sugerowane_miejsce(bieszczady) :-
    pozytywne(lubisz, przebywac_na_swiezym_powietrzu),
    pozytywne(lubisz, gory),
    nieistotne(komunikacja),
    nieistotne(edukacja),
    nieistotne(opieka_medyczna),
    pozytywne(chcesz_mieszkac, wies),
    atrakcyjne(spokoj).

sugerowane_miejsce(londyn) :-
    negatywne(lubisz, przebywac_na_swiezym_powietrzu),
    nieistotne(opieka_medyczna),
    pozytywne(chcesz_mieszkac, zagranica),
    pozytywne(chcesz_mieszkac, metropolia),
    atrakcyjne(spolecznie),
    atrakcyjne(kultura),
    pozytywne(znasz, angielski),
    pozytywne(tolerujesz, czeste_opady).

sugerowane_miejsce(mazury) :-
    atrakcyjne(akwen_wodny),
    nieistotne(komunikacja),
    nieistotne(opieka_medyczna),
    pozytywne(chcesz_mieszkac, wies),
    atrakcyjne(wypoczynek_na_swiezym_powietrzu).
    
sugerowane_miejsce(wyspy_karaibskie) :-
    atrakcyjne(akwen_wodny),
    atrakcyjne(klimat),
    nieistotne(opieka_medyczna),
    nieistotne(edukacja),
    pozytywne(chcesz_mieszkac, zagranica),
    atrakcyjne(wypoczynek_na_swiezym_powietrzu),
    (pozytywne(znasz, hiszpanski);
    pozytywne(znasz, angielski)).
 
sugerowane_miejsce(zakopane) :-
    negatywne(lubisz, przebywac_na_swiezym_powietrzu),
    (pozytywne(lubisz, gory);
    pozytywne(lubisz, sporty_zimowe)),
    nieistotne(komunikacja).

sugerowane_miejsce(innsbruck) :-
    pozytywne(lubisz, przebywac_na_swiezym_powietrzu),
    pozytywne(lubisz, gory),
    pozytywne(chcesz_mieszkac, zagranica),
    pozytywne(chcesz_mieszkac, miasto),
    (atrakcyjne(spolecznie);
    atrakcyjne(kultura);
    pozytywne(lubisz, sporty_zimowe)),
    (pozytywne(znasz, niemiecki);
    pozytywne(znasz, angielski)).

sugerowane_miejsce(norwegia) :-
    pozytywne(lubisz, gory),
    pozytywne(chcesz_mieszkac, zagranica),
    pozytywne(chcesz_mieszkac, wies),
    atrakcyjne(wypoczynek_na_swiezym_powietrzu),
    (pozytywne(znasz, norweski);
    pozytywne(znasz, angielski)).
 
sugerowane_miejsce(madryt) :-
    pozytywne(chcesz_mieszkac, zagranica),
    (pozytywne(chcesz_mieszkac, metropolia);
        pozytywne(chcesz_mieszkac, miasto)),
    atrakcyjne(spolecznie),
    atrakcyjne(kultura),
    atrakcyjne(klimat),
    pozytywne(znasz, hiszpanski).

sugerowane_miejsce(warszawa) :-
    (pozytywne(chcesz_mieszkac, metropolia); 
        pozytywne(chcesz_mieszkac, miasto)),
    atrakcyjne(spolecznie).

%

nieistotne(komunikacja) :-
    (pozytywne(czy, masz_auto));
    (negatywne(czy, duzo_podrozujesz)).

nieistotne(opieka_medyczna) :-
    negatywne(czy, czesto_chorujesz),
    negatywne(czy, masz_dzieci).
 
nieistotne(edukacja) :-
    negatywne(czy, masz_dzieci),
    pozytywne(czy, skonczyles_edukacje).

atrakcyjne(spolecznie) :-
    ((pozytywne(chcesz_mieszkac, metropolia);
    pozytywne(chcesz_mieszkac, miasto)),
    negatywne(chcesz_mieszkac, wies));
    pozytywne(lubisz, koncerty).

atrakcyjne(spokoj) :-
    pozytywne(chcesz_mieszkac, wies),
    negatywne(tolerujesz, halas).

atrakcyjne(kultura) :-
    (pozytywne(lubisz, koncerty);
    pozytywne(lubisz, zabytki)),
    negatywne(chcesz_mieszkac, wies).

atrakcyjne(wypoczynek_na_swiezym_powietrzu) :-
    pozytywne(lubisz, przebywac_na_swiezym_powietrzu),
    atrakcyjne(spokoj).
 
atrakcyjne(akwen_wodny) :-
    (pozytywne(lubisz, przebywac_nad_woda);
    pozytywne(lubisz, zeglowac)).

atrakcyjne(klimat) :-
    pozytywne(lubisz, cieply_klimat) ;
    negatywne(tolerujesz, czeste_opady).


%

pozytywne(X, Y) :-
    xpozytywne(X, Y), !.

pozytywne(X, Y) :-
    not(xnegatywne(X, Y)),
    JEZYK = [niemiecki, angielski, norweski, hiszpanski],
    member(Y, JEZYK),
    pytaj_wiele(X, Y, JEZYK, tak).

pozytywne(X, Y) :-
    not(xnegatywne(X, Y)),
    LOKALIZACJA = [gory, morze, jeziora],
    member(Y, LOKALIZACJA),
    pytaj_wiele(X, Y, LOKALIZACJA, tak).

pozytywne(X, Y) :-
    not(xnegatywne(X, Y)),
    ROZMIAR = [metropolia, miasto, wies],
    member(Y, ROZMIAR),
    pytaj_wiele(X, Y, ROZMIAR, tak).

pozytywne(X, Y) :-
    not(xnegatywne(X, Y)),
    pytaj(X, Y, tak).

%

negatywne(X, Y) :-
    xnegatywne(X, Y), !.

negatywne(X, Y) :-
    not(xpozytywne(X, Y)),
    JEZYK = [niemiecki, angielski, norweski, hiszpanski],
    member(Y, JEZYK),
    pytaj_wiele(X, Y, JEZYK, nie).

negatywne(X, Y) :-
    not(xpozytywne(X, Y)),
    LOKALIZACJA = [gory, morze, jeziora],
    member(Y, LOKALIZACJA),
    pytaj_wiele(X, Y, LOKALIZACJA, nie).

negatywne(X, Y) :-
    not(xpozytywne(X, Y)),
    ROZMIAR = [metropolia, miasto, wies],
    member(Y, ROZMIAR),
    pytaj_wiele(X, Y, ROZMIAR, nie).

negatywne(X, Y) :-
    not(xpozytywne(X, Y)),
    pytaj(X, Y, nie).

%

pytaj_wiele(X, Y, L, tak) :-
    !, write('Ktore z podanych '), write(L), write(' '), write(X), write(' ? (odp1_odp2_..._odpN/zadne) \n'),
    readln([Replay]),
    odpowiedz_wiele(Replay, X, Y, L, tak).

pytaj_wiele(X, Y, L, nie) :-
    !, write('Ktore z podanych '), write(L), write(' '), write(X), write(' ? (odp1_odp2_..._odpN/zadne) \n'),
    readln([Replay]),
    odpowiedz_wiele(Replay, X, Y, L, nie).

odpowiedz_wiele(Replay, X, Y, L, nie) :-
    sub_string(Replay, 0, _, _, 'zadne'),
    pamietaj('', X, Y, L).

odpowiedz_wiele(Replay, X, Y, L, nie) :-
    pamietaj(Replay, X, Y, L).

odpowiedz_wiele(Replay, X, Y, L, tak) :-
    pamietaj(Replay, X, Y, L),
    sub_string(Replay, 0, _, _, Y).

pamietaj(Replay, X, Y, [H|T]) :-
    sub_string(Replay, _, _, _, H),
    assertz(xpozytywne(X, H)),
    pamietaj(Replay, X, Y, T).

pamietaj(Replay, X, Y, [H|T]) :-
    assertz(xnegatywne(X, H)),
    pamietaj(Replay, X, Y, T).

pamietaj(_, _, _, []).

%

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


    
