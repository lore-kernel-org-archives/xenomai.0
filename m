From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [Xenomai-images PATCH 1/4] ci: Build and test from gitlab.com
Date: Tue, 21 Apr 2020 10:31:27 +0200
Message-Id: <20200421083130.13437-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200421083130.13437-1-Quirin.Gylstorff@siemens.com>
References: <20200421083130.13437-1-Quirin.Gylstorff@siemens.com>
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
To: xenomai@xenomai.org, Jan.Kiszka@siemens.com

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Adapt scripts and gitlab-ci.yml to build on public available
gitlab infrastructure.

As the internal gitlab system has no artifact storage and
it is not possible to deactivate arifact upload with a variable
split the gitlab-ci.yml. The .gitlab-ci.yml in the root points
to .ci/gitlab-com.yml.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .ci/gitlab-ci-base.yml                        | 153 ++++++++++++++++++
 .ci/gitlab-com.yml                            |  26 +++
 .ci/siemens-ci.yml                            |  22 +++
 .gitlab-ci.yml                                | 145 +----------------
 scripts/deploy_for_testing.sh                 |   4 +-
 scripts/get-build-id.sh                       |  29 ++++
 scripts/install-lavacli.sh                    |   5 +-
 scripts/run-lava-tests.sh                     |   8 +-
 ...bone.yml => xenomai-beagle-bone-black.yml} |   4 +-
 tests/jobs/xenomai-hikey.yml                  |   4 +-
 tests/jobs/xenomai-ipc227e.yml                |   6 +-
 tests/jobs/xenomai-minnow.yml                 |   6 +-
 tests/jobs/xenomai-qemu-amd64.yml             |   6 +-
 tests/jobs/xenomai-qemu-arm64.yml             |   6 +-
 tests/jobs/xenomai-qemu-armhf.yml             |   6 +-
 ...omai-x86-64.yml => xenomai-x86-64-efi.yml} |   6 +-
 16 files changed, 265 insertions(+), 171 deletions(-)
 create mode 100644 .ci/gitlab-ci-base.yml
 create mode 100644 .ci/gitlab-com.yml
 create mode 100644 .ci/siemens-ci.yml
 create mode 100755 scripts/get-build-id.sh
 rename tests/jobs/{xenomai-beaglebone.yml => xenomai-beagle-bone-black.yml} (91%)
 rename tests/jobs/{xenomai-x86-64.yml => xenomai-x86-64-efi.yml} (86%)

diff --git a/.ci/gitlab-ci-base.yml b/.ci/gitlab-ci-base.yml
new file mode 100644
index 0000000..e8d259f
--- /dev/null
+++ b/.ci/gitlab-ci-base.yml
@@ -0,0 +1,153 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+stages:
+  - build
+  - lava-test
+
+variables:
+  GIT_STRATEGY: clone
+  http_proxy: "$HTTP_PROXY"
+  https_proxy: "$HTTPS_PROXY"
+  ftp_proxy: "$FTP_PROXY"
+  no_proxy: "$NO_PROXY"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
+  LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
+  ISAR_IMAGE: demo-image
+  ISAR_DISTRIBUTION: xenomai-demo
+
+default:
+  image: kasproject/kas-isar:latest
+
+# add lavacli to the container and install the ssh keys
+# for the test infrastructure
+.add-lava-ssh-config:
+  before_script:
+    - mkdir -p -m=700 ~/.ssh
+    - if [ -n "$https_proxy" ]; then echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config; fi;
+    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
+    - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
+
+.test:
+  extends: .add-lava-ssh-config
+  stage: lava-test
+  script:
+    - scripts/install-lavacli.sh
+    - export BUILD_JOB_ID=$(scripts/get-build-id.sh ${BUILD_JOB_NAME})
+    - scripts/run-lava-tests.sh ${TARGET}
+  variables:
+    BUILD_JOB_NAME: "build:board-${TARGET}${TARGET_EXTENSION}"
+  only:
+    variables:
+      - $LAVA_SSH_USER
+
+
+build:board-qemu-amd64:
+  extends: .build
+  variables:
+    TARGET: qemu-amd64
+
+lava-test:qemu-amd64:
+  needs: [ "build:board-qemu-amd64" ]
+  dependencies: [ "build:board-qemu-amd64" ]
+  extends: .test
+  variables:
+    TARGET: qemu-amd64
+
+build:board-qemu-armhf:
+  extends: .build
+  variables:
+    TARGET: qemu-armhf
+
+lava-test:qemu-armhf:
+  needs: [ "build:board-qemu-armhf" ]
+  extends: .test
+  variables:
+    TARGET: qemu-armhf
+
+build:board-qemu-arm64:
+  extends: .build
+  variables:
+    TARGET: qemu-arm64
+
+lava-test:qemu-arm64:
+  needs: [ "build:board-qemu-arm64" ]
+  extends: .test
+  variables:
+    TARGET: qemu-arm64
+
+build:board-hikey:
+  extends: .build
+  variables:
+    TARGET: hikey
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+
+lava-test:board-hikey:
+  needs: [ "build:board-hikey" ]
+  extends: .test
+  variables:
+    TARGET: hikey
+
+build:board-beagle-bone-black:
+  extends: .build
+  variables:
+    TARGET: beagle-bone-black
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+
+lava-test:board-beagle-bone-black:
+  needs: [ "build:board-beagle-bone-black" ]
+  extends: .test
+  variables:
+    TARGET: beagle-bone-black
+
+build:board-x86-64-efi:
+  extends: .build
+  variables:
+    TARGET: x86-64-efi
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+
+lava-test:board-x86-64-efi:
+  needs: [ "build:board-x86-64-efi" ]
+  extends: .test
+  variables:
+    TARGET: x86-64-efi
+
+build:board-beagle-bone-black:xenomai-3.0.x:
+  extends: .build
+  variables:
+    TARGET: beagle-bone-black
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+
+lava-test:board-beagle-bone-black:xenomai-3.0.x:
+  needs: [ "build:board-beagle-bone-black:xenomai-3.0.x" ]
+  extends: .test
+  variables:
+    TARGET: beagle-bone-black
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+    TARGET_EXTENSION: ":xenomai-3.0.x"
+
+build:board-x86-64-efi:xenomai-3.0.x:
+  extends: .build
+  variables:
+    TARGET: x86-64-efi
+    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
+    BUILD_OPTIONS: ":opt-lava-test.yml"
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+
+lava-test:board-x86-64-efi:xenomai-3.0.x:
+  needs: [ "build:board-x86-64-efi:xenomai-3.0.x" ]
+  extends: .test
+  variables:
+    TARGET: x86-64-efi
+    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+    TARGET_EXTENSION: ":xenomai-3.0.x"
+
diff --git a/.ci/gitlab-com.yml b/.ci/gitlab-com.yml
new file mode 100644
index 0000000..0abb3fb
--- /dev/null
+++ b/.ci/gitlab-com.yml
@@ -0,0 +1,26 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+.build:
+  extends: .add-lava-ssh-config
+  stage: build
+  script:
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
+  artifacts:
+    paths:
+    - build/tmp/deploy/images/${TARGET}/
+    expire_in: 1 week
+  only:
+    variables:
+      - $USE_GITLAB_ARTIFACTS
+include:
+  - local: '/.ci/gitlab-ci-base.yml'
+
+
diff --git a/.ci/siemens-ci.yml b/.ci/siemens-ci.yml
new file mode 100644
index 0000000..58b5fcd
--- /dev/null
+++ b/.ci/siemens-ci.yml
@@ -0,0 +1,22 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+.build:
+  extends: .add-lava-ssh-config
+  stage: build
+  script:
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
+    - scripts/deploy_for_testing.sh ${TARGET}
+  except:
+    variables:
+      - $USE_GITLAB_ARTIFACTS
+include:
+  - local: '/.ci/gitlab-ci-base.yml'
+
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 45fccd0..0eb3abc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,146 +8,5 @@
 #
 # SPDX-License-Identifier: MIT
 #
-stages:
-  - build
-  - lava-test
-
-variables:
-  GIT_STRATEGY: clone
-  http_proxy: "$HTTP_PROXY"
-  https_proxy: "$HTTPS_PROXY"
-  ftp_proxy: "$FTP_PROXY"
-  no_proxy: "$NO_PROXY"
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
-  LINUX_BUILD_OPTION: ":opt-linux-latest.yml"
-  ISAR_IMAGE: demo-image
-  ISAR_DISTRIBUTION: xenomai-demo
-
-default:
-  image: kasproject/kas-isar:latest
-
-# add lavacli to the container and install the ssh keys
-# for the test infrastructure
-.add-lava-ssh-config:
-  before_script:
-    - mkdir -p -m=700 ~/.ssh
-    - if [ -n "$https_proxy" ]; then echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config; fi;
-    - echo "$LAVA_SSH_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/lava_id_rsa && chmod 600 ~/.ssh/lava_id_rsa
-    - echo "$LAVA_SSH_KNOWN_HOSTS" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
-
-.build:
-  extends: .add-lava-ssh-config
-  stage: build
-  script:
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
-    - scripts/deploy_for_testing.sh ${TARGET}
-
-.test:
-  extends: .add-lava-ssh-config
-  stage: lava-test
-  script:
-    - scripts/install-lavacli.sh
-    - scripts/run-lava-tests.sh ${TARGET}
-  only:
-    variables:
-      - $LAVA_SSH_USER
-
-
-build:qemu-amd64:
-  extends: .build
-  variables:
-    TARGET: qemu-amd64
-
-lava-test:qemu-amd64:
-  needs: [ "build:qemu-amd64" ]
-  extends: .test
-  variables:
-    TARGET: qemu-amd64
-
-build:qemu-armhf:
-  extends: .build
-  variables:
-    TARGET: qemu-armhf
-
-lava-test:qemu-armhf:
-  needs: [ "build:qemu-armhf" ]
-  extends: .test
-  variables:
-    TARGET: qemu-armhf
-
-build:qemu-arm64:
-  extends: .build
-  variables:
-    TARGET: qemu-arm64
-
-lava-test:qemu-arm64:
-  needs: [ "build:qemu-arm64" ]
-  extends: .test
-  variables:
-    TARGET: qemu-arm64
-
-build:board-hikey:
-  extends: .build
-  variables:
-    TARGET: hikey
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-lava-test:board-hikey:
-  needs: [ "build:board-hikey" ]
-  extends: .test
-  variables:
-    TARGET: hikey
-
-build:board-beaglebone:
-  extends: .build
-  variables:
-    TARGET: beagle-bone-black
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-
-
-lava-test:board-beaglebone:
-  needs: [ "build:board-beaglebone" ]
-  extends: .test
-  variables:
-    TARGET: beaglebone
-
-build:board-x86-64-efi:
-  extends: .build
-  variables:
-    TARGET: x86-64-efi
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-
-lava-test:board-x86-64-efi:
-  needs: [ "build:board-x86-64-efi" ]
-  extends: .test
-  variables:
-    TARGET: x86-64
-
-build:board-beaglebone:xenomai-3.0.x:
-  extends: .build
-  variables:
-    TARGET: beagle-bone-black
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-
-lava-test:board-beaglebone:xenomai-3.0.x:
-  needs: [ "build:board-beaglebone:xenomai-3.0.x" ]
-  extends: .test
-  variables:
-    TARGET: beaglebone
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-
-build:board-x86-64-efi:xenomai-3.0.x:
-  extends: .build
-  variables:
-    TARGET: x86-64-efi
-    XENOMAI_BUILD_OPTION: ":opt-xenomai-3.0.x.yml"
-    BUILD_OPTIONS: ":opt-lava-test.yml"
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
-
-lava-test:board-x86-64-efi:xenomai-3.0.x:
-  needs: [ "build:board-x86-64-efi:xenomai-3.0.x" ]
-  extends: .test
-  variables:
-    TARGET: ipc227e
-    DEPLOY_DIR_EXTENSION: "xenomai-3.0.x"
+include:
+  - local: '/.ci/gitlab-com.yml'
diff --git a/scripts/deploy_for_testing.sh b/scripts/deploy_for_testing.sh
index b3d565f..3878e7d 100755
--- a/scripts/deploy_for_testing.sh
+++ b/scripts/deploy_for_testing.sh
@@ -14,7 +14,7 @@ set -e
 target="$1"
 
 if [ -z "${target}" ]; then
-    exit -1
+    exit 1
 fi
 images_dir=build/tmp/deploy/images
 
@@ -39,7 +39,7 @@ scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_nam
 scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_name}-initrd.img \
     ${lava_ssh_destination}:${deploy_dir}
 # ROOTFS
-if [ -n ${images_dir}/${target}/${isar_base_name}.*.gz  ]; then
+if [ ! -e ${images_dir}/${target}/${isar_base_name}.*.gz  ]; then
     gzip ${images_dir}/${target}/${isar_base_name}.*
 fi
 scp -P ${LAVA_SSH_PORT} ${lava_identity} ${images_dir}/${target}/${isar_base_name}.* \
diff --git a/scripts/get-build-id.sh b/scripts/get-build-id.sh
new file mode 100755
index 0000000..ace70c6
--- /dev/null
+++ b/scripts/get-build-id.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+name=$1
+if [ -z "${name}" ]; then
+    echo "no build name was given"
+    exit -1
+    fi
+index=0
+JSON=$(curl -s --header "PRIVATE-TOKEN: ${API_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/pipelines/${CI_PIPELINE_ID}/jobs?scope[]=success"  )
+while  [ ${index} -le ${MAX_TEST:-16} ]
+do
+    build_name=$(echo "${JSON}"  | tr '\r\n' ' ' | jq -r ".[${index}].name")
+    if [ "$build_name" = "${name}" ]; then
+        break
+    fi
+     index=$((index+1))
+done
+id=$(echo "${JSON}"  | tr '\r\n' ' ' | jq -r ".[${index}].id")
+echo $id
diff --git a/scripts/install-lavacli.sh b/scripts/install-lavacli.sh
index f31a394..7f7a052 100755
--- a/scripts/install-lavacli.sh
+++ b/scripts/install-lavacli.sh
@@ -13,9 +13,10 @@
 # of lavacli. The apt version from stretch-backports cannot communicate
 # with the lava master on Debian 10.
 os_version_id=$(sed -nr 's/VERSION_ID="([0-9]+)"/\1/p' /etc/os-release)
+sudo apt-get update
+sudo apt-get install -y jq
 if [ "${os_version_id}" -ge "10" ]; then
-    sudo apt update
-    sudo apt install -y lavacli
+    sudo apt-get install -y lavacli
 else
     sudo pip3 install wheel
     sudo pip3 install lavacli
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 1f502c4..8566493 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -42,8 +42,12 @@ lava_master_uri=http://localhost:${lava_master_port}
 # connect to lava master
 lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${lava_master_uri} --username ${LAVA_MASTER_ACCOUNT} default
 #generate lava job description from template
-artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
-DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
+if [ -n "${USE_GITLAB_ARTIFACTS}" ]; then
+    DEPLOY_URL="${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/jobs/${BUILD_JOB_ID}/artifacts/build/tmp/deploy/images/${TARGET}"
+else
+    artifact_url="${LAVA_ARTIFACTS_URL:-http://localhost/artifacts}"
+    DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}/${DEPLOY_DIR_EXTENSION}"
+fi
 job_template_path="${JOB_TEMPLATE_PATH:-tests/jobs/xenomai}"
 tmp_dir=$(mktemp -d)
 template=${tmp_dir}/job_${TARGET}_${CI_PIPELINE_ID}.yml
diff --git a/tests/jobs/xenomai-beaglebone.yml b/tests/jobs/xenomai-beagle-bone-black.yml
similarity index 91%
rename from tests/jobs/xenomai-beaglebone.yml
rename to tests/jobs/xenomai-beagle-bone-black.yml
index ceb4d0d..91cb138 100644
--- a/tests/jobs/xenomai-beaglebone.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -32,12 +32,12 @@ actions:
       minutes: 5
     to: tftp
     kernel:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-beagle-bone-black-vmlinuz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       type: zimage
     dtb:
       url: ${DEPLOY_URL}/am335x-boneblack.dtb
     nfsrootfs:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-beagle-bone-black.tar.gz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
       compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index 3e52212..b33cef6 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -31,12 +31,12 @@ actions:
       minutes: 30
     to: tftp
     kernel:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-hikey-vmlinuz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       type: image
     dtb:
       url: ${DEPLOY_URL}/hi6220-hikey.dtb
     nfsrootfs:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-hikey.tar.gz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
       compression: gz
 #  BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
index e5a2f35..d283c00 100644
--- a/tests/jobs/xenomai-ipc227e.yml
+++ b/tests/jobs/xenomai-ipc227e.yml
@@ -32,13 +32,13 @@ actions:
       minutes: 5
     to: tftp
     kernel:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-vmlinuz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       type: bzimage
     ramdisk:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-initrd.img
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       compression: gz
     nfsrootfs:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi.tar.gz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
       compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-minnow.yml b/tests/jobs/xenomai-minnow.yml
index 27a0f81..82c1468 100644
--- a/tests/jobs/xenomai-minnow.yml
+++ b/tests/jobs/xenomai-minnow.yml
@@ -31,13 +31,13 @@ actions:
       minutes: 5
     to: tftp
     kernel:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-vmlinuz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       type: bzimage
     ramdisk:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-initrd.img
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       compression: gz
     nfsrootfs:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi.tar.gz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
       compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 33ff1b2..68d849f 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -47,13 +47,13 @@ actions:
     images:
       kernel:
         image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0"
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64-vmlinuz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64-initrd.img
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64.ext4.img.gz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.img.gz
         compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 2a98889..cd0ca9f 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -51,13 +51,13 @@ actions:
     images:
       kernel:
         image_arg: -kernel {kernel} -append "root=/dev/vda"
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64-vmlinuz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64-initrd.img
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64.ext4.img.gz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.img.gz
         compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 2949cd2..18e3bf8 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -47,13 +47,13 @@ actions:
     images:
       kernel:
         image_arg: -kernel {kernel} -append "root=/dev/vdb"
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf-vmlinuz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf-initrd.img
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf.ext4.img.gz
+        url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.ext4.img.gz
         compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-x86-64.yml b/tests/jobs/xenomai-x86-64-efi.yml
similarity index 86%
rename from tests/jobs/xenomai-x86-64.yml
rename to tests/jobs/xenomai-x86-64-efi.yml
index c7424c0..2471cce 100644
--- a/tests/jobs/xenomai-x86-64.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -32,13 +32,13 @@ actions:
       minutes: 5
     to: tftp
     kernel:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-vmlinuz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       type: bzimage
     ramdisk:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-initrd.img
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-initrd.img
       compression: gz
     nfsrootfs:
-      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi.tar.gz
+      url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}.tar.gz
       compression: gz
 # BOOT_BLOCK
 - boot:
-- 
2.20.1


