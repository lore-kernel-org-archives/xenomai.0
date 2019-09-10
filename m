From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 1/9] ci: Add LAVA jobs for targets
Date: Tue, 10 Sep 2019 16:44:51 +0200
Message-Id: <20190910144459.13239-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
References: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
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

Set up a LAVA Lab and add jobs for each target. These job descriptions
deploy the build image to the target and run the LAVA basic smoketest
suite for each target. Add lsb-release for smoke-test

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml                    | 94 ++++++++++++++++++++++++++++---
 recipes-core/images/demo-image.bb |  2 +-
 scripts/deploy_for_testing.sh     | 40 +++++++++++++
 scripts/run-lava-tests.sh         | 30 ++++++++++
 tests/README.md                   | 24 ++++++++
 tests/jobs/xenomai-beaglebone.yml | 65 +++++++++++++++++++++
 tests/jobs/xenomai-minnow.yml     | 62 ++++++++++++++++++++
 tests/jobs/xenomai-qemu-amd64.yml | 76 +++++++++++++++++++++++++
 tests/jobs/xenomai-qemu-arm64.yml | 83 +++++++++++++++++++++++++++
 tests/jobs/xenomai-qemu-armhf.yml | 76 +++++++++++++++++++++++++
 tests/jobs/xenomai-x86-64.yml     | 63 +++++++++++++++++++++
 11 files changed, 607 insertions(+), 8 deletions(-)
 create mode 100755 scripts/deploy_for_testing.sh
 create mode 100755 scripts/run-lava-tests.sh
 create mode 100644 tests/README.md
 create mode 100644 tests/jobs/xenomai-beaglebone.yml
 create mode 100644 tests/jobs/xenomai-minnow.yml
 create mode 100644 tests/jobs/xenomai-qemu-amd64.yml
 create mode 100644 tests/jobs/xenomai-qemu-arm64.yml
 create mode 100644 tests/jobs/xenomai-qemu-armhf.yml
 create mode 100644 tests/jobs/xenomai-x86-64.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index deecfb1..c4dc27f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,37 +1,117 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+stages:
+  - build
+  - lava-test
 variables:
   GIT_STRATEGY: clone
-variables:
   http_proxy: "$HTTP_PROXY"
   https_proxy: "$HTTPS_PROXY"
   ftp_proxy: "$FTP_PROXY"
   no_proxy: "$NO_PROXY"
+default:
+  image: kasproject/kas-isar:latest
+
+# add lavacli to the container and install the ssh keys
+# for the test infrastructure
+.add-lava-ssh-config: &lava-ssh-key
+  before_script:
+    - sudo apt update
+    - sudo apt install lavacli -y
+    - mkdir -p -m=700 ~/.ssh
+    - echo "$LAVA_UPLOAD_KEY" | tr -d '\r' > ~/.ssh/id_rsa && chmod 600 ~/.ssh/id_rsa
+    - echo "ProxyCommand socat - PROXY:$(echo $https_proxy | sed 's|.*://\([^:]*\).*|\1|'):%h:%p,proxyport=$(echo $https_proxy | sed 's|.*:\([0-9]*\)$|\1|')" >> ~/.ssh/config && chmod 600 ~/.ssh/config
+    - echo "$LAVA_KNOWN_HOST" >> ~/.ssh/known_hosts && chmod 644 ~/.ssh/known_hosts
+
 build:qemu-amd64:
+  <<: *lava-ssh-key
   stage: build
-  image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-qemu-amd64.yml
+    - scripts/deploy_for_testing.sh qemu-amd64
+
+lava-test:qemu-amd64:
+  <<: *lava-ssh-key
+  stage: lava-test
+  script:
+     - scripts/run-lava-tests.sh qemu-amd64
+  only:
+    variables:
+      - $LAVA_USER
+
 build:qemu-armhf:
   stage: build
-  image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-qemu-armhf.yml
+    - scripts/deploy_for_testing.sh qemu-armhf
+
+lava-test:qemu-armhf:
+  <<: *lava-ssh-key
+  stage: lava-test
+  script:
+    - scripts/run-lava-tests.sh qemu-armhf
+  only:
+    variables:
+      - $LAVA_USER
+
 build:qemu-arm64:
+  <<: *lava-ssh-key
   stage: build
-  image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-qemu-arm64.yml
+    - scripts/deploy_for_testing.sh qemu-arm64
+
+lava-test:qemu-arm64:
+  <<: *lava-ssh-key
+  stage: lava-test
+  script:
+    - scripts/run-lava-tests.sh qemu-arm64
+  only:
+    variables:
+      - $LAVA_USER
+
 build:board-hikey:
   stage: build
-  image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-hikey.yml
+# hikey is currently not part of the testlab
+
 build:board-beaglebone:
+  <<: *lava-ssh-key
   stage: build
-  image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-beagle-bone-black.yml
+    - scripts/deploy_for_testing.sh beagle-bone-black
+
+lava-test:board-beaglebone:
+  <<: *lava-ssh-key
+  stage: lava-test
+  script:
+    - scripts/run-lava-tests.sh beaglebone
+  only:
+    variables:
+      - $LAVA_USER
+
 build:board-x86-64-efi:
+  <<: *lava-ssh-key
   stage: build
-  image: kasproject/kas-isar:latest
   script:
     - kas build kas.yml:board-x86-64-efi.yml
+    - scripts/deploy_for_testing.sh x86-64-efi
+
+lava-test:board-x86-64-efi:
+  <<: *lava-ssh-key
+  stage: lava-test
+  script:
+    - scripts/run-lava-tests.sh x86-64
+  only:
+    variables:
+      - $LAVA_USER
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 8afad67..02976fa 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -18,7 +18,7 @@ IMAGE_PREINSTALL += " \
     bash-completion less vim nano man \
     ifupdown isc-dhcp-client net-tools iputils-ping ssh \
     iw wireless-tools wpasupplicant \
-    gdb"
+    gdb lsb-release"
 
 IMAGE_INSTALL += "xenomai-runtime"
 IMAGE_INSTALL += "customizations expand-on-first-boot"
diff --git a/scripts/deploy_for_testing.sh b/scripts/deploy_for_testing.sh
new file mode 100755
index 0000000..1414d63
--- /dev/null
+++ b/scripts/deploy_for_testing.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+set -e
+TARGET="$1"
+
+if [ -z "${TARGET}" ]; then
+    exit -1
+fi
+IMAGES_DIR=build/tmp/deploy/images
+
+if [ -z "${LAVA_USER}" ] || [ -z "${LAVA_HOST}" ]  || [ -z "${LAVA_PORT}" ]; then
+    echo "Lava environment not available or incomplete - do not deploy"
+    exit 0
+fi
+
+LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"
+#KERNEL
+scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-vmlinuz \
+    ${LAVA_MASTER}:/var/lib/lava/artifacts
+# INITRD
+scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-initrd.img \
+    ${LAVA_MASTER}:/var/lib/lava/artifacts
+# ROOTFS
+scp -P ${LAVA_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.* \
+    ${LAVA_MASTER}:/var/lib/lava/artifacts
+# DTB
+DTB="${IMAGES_DIR}/${TARGET}/*.dtb"
+if [ -e ${DTB} ]; then
+    scp -P ${LAVA_PORT} ${DTB} ${LAVA_MASTER}:/var/lib/lava/artifacts
+fi
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
new file mode 100755
index 0000000..edd2a20
--- /dev/null
+++ b/scripts/run-lava-tests.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+set -e
+TARGET=$1
+
+LAVA_MASTER="${LAVA_USER}@${LAVA_HOST}"
+
+# open connection for ssh port forwarding
+ssh -N  -p ${LAVA_PORT} -o 'LocalForward localhost:28080 localhost:80' ${LAVA_MASTER} &
+
+# connect to lava master
+lavacli identities add --token ${LAVA_TOKEN} --uri http://localhost:28080 --username siemens default
+
+test_id=$(lavacli jobs submit tests/jobs/xenomai-${TARGET}.yml)
+lavacli jobs logs ${test_id}
+lavacli results ${test_id}
+# change return code to generate a error in gitlab-ci if a test is failed
+number_of_fails=$(lavacli results ${test_id} | grep fail | wc -l)
+if [ "${number_of_fails}" -gt "0" ]; then
+    exit 1
+fi
diff --git a/tests/README.md b/tests/README.md
new file mode 100644
index 0000000..c7e2030
--- /dev/null
+++ b/tests/README.md
@@ -0,0 +1,24 @@
+# Testing
+
+For image testing this project uses the
+[Linaro Automated Validation Architecture(LAVA)](https://www.lavasoftware.org/).
+The images are generate a gitlab-ci pipeline. This pipline builds the images and
+sends them to the lava testlab.
+
+## Test targets
+
+following images are test:
+- qemu-arm64
+- qemu-amd64
+- x86-64-efi
+- beagle-bone-black
+
+## Tests
+
+Currently the following tests are executed on each target:
+- lava-smoketest
+
+### lava-smoketest
+
+The lava smoke tests are part of http://git.linaro.org/lava-team/lava-functional-tests.git
+and check machine data from the target.
diff --git a/tests/jobs/xenomai-beaglebone.yml b/tests/jobs/xenomai-beaglebone.yml
new file mode 100644
index 0000000..231c5d0
--- /dev/null
+++ b/tests/jobs/xenomai-beaglebone.yml
@@ -0,0 +1,65 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+job_name: xenomai-test-suite
+device_type: beaglebone-black
+
+timeouts:
+  job:
+    minutes: 30
+  action:
+    minutes: 20
+  connection:
+    minutes: 2
+priority: medium
+visibility: public
+
+metadata:
+  # please change these fields when modifying this job for your own tests.
+  docs-source: xenomai-beagleboneblack
+  docs-filename: pipeline-xenomai-beagleboneblack
+context:
+  console_device: ttyO
+  baud_rate: 115200
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 5
+    to: tftp
+    kernel:
+      url: http://localhost/artifacts/demo-image-xenomai-demo-beagle-bone-black-vmlinuz
+      type: zimage
+    dtb:
+      url: http://localhost/artifacts/am335x-boneblack.dtb
+    nfsrootfs:
+      url: http://localhost/artifacts/demo-image-xenomai-demo-beagle-bone-black.tar.gz
+      compression: gz
+# BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 5
+    method: u-boot
+    commands: nfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    timeout:
+      minutes: 30
+    definitions:
+    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
+      from: git
+      path: lava-test-shell/smoke-tests-basic.yaml
+      name: smoke-tests
diff --git a/tests/jobs/xenomai-minnow.yml b/tests/jobs/xenomai-minnow.yml
new file mode 100644
index 0000000..d60628d
--- /dev/null
+++ b/tests/jobs/xenomai-minnow.yml
@@ -0,0 +1,62 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+job_name: xenomai-test-suite
+device_type: minnowboard-max-E3825
+timeouts:
+  job:
+    minutes: 30
+  action:
+    minutes: 20
+  connection:
+    minutes: 2
+priority: medium
+visibility: public
+
+metadata:
+  # please change these fields when modifying this job for your own tests.
+  docs-source: xenomai-cof
+  docs-filename: pipeline-xenomai-cof
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 5
+    to: tftp
+    kernel:
+      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi-vmlinuz
+      type: bzimage
+    ramdisk:
+      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi-initrd.img
+      compression: gz
+    nfsrootfs:
+      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi.tar.gz
+      compression: gz
+# BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 5
+    method: grub
+    commands: nfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    timeout:
+      minutes: 30
+    definitions:
+    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
+      from: git
+      path: lava-test-shell/smoke-tests-basic.yaml
+      name: smoke-tests
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
new file mode 100644
index 0000000..12f4c7f
--- /dev/null
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -0,0 +1,76 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+device_type: qemu
+job_name: QEMU pipeline, xenomai-images-qemu-amd64
+
+timeouts:
+  job:
+    minutes: 15
+  action:
+    minutes: 5
+  connection:
+    minutes: 2
+priority: medium
+visibility: public
+
+# context allows specific values to be overridden or included
+context:
+  # tell the qemu template which architecture is being tested
+  # the template uses that to ensure that qemu-system-x86_64 is executed.
+  arch: amd64
+  extra_options:
+  - -smp
+  -  4
+  - -nographic
+  - -enable-kvm
+  - -machine q35
+  - -device ide-hd,drive=disk
+metadata:
+  # please change these fields when modifying this job for your own tests.
+  docs-source: xenomai-qemu-amd64
+  docs-filename: qemu-pipeline-xenomai-amd64
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 5
+    to: tmpfs
+    images:
+      kernel:
+        image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0"
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-amd64-vmlinuz
+      initrd:
+        image_arg: -initrd {initrd}
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-amd64-initrd.img
+      rootfs:
+        image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-amd64.ext4.img
+
+# BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 2
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    definitions:
+    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
+      from: git
+      path: lava-test-shell/smoke-tests-basic.yaml
+      name: smoke-tests
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
new file mode 100644
index 0000000..fceee0c
--- /dev/null
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -0,0 +1,83 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+device_type: qemu
+job_name: QEMU pipeline, xenomai-images-qemu-arm64
+
+timeouts:
+  job:
+    minutes: 15
+  action:
+    minutes: 5
+  connection:
+    minutes: 2
+priority: medium
+visibility: public
+
+# context allows specific values to be overridden or included
+context:
+  # tell the qemu template which architecture is being tested
+  # the template uses that to ensure that qemu-system-x86_64 is executed.
+  arch: arm64
+  extra_options:
+  - -global
+  - virtio-blk-device.scsi=off
+  - -smp
+  - 4
+  - -device
+  - virtio-serial-device
+  - -device
+  - virtconsole,chardev=con
+  - -chardev
+  - vc,id=con
+  - -device
+  - virtio-blk-device,drive=disk
+  guestfs_interface: virtio
+metadata:
+  # please change these fields when modifying this job for your own tests.
+  docs-source: xenomai-qemu-arm64
+  docs-filename: qemu-pipeline-xenomai-arm64
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 5
+    to: tmpfs
+    images:
+      kernel:
+        image_arg: -kernel {kernel} -append "root=/dev/vda"
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-arm64-vmlinuz
+      initrd:
+        image_arg: -initrd {initrd}
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-arm64-initrd.img
+      rootfs:
+        image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-arm64.ext4.img
+
+# BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 2
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    definitions:
+    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
+      from: git
+      path: lava-test-shell/smoke-tests-basic.yaml
+      name: smoke-tests
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
new file mode 100644
index 0000000..d6603af
--- /dev/null
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -0,0 +1,76 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+device_type: qemu
+job_name: QEMU pipeline, xenomai-images-qemu-armhf
+
+timeouts:
+  job:
+    minutes: 15
+  action:
+    minutes: 5
+  connection:
+    minutes: 2
+priority: medium
+visibility: public
+
+# context allows specific values to be overridden or included
+context:
+  arch: arm
+  cpu: cortex-a15
+  extra_options:
+  - -smp 4
+  - -device virtio-serial-device
+  - -device virtconsole,chardev=con
+  - -chardev vc,id=con
+  - -device virtio-blk-device,bootindex=0,drive=disk
+  - -device virtio-blk-device,bootindex=1,drive=lavatest
+  guestfs_interface: none
+metadata:
+  # please change these fields when modifying this job for your own tests.
+  docs-source: xenomai-qemu-armhf
+  docs-filename: qemu-pipeline-xenomai-armhf
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 5
+    to: tmpfs
+    images:
+      kernel:
+        image_arg: -kernel {kernel} -append "root=/dev/vdb"
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-armhf-vmlinuz
+      initrd:
+        image_arg: -initrd {initrd}
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-armhf-initrd.img
+      rootfs:
+        image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
+        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-armhf.ext4.img
+
+# BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 5
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    definitions:
+    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
+      from: git
+      path: lava-test-shell/smoke-tests-basic.yaml
+      name: smoke-tests
diff --git a/tests/jobs/xenomai-x86-64.yml b/tests/jobs/xenomai-x86-64.yml
new file mode 100644
index 0000000..0fb3ea8
--- /dev/null
+++ b/tests/jobs/xenomai-x86-64.yml
@@ -0,0 +1,63 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+job_name: xenomai-test-suite
+device_type: x86
+
+timeouts:
+  job:
+    minutes: 30
+  action:
+    minutes: 20
+  connection:
+    minutes: 2
+priority: medium
+visibility: public
+
+metadata:
+  # please change these fields when modifying this job for your own tests.
+  docs-source: xenomai-cof
+  docs-filename: pipeline-xenomai-cof
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 5
+    to: tftp
+    kernel:
+      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi-vmlinuz
+      type: bzimage
+    ramdisk:
+      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi-initrd.img
+      compression: gz
+    nfsrootfs:
+      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi.tar.gz
+      compression: gz
+# BOOT_BLOCK
+- boot:
+    timeout:
+      minutes: 5
+    method: ipxe
+    commands: nfs
+    prompts: ["root@demo:"]
+    auto_login:
+      login_prompt: 'demo login:'
+      username: root
+      password_prompt: 'Password:'
+      password: root
+
+- test:
+    timeout:
+      minutes: 30
+    definitions:
+    - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
+      from: git
+      path: lava-test-shell/smoke-tests-basic.yaml
+      name: smoke-tests
-- 
2.20.1


