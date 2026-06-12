package com.renee

import io.ktor.server.application.*
import io.ktor.server.response.*
import io.ktor.server.routing.*

fun Application.configureRouting() {
    val autoService = AutoService()
    routing {
        get("/") {
            call.respondText("Hello, World!")
        }
        get("/json/kotlinx-serialization") {
            call.respond(mapOf("hello" to "world"))
        }
        // Nieuw endpoint: geeft de lijst met auto's terug als JSON.
        get("/autos") {
            // call.respond geeft het object terug. Omdat ContentNegotiation
            // met json() aanstaat én Auto @Serializable is, zet Ktor de lijst
            // automatisch om naar een JSON-array. Handmatig serialiseren is niet nodig.
            call.respond(autoService.haalAlleAutos())
        }
    }
}