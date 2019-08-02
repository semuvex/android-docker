FROM openjdk:8-jdk
MAINTAINER Sebastian Münz <sebastian.muenz@semuvex.com>

ENV ANDROID_COMPILE_SDK "28"
ENV ANDROID_BUILD_TOOLS "28.0.3"
ENV ANDROID_SDK_TOOLS "4333796"
ENV ANDROID_SDK_FOLDER "android-sdk-linux"

RUN pwd \
    apt-get --quiet update --yes \
    apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 \
    wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip \
    unzip -d ${ANDROID_SDK_FOLDER} -qq android-sdk.zip \
    ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager --list || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platform-tools" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;android;m2repository" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;google;m2repository" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;google;google_play_services" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "cmake;3.6.4111459" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager "ndk-bundle" | grep -v = || true \
    echo yes | ${ANDROID_SDK_FOLDER}/tools/bin/sdkmanager --licenses \
    
ENV ANDROID_HOME=${PWD}/${ANDROID_SDK_FOLDER}
ENV ANDROID_NDK_HOME=${ANDROID_HOME}/ndk-bundle
ENV PATH=$PATH:${ANDROID_HOME}
ENV PATH=$PATH:${ANDROID_HOME}/tools
ENV PATH=$PATH:${ANDROID_HOME}/tools/bin
