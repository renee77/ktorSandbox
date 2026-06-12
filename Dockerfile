LABEL authors="eva"
# syntax=docker/dockerfile:1

# ===== Stage 1: build =====
# JDK 21, want in deze fase compileren we Kotlin en draaien we Gradle.
# Een kale JDK (geen Gradle-image): de wrapper haalt zelf Gradle 9.4.1 op,
# net zoals setup-php bij je PHP-pipeline de PHP-versie vastpinde.
FROM eclipse-temurin:21-jdk AS build

# Werkmap in de container; alle volgende commando's draaien hier.
WORKDIR /app

# Hele project naar de container kopiëren.
# (Later splitsen we dit op in lagen voor snellere builds — eerst werkend.)
COPY . .

# Wrapper uitvoerbaar maken (op een Linux-runner niet altijd standaard).
RUN chmod +x ./gradlew

# Bouw de fat JAR. We draaien 'test' hier expliciet mee, zodat een
# falende test de hele image-build breekt (fail fast).
# --no-daemon: geen Gradle-achtergrondproces in een wegwerp-container.
RUN ./gradlew test buildFatJar --no-daemon