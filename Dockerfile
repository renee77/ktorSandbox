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

# ===== Stage 2: runtime (de etalage) =====
# Alleen een JRE nodig — we draaien hier, we bouwen niet meer.
# 'jre' i.p.v. 'jdk' maakt het image kleiner: geen compiler aan boord.
FROM eclipse-temurin:21-jre AS runtime

WORKDIR /app

# Haal ENKEL de fat jar uit de build-stage op. Al het andere
# (broncode, Gradle, testtroep) blijft in stage 1 achter.
COPY --from=build /app/build/libs/ktor-sandbox-all.jar app.jar

# Documenteert dat de app op poort 8080 luistert (Ktor's standaard).
EXPOSE 8080

# Start de applicatie wanneer de container draait.
ENTRYPOINT ["java", "-jar", "app.jar"]