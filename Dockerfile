# Stage 1: Build
FROM maven:3.9-eclipse-temurin-17-alpine AS build
WORKDIR /app

# Copiar arquivos de configuração do Maven primeiro (cache de dependências)
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .

# Dar permissão de execução ao mvnw e baixar dependências (esta camada será cacheada)
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copiar código fonte
COPY src ./src

# Construir a aplicação
RUN ./mvnw clean package -DskipTests -B

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Criar usuário não-root por segurança
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copiar JAR do stage de build
COPY --from=build /app/target/*.jar app.jar

# Expor porta (Render usa a variável de ambiente PORT)
EXPOSE 8080

# Configurar JVM para containers
ENV JAVA_OPTS="-XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0"

# Comando para iniciar a aplicação
# Render define a variável PORT, que o Spring Boot vai usar
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=${PORT:-8080} -jar app.jar"]
