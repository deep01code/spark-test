@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem
@rem SPDX-License-Identifier: Apache-2.0
@rem

@if "%DEBUG%"=="" @echo off
@rem ##########################################################################
@rem
@rem  experement startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%"=="" set DIRNAME=.
@rem This is normally unused
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and EXPEREMENT_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if %ERRORLEVEL% equ 0 goto execute

echo. 1>&2
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH. 1>&2
echo. 1>&2
echo Please set the JAVA_HOME variable in your environment to match the 1>&2
echo location of your Java installation. 1>&2

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo. 1>&2
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME% 1>&2
echo. 1>&2
echo Please set the JAVA_HOME variable in your environment to match the 1>&2
echo location of your Java installation. 1>&2

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\experement-1.0-SNAPSHOT.jar;%APP_HOME%\lib\spark-sql_2.12-3.3.0.jar;%APP_HOME%\lib\spark-catalyst_2.12-3.3.0.jar;%APP_HOME%\lib\spark-core_2.12-3.3.0.jar;%APP_HOME%\lib\slf4j-simple-1.7.32.jar;%APP_HOME%\lib\avro-mapred-1.11.0.jar;%APP_HOME%\lib\avro-ipc-1.11.0.jar;%APP_HOME%\lib\avro-1.11.0.jar;%APP_HOME%\lib\hadoop-client-runtime-3.3.2.jar;%APP_HOME%\lib\jul-to-slf4j-1.7.32.jar;%APP_HOME%\lib\jcl-over-slf4j-1.7.32.jar;%APP_HOME%\lib\log4j-slf4j-impl-2.17.2.jar;%APP_HOME%\lib\stream-2.9.6.jar;%APP_HOME%\lib\spark-network-shuffle_2.12-3.3.0.jar;%APP_HOME%\lib\spark-network-common_2.12-3.3.0.jar;%APP_HOME%\lib\metrics-jvm-4.2.7.jar;%APP_HOME%\lib\metrics-json-4.2.7.jar;%APP_HOME%\lib\metrics-graphite-4.2.7.jar;%APP_HOME%\lib\metrics-jmx-4.2.7.jar;%APP_HOME%\lib\metrics-core-4.2.7.jar;%APP_HOME%\lib\orc-core-1.7.4.jar;%APP_HOME%\lib\orc-mapreduce-1.7.4.jar;%APP_HOME%\lib\hive-storage-api-2.7.2.jar;%APP_HOME%\lib\arrow-vector-7.0.0.jar;%APP_HOME%\lib\arrow-memory-netty-7.0.0.jar;%APP_HOME%\lib\orc-shims-1.7.4.jar;%APP_HOME%\lib\parquet-hadoop-1.12.2.jar;%APP_HOME%\lib\parquet-column-1.12.2.jar;%APP_HOME%\lib\parquet-encoding-1.12.2.jar;%APP_HOME%\lib\parquet-common-1.12.2.jar;%APP_HOME%\lib\parquet-format-structures-1.12.2.jar;%APP_HOME%\lib\arrow-memory-core-7.0.0.jar;%APP_HOME%\lib\slf4j-api-1.7.33.jar;%APP_HOME%\lib\spark-unsafe_2.12-3.3.0.jar;%APP_HOME%\lib\chill_2.12-0.10.0.jar;%APP_HOME%\lib\chill-java-0.10.0.jar;%APP_HOME%\lib\xbean-asm9-shaded-4.20.jar;%APP_HOME%\lib\hadoop-client-api-3.3.2.jar;%APP_HOME%\lib\spark-launcher_2.12-3.3.0.jar;%APP_HOME%\lib\spark-kvstore_2.12-3.3.0.jar;%APP_HOME%\lib\activation-1.1.1.jar;%APP_HOME%\lib\curator-recipes-2.13.0.jar;%APP_HOME%\lib\curator-framework-2.13.0.jar;%APP_HOME%\lib\curator-client-2.13.0.jar;%APP_HOME%\lib\zookeeper-3.6.2.jar;%APP_HOME%\lib\jakarta.servlet-api-4.0.3.jar;%APP_HOME%\lib\commons-codec-1.15.jar;%APP_HOME%\lib\commons-text-1.9.jar;%APP_HOME%\lib\commons-lang3-3.12.0.jar;%APP_HOME%\lib\commons-math3-3.6.1.jar;%APP_HOME%\lib\commons-io-2.11.0.jar;%APP_HOME%\lib\commons-collections-3.2.2.jar;%APP_HOME%\lib\commons-collections4-4.4.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\log4j-core-2.17.2.jar;%APP_HOME%\lib\log4j-1.2-api-2.17.2.jar;%APP_HOME%\lib\log4j-api-2.17.2.jar;%APP_HOME%\lib\compress-lzf-1.1.jar;%APP_HOME%\lib\snappy-java-1.1.8.4.jar;%APP_HOME%\lib\lz4-java-1.8.0.jar;%APP_HOME%\lib\zstd-jni-1.5.2-1.jar;%APP_HOME%\lib\RoaringBitmap-0.9.25.jar;%APP_HOME%\lib\scala-xml_2.12-1.2.0.jar;%APP_HOME%\lib\scala-reflect-2.12.15.jar;%APP_HOME%\lib\json4s-jackson_2.12-3.7.0-M11.jar;%APP_HOME%\lib\jackson-databind-2.13.3.jar;%APP_HOME%\lib\jackson-core-2.13.3.jar;%APP_HOME%\lib\jackson-annotations-2.13.3.jar;%APP_HOME%\lib\jackson-module-scala_2.12-2.13.3.jar;%APP_HOME%\lib\spark-sketch_2.12-3.3.0.jar;%APP_HOME%\lib\spark-tags_2.12-3.3.0.jar;%APP_HOME%\lib\json4s-core_2.12-3.7.0-M11.jar;%APP_HOME%\lib\scala-parser-combinators_2.12-1.1.2.jar;%APP_HOME%\lib\json4s-ast_2.12-3.7.0-M11.jar;%APP_HOME%\lib\json4s-scalap_2.12-3.7.0-M11.jar;%APP_HOME%\lib\scala-library-2.12.15.jar;%APP_HOME%\lib\jersey-container-servlet-2.34.jar;%APP_HOME%\lib\jersey-container-servlet-core-2.34.jar;%APP_HOME%\lib\jersey-server-2.34.jar;%APP_HOME%\lib\jersey-client-2.34.jar;%APP_HOME%\lib\jersey-hk2-2.34.jar;%APP_HOME%\lib\jersey-common-2.34.jar;%APP_HOME%\lib\netty-all-4.1.74.Final.jar;%APP_HOME%\lib\ivy-2.5.0.jar;%APP_HOME%\lib\oro-2.0.8.jar;%APP_HOME%\lib\pickle-1.2.jar;%APP_HOME%\lib\py4j-0.10.9.5.jar;%APP_HOME%\lib\commons-crypto-1.1.0.jar;%APP_HOME%\lib\unused-1.0.0.jar;%APP_HOME%\lib\rocksdbjni-6.20.3.jar;%APP_HOME%\lib\univocity-parsers-2.9.1.jar;%APP_HOME%\lib\commons-compress-1.21.jar;%APP_HOME%\lib\kryo-shaded-4.0.2.jar;%APP_HOME%\lib\commons-logging-1.1.3.jar;%APP_HOME%\lib\leveldbjni-all-1.8.jar;%APP_HOME%\lib\tink-1.6.1.jar;%APP_HOME%\lib\commons-lang-2.6.jar;%APP_HOME%\lib\zookeeper-jute-3.6.2.jar;%APP_HOME%\lib\audience-annotations-0.12.0.jar;%APP_HOME%\lib\shims-0.9.25.jar;%APP_HOME%\lib\jakarta.ws.rs-api-2.1.6.jar;%APP_HOME%\lib\hk2-locator-2.6.1.jar;%APP_HOME%\lib\hk2-api-2.6.1.jar;%APP_HOME%\lib\hk2-utils-2.6.1.jar;%APP_HOME%\lib\jakarta.inject-2.6.1.jar;%APP_HOME%\lib\jakarta.annotation-api-1.3.5.jar;%APP_HOME%\lib\osgi-resource-locator-1.0.3.jar;%APP_HOME%\lib\jakarta.validation-api-2.0.2.jar;%APP_HOME%\lib\javassist-3.25.0-GA.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.74.Final-linux-x86_64.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.74.Final-linux-aarch_64.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.74.Final.jar;%APP_HOME%\lib\netty-transport-native-kqueue-4.1.74.Final-osx-x86_64.jar;%APP_HOME%\lib\netty-transport-native-kqueue-4.1.74.Final-osx-aarch_64.jar;%APP_HOME%\lib\netty-transport-classes-epoll-4.1.74.Final.jar;%APP_HOME%\lib\netty-transport-classes-kqueue-4.1.74.Final.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.74.Final.jar;%APP_HOME%\lib\netty-handler-4.1.74.Final.jar;%APP_HOME%\lib\netty-codec-4.1.74.Final.jar;%APP_HOME%\lib\netty-transport-4.1.74.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.74.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.74.Final.jar;%APP_HOME%\lib\netty-common-4.1.74.Final.jar;%APP_HOME%\lib\netty-tcnative-classes-2.0.48.Final.jar;%APP_HOME%\lib\paranamer-2.8.jar;%APP_HOME%\lib\janino-3.0.16.jar;%APP_HOME%\lib\commons-compiler-3.0.16.jar;%APP_HOME%\lib\antlr4-runtime-4.8.jar;%APP_HOME%\lib\protobuf-java-3.14.0.jar;%APP_HOME%\lib\aircompressor-0.21.jar;%APP_HOME%\lib\annotations-17.0.0.jar;%APP_HOME%\lib\threeten-extra-1.5.0.jar;%APP_HOME%\lib\parquet-jackson-1.12.2.jar;%APP_HOME%\lib\xz-1.9.jar;%APP_HOME%\lib\minlog-1.3.0.jar;%APP_HOME%\lib\objenesis-2.5.1.jar;%APP_HOME%\lib\gson-2.8.6.jar;%APP_HOME%\lib\aopalliance-repackaged-2.6.1.jar;%APP_HOME%\lib\arrow-format-7.0.0.jar;%APP_HOME%\lib\flatbuffers-java-1.12.0.jar;%APP_HOME%\lib\javax.annotation-api-1.3.2.jar;%APP_HOME%\lib\guava-16.0.1.jar


@rem Execute experement
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %EXPEREMENT_OPTS%  -classpath "%CLASSPATH%" org.ksu.PstMajorApplication %*

:end
@rem End local scope for the variables with windows NT shell
if %ERRORLEVEL% equ 0 goto mainEnd

:fail
rem Set variable EXPEREMENT_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
set EXIT_CODE=%ERRORLEVEL%
if %EXIT_CODE% equ 0 set EXIT_CODE=1
if not ""=="%EXPEREMENT_EXIT_CONSOLE%" exit %EXIT_CODE%
exit /b %EXIT_CODE%

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
