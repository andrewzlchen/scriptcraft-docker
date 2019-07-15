FROM openjdk:8
COPY start.sh /root
RUN chmod +x /root/start.sh
RUN mkdir /root/spigotmc
COPY server.properties /root/spigotmc
RUN /root/start.sh
EXPOSE 25565:25565

WORKDIR /root/spigotmc
# CMD runs at run-time, everything else is done at buildtime
CMD ["java", "-jar", "/root/spigotmc/spigot-1.13.2.jar"]
