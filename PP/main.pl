% https://swish.swi-prolog.org/
% (miasto, kraj, rok, ocena)
travel(paryz, francja, 2022, 8.0).
travel(rzym, wlochy, 2021, 9.0).
travel(krakow, polska, 2023, 10.0).
travel(przemysl, polska, 2021, 10.0).
travel(gdynia, polska, 2020, 10.0).
travel(berlin, niemcy, 2022, 7.5).
travel(wenecja, wlochy, 2019, 8.5).
travel(lyon, francja, 2020, 7.0).
travel(tokio, japonia, 2018, 9.5).
travel(mediolan, wlochy, 2003, 6.0).

% odp funkcji mojego programu w julii

filterByCountry(Country, Result) :-
    findall(
		(City, Year, Rating),					% format wyniku
        travel(City, Country, Year, Rating),	% zrodlo danych
        Result									% gdzie przechowujemy wynik
        ).

getRatings(Result) :-
    findall(
		(Rating),
        travel(_, _, _, Rating),
        Result
        ).

getYears(Result) :-
    findall(
        Year, 
        travel(_, _, Year, _), 
        Years
        ),
    sort(Years, Result).

suma([], 0).
suma([H|T], Result) :-
    suma(T, Rest),
    Result is H + Rest.

averageRating(Avg) :-
    getRatings(RatingsList),
    suma(RatingsList, Sum),
    length(RatingsList, Len),
    (Len < 1 ->   Avg is 0; Avg is Sum/Len).

countVisits(Country, Number) :-
    findall(x, travel(_, Country, _, _), List),
    length(List, Number).

mostVisitedCountry(Result) :-
    findall(Country, travel(_, Country, _, _), Countries),
    
    ( Countries = [] -> 
        Result = "Brak danych"
    ;
        sort(Countries, UqCountries),
        findall(Visit, (member(Country, UqCountries), countVisits(Country, Visit)), Visits),

        sort(Visits, SortedVisits),	% sortuje rosnaco
        last(SortedVisits, Max),	% ostatni element z listy (czyli u nas max visits)

        findall(Country, (member(Country, UqCountries), countVisits(Country, Max)), Result)
    ).

/* PRZYKLADY - do uruchomienia
 * filterByCountry(polska, Wynik).
 * filterByCountry(urugwaj, Wynik).
 * 
 * getRatings(Oceny).
 * getYears(Lata).
 * 
 * averageRating(SredniaOcen).
 * mostVisitedCountry(NajczesciejOdwiedzane).
*/

% main.
main :-
    writeln("PODROZE DO POLSKI"),
	filterByCountry(polska, WizytyPolska),
	writeln(WizytyPolska),
    
    writeln("PODROZE DO Kiribati"),
	filterByCountry(kiribati, WizytyKiribati),
    writeln(WizytyKiribati),

	writeln("WSZYSTKIE OCENY"),
	getRatings(Oceny),
    writeln(Oceny),

	writeln("LATA PODROZY"),
	getYears(Lata),
    writeln(Lata),
    
	writeln("SREDNIA OCENA"),
	averageRating(SredniaOcen),
    writeln(SredniaOcen),

	writeln("NAJCZESCIEJ ODWIEDZANY KRAJ"),
	mostVisitedCountry(NajczesciejOdwiedzany),
    writeln(NajczesciejOdwiedzany).

 