package com.renee

import kotlinx.serialization.Serializable

// @Serializable vertelt kotlinx.serialization dat deze class naar JSON
// (en terug) omgezet mag worden. Zonder deze annotatie weet Ktor niet hoe.
@Serializable
data class Auto(
    val id: Int,
    val merk: String,
    val model: String,
    val prijsPerDag: Double,
    val beschikbaar: Boolean
)