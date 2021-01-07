FROM netflixoss/genie-app:latest.candidate

LABEL maintainer="tjveil@gmail.com"

COPY application-crdb.yml /usr/local/bin/application-crdb.yml

EXPOSE 8080

WORKDIR /usr/local/bin

ENTRYPOINT ["java", \
            "-Djava.security.egd=file:/dev/./urandom", \
            "-Dgenie.agent.launcher.local.agent-jar-path=genie-agent.jar", \
            "-Dgenie.jobs.agent-execution.agent-probability=1.0", \
            "-jar", \
            "genie-server.jar", \
            "--spring.profiles.active=crdb" \
            ]

