# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.145.0/containers/typescript-node/.devcontainer/base.Dockerfile

# [Choice] Node.js version: 14, 12, 10
ARG VARIANT="10-buster"
FROM mcr.microsoft.com/vscode/devcontainers/typescript-node:0-${VARIANT}

# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - \
    && add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ \ 
    && apt-get update \
    && apt-get -y install --no-install-recommends adoptopenjdk-8-openj9
ENV JAVA_HOME /usr/lib/jvm/adoptopenjdk-8-openj9-amd64

ENV SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip" \
    ANDROID_SDK_ROOT="/usr/local/android-sdk" \
    ANDROID_VERSION=26 \
    ANDROID_BUILD_TOOLS_VERSION=30.0.2

# Download Android SDK
RUN mkdir "$ANDROID_SDK_ROOT" .android && \
    mkdir ${ANDROID_SDK_ROOT}/cmdline-tools && \
    cd "$ANDROID_SDK_ROOT" && \
    curl -o sdk.zip $SDK_URL && \
    unzip sdk.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    rm sdk.zip && \
    mkdir "$ANDROID_SDK_ROOT/licenses" || true && \
    echo "24333f8a63b6825ea9c5514f83c2829b004d1fee" > "$ANDROID_SDK_ROOT/licenses/android-sdk-license" && \
    yes | $ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager --licenses

ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin:${ANDROID_SDK_ROOT}/platform-tools

# Install Android Build Tool and Libraries
RUN $ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager --update && \
    $ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
    "platforms;android-${ANDROID_VERSION}" \
    "platform-tools"

# RUN touch ~/.android/repositories.cfg && \
#     $ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager "emulator" && \
#     $ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager "system-images;android-30;google_apis_playstore;x86" && \
#     $ANDROID_SDK_ROOT/cmdline-tools/tools/bin/sdkmanager "system-images;android-26;google_apis_playstore;x86"
# ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/emulator

# [Optional] Uncomment if you want to install an additional version of node using nvm
# ARG EXTRA_NODE_VERSION=10
# RUN su node -c "source /usr/local/share/nvm/nvm.sh && nvm install ${EXTRA_NODE_VERSION}"

# [Optional] Uncomment if you want to install more global node packages
# RUN sudo -u node npm install -g <your-package-list -here>
RUN sudo -u node npm install -g cordova @ionic/cli cordova-res @ionic/app-scripts@3.2.1 native-run

# Fetch gradle
RUN mkdir "/usr/local/gradle" && \
    cd "/usr/local" && \
    curl -o gradle67.zip https://downloads.gradle-dn.com/distributions/gradle-6.7-bin.zip && \
    unzip gradle67.zip -d /usr/local/gradle && \
    rm gradle67.zip
ENV PATH ${PATH}:/usr/local/gradle/gradle-6.7/bin

RUN cd "/usr/local" && \
    curl -o gradle41.zip https://downloads.gradle-dn.com/distributions/gradle-4.1-bin.zip && \
    unzip gradle41.zip -d /usr/local/gradle && \
    rm gradle41.zip
ENV PATH ${PATH}:/usr/local/gradle/gradle-4.1/bin
