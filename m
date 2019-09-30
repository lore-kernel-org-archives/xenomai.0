From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v3 2/2] ci: Clarify ci variables
Date: Mon, 30 Sep 2019 16:05:34 +0200
Message-Id: <20190930140534.25731-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <901ed017-ab67-f975-b471-8753adbb4e97@siemens.com>
References: <901ed017-ab67-f975-b471-8753adbb4e97@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add documentation for each variable to tests/README.md. Rename
variables to show the purpose. Variables related to creating a ssh
tunnel to the LAVA Master start with LAVA_SSH_. Variables related
to the LAVA_MASTER_ start with LAVA_MASTER_.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                | 15 +++++++--------
 scripts/deploy_for_testing.sh | 20 +++++++++++---------
 scripts/run-lava-tests.sh     | 12 ++++++++----
 tests/README.md               | 22 ++++++++++++++++++++--
 4 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bc51b00..7de99ee 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,10 +27,9 @@ default:
 .add-lava-ssh-config: &lava-ssh-key
   before_script:
     - mkdir -p -m=700 ~/.ssh
-    - echo "$LAVA_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
+    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
     - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
-    - echo "$LAVA_KNOWN_HOST" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
-
+    - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
 build:qemu-amd64:
   <<: *lava-ssh-key
   stage: build
@@ -47,7 +46,7 @@ lava-test:qemu-amd64:
   needs: [ "build:qemu-amd64" ]
   only:
     variables:
-      - $LAVA_USER
+      - $LAVA_SSH_USER
 
 build:qemu-armhf:
   <<: *lava-ssh-key
@@ -65,7 +64,7 @@ lava-test:qemu-armhf:
   needs: [ "build:qemu-armhf" ]
   only:
     variables:
-      - $LAVA_USER
+      - $LAVA_SSH_USER
 
 build:qemu-arm64:
   <<: *lava-ssh-key
@@ -83,7 +82,7 @@ lava-test:qemu-arm64:
   needs: [ "build:qemu-arm64" ]
   only:
     variables:
-      - $LAVA_USER
+      - $LAVA_SSH_USER
 
 build:board-hikey:
   <<: *lava-ssh-key
@@ -109,7 +108,7 @@ lava-test:board-beaglebone:
   needs: [ "build:board-beaglebone" ]
   only:
     variables:
-      - $LAVA_USER
+      - $LAVA_SSH_USER
 
 build:board-x86-64-efi:
   <<: *lava-ssh-key
@@ -127,4 +126,4 @@ lava-test:board-x86-64-efi:
   needs: [ "build:board-x86-64-efi" ]
   only:
     variables:
-      - $LAVA_USER
+      - $LAVA_SSH_USER
diff --git a/scripts/deploy_for_testing.sh b/scripts/deploy_for_testing.sh
index 8a2e97c..4015b87 100755
--- a/scripts/deploy_for_testing.sh
+++ b/scripts/deploy_for_testing.sh
@@ -18,23 +18,25 @@ if [ -z "${TARGET}" ]; then
 fi
 IMAGES_DIR=build/tmp/deploy/images
 
-if [ -z "${LAVA_USER}" ] || [ -z "${LAVA_HOST}" ]  || [ -z "${LAVA_PORT}" ]; then
+if [ -z "${LAVA_SSH_USER}" ] || [ -z "${LAVA_SSH_HOST}" ]  || [ -z "${LAVA_SSH_PORT}" ]; then
     echo "Lava environment not available or incomplete - do not deploy"
     exit 0
 fi
 
-LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"
+LAVA_SSH_DESTINATION="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
+
+DEPLOY_DIR="/var/lib/lava/artifacts"
 #KERNEL
-scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-vmlinuz \
-    ${LAVA_MASTER}:/var/lib/lava/artifacts
+scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-vmlinuz \
+    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
 # INITRD
-scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-initrd.img \
-    ${LAVA_MASTER}:/var/lib/lava/artifacts
+scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-initrd.img \
+    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
 # ROOTFS
-scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.* \
-    ${LAVA_MASTER}:/var/lib/lava/artifacts
+scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.* \
+    ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
 # DTB
 DTB="${IMAGES_DIR}/${TARGET}/*.dtb"
 if [ -e ${DTB} ]; then
-    scp -P ${LAVA_PORT} ${DTB} ${LAVA_MASTER}:/var/lib/lava/artifacts
+    scp -P ${LAVA_SSH_PORT} ${DTB} ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
 fi
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 8f49917..9195275 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -12,10 +12,13 @@
 set -e
 TARGET=$1
 
-LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"
 LAVA_MASTER_PORT=28080
+if [ -n "${LAVA_SSH_PORT}" ]; then
+    LAVA_SSH_PORT="-p ${LAVA_SSH_PORT}"
+fi
+LAVA_SSH_DESTINATION="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
 # open connection for ssh port forwarding
-ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_MASTER} &
+ssh -N ${LAVA_SSH_PORT} -o 'LocalForward localhost:'${LAVA_MASTER_PORT}' localhost:80' ${LAVA_SSH_DESTINATION} &
 # wait for connection
 INTERVAL=1
 TIMEOUT=60
@@ -28,9 +31,10 @@ do
     sleep ${INTERVAL}
     TIMEOUT=$(expr ${TIMEOUT} - ${INTERVAL})
 done
-# connect to lava master
-lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:${LAVA_MASTER_PORT} --username ${LAVA_ACCOUNT} default
+LAVA_MASTER_URI=http://localhost:${LAVA_MASTER_PORT}
 
+# connect to lava master
+lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${LAVA_MASTER_URI} --username ${LAVA_MASTER_ACCOUNT} default
 test_id=$(lavacli jobs submit tests/jobs/xenomai-${TARGET}.yml)
 lavacli jobs logs ${test_id}
 lavacli results ${test_id}
diff --git a/tests/README.md b/tests/README.md
index 392b6b4..01b956e 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -44,9 +44,9 @@ is used:
                                                                | Target 1 |
                                                             /--|  beagle  |
 +-----------+        +---------+       +---------+    /-----   |  bone    |
-|           |        | LAVA    |       | LAVA    | ---         +----------+
+|           |  ssh   | LAVA    |       | LAVA    | ---         +----------+
 | gitlab-   | ------ | master  |------ | Dis-    | --
-| runner    |        |         |       | patcher | \ \---      +----------+
+| runner    | tunnel |         |       | patcher | \ \---      +----------+
 +-----------+        +---------+       +---------+  \-   \---  | Target 2 |
                                                       \      \-| x86-64   |
                                                        \       |          |
@@ -84,3 +84,21 @@ and adds them to the rootfs
 Setup a lava environment by following the
 [installation guide](https://docs.lavasoftware.org/lava/first-installation.html)
 or use [lava-docker](https://github.com/kernelci/lava-docker).
+
+# CI Variables
+
+The following variables are used and set by the ci system:
+- `HTTP_PROXY`    : proxy settings
+- `HTTPS_PROXY`   : proxy settings
+- `FTP_PROXY`     : proxy settings
+- `NO_PROXY`      : proxy settings
+- `LAVA_SSH_USER` : ssh user to connect to the LAVA master
+- `LAVA_SSH_HOST` : ssh host name to connect to the LAVA master
+- `LAVA_SSH_PORT` : ssh port used for the ssh tunnel
+- `LAVA_SSH_UPLOAD_KEY`  :  private ssh key to connect to the LAVA master
+- `LAVA_SSH_KNOWN_HOSTS` : Known hosts to connect via ssh to the host given by `LAVA_SSH_HOST`
+- `LAVA_MASTER_ACCOUNT`  : lava master account name to register lavacli for test execution
+- `LAVA_MASTER_TOKEN`    : token to connect with the lava master
+- `LAVA_DEPLOY_DIR`    : optional variable to define directory to store the build artifacts
+- `LAVA_ARTIFACTS_URL` : optional variable where to get the artifacts for testing
+- `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
-- 
2.20.1


