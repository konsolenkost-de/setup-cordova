FROM runmymind/docker-android-sdk:ubuntu-standalone

# Setup Android SDK
RUN su android -c '/opt/tools/android-accept-licenses.sh "${ANDROID_HOME}/sdkmanager ${SDKMNGR_OPTS} \"build-tools;33.0.2\""'

# Setup NodeJS
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    echo "safe-perm=true" > ~/.npmrc
    
# Setup Gradle
RUN wget https://services.gradle.org/distributions/gradle-7.6.4-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-7.6.4-bin.zip
ENV GRADLE_HOME="/opt/gradle/gradle-7.6.4"
ENV PATH="$PATH:$GRADLE_HOME/bin"

# Setup Cordova
RUN npm i -g cordova@12.0.0

COPY entrypoint.sh /usr/src/entrypoint.sh

ENTRYPOINT ["/usr/src/entrypoint.sh"]
