package com.renee

// De service is verantwoordelijk voor de data: ophalen, straks ook opslaan en wijzigen.
// De route hoeft niet te weten wáár de data vandaan komt — nu een vaste lijst,
// later een database. Die wijziging blijft dan beperkt tot dit bestand.
class AutoService {

    // De lijst leeft nu in de service in plaats van in de route.
    private val autos = listOf(
        Auto(1, "Volkswagen", "Golf", 45.0, true),
        Auto(2, "Toyota", "Yaris", 38.5, true),
        Auto(3, "BMW", "3 Serie", 75.0, false)
    )

    // Eén duidelijke taak: geef alle auto's terug.
    fun haalAlleAutos(): List<Auto> {
        return autos
    }
}