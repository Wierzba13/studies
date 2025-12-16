# --- DANE ---

include("data.jl")

#=
travels = [
    ("Paryż", "Francja", 2022, 8.0), #
    ("Rzym", "Włochy", 2021, 9.0),
    ("Kraków", "Polska", 2023, 10.0),
    ("Przemyśl", "Polska", 2021, 10.0),
    ("Gdynia", "Polska", 2020, 10.0),
    ("Berlin", "Niemcy", 2022, 7.5),
    ("Wenecja", "Włochy", 2019, 8.5),
    ("Lyon", "Francja", 2020, 7.0), #
    ("Tokio", "Japonia", 2018, 9.5),
    ("Mediolan", "Włochy", 2023, 6.0)
]
=#

# --- FUNKCJE ---

function filterByCountry(list, country)
    return filter(p -> p[2] == country, list)
end

function getRatings(list)
    return map(p -> p[4], list)
end

function getYears(list)
    return unique(map(p -> p[3], list)) # Bez powtorzen
end

# --- STATYSTYKI ---

function avgRating(list)
    if length(list) == 0
        return 0.0
    end
    
    ratings = getRatings(list)

    return sum(ratings) / length(ratings)
end

function mostVisitedCountry(list)
    if length(list) == 0
        return "Brak danych"
    end

    countries = map(c -> c[2], list)
    visitsByCountry = Dict()

    for country in countries
        if haskey(visitsByCountry, country)
            visitsByCountry[country] += 1
        else
            visitsByCountry[country] = 1
        end
    end

    mostVisitsCount = reduce((c1, c2) -> c1 > c2 ? c1 : c2, values(visitsByCountry))
    results = filter(c -> visitsByCountry[c] == mostVisitsCount, keys(visitsByCountry))

    return String[country for country in results]
end

# --- WYSWIETLANIE WYNIKOW ---

countryName = "Francja"
countryData = filterByCountry(travels, countryName)

println("######## DANE DLA KONKRETNEGO KRAJU = " * countryName * " ########")

println("--- Wszystkie podróże ---")
println(filterByCountry(travels, "Francja"))

println()

println("--- Srednia ocena wyjazdow ---")
println(round(avgRating(countryData), digits=2))

println()

println("--- Wszystkie oceny podrozy ---")
println(getRatings(countryData))

println("#####################################################")
println()
println("######## STATYSTYKI OGOLNE ########")

println("--- Najczesciej odwiedzane kraje ---")
println(mostVisitedCountry(travels))

println()

println("--- Srednia ocena wszystkich wyjazdow ---")
println(round(avgRating(travels), digits=2))

println()

println("--- Lata podrozy ---")
println(getYears(travels))

println("#####################################################")