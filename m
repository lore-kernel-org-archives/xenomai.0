From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/4] ci: Use unique test ids
Date: Tue,  1 Oct 2019 11:24:40 +0200
Message-Id: <20191001092443.19602-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191001092443.19602-1-Quirin.Gylstorff@siemens.com>
References: <20191001092443.19602-1-Quirin.Gylstorff@siemens.com>
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

All test images are stored in one folder. If multiple agents
are used to build against the same machine it is no longer possible
to differentiate what was tested. Use the unique CI_PIPELINE_ID to
differ these builds in one gitlab instance.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/deploy_for_testing.sh     |  4 +++-
 scripts/run-lava-tests.sh         | 13 ++++++++++++-
 tests/jobs/xenomai-beaglebone.yml |  6 +++---
 tests/jobs/xenomai-minnow.yml     |  6 +++---
 tests/jobs/xenomai-qemu-amd64.yml |  9 +++++----
 tests/jobs/xenomai-qemu-arm64.yml |  9 +++++----
 tests/jobs/xenomai-qemu-armhf.yml |  9 +++++----
 tests/jobs/xenomai-x86-64.yml     |  6 +++---
 8 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/scripts/deploy_for_testing.sh b/scripts/deploy_for_testing.sh
index 4015b87..3bfe6bb 100755
--- a/scripts/deploy_for_testing.sh
+++ b/scripts/deploy_for_testing.sh
@@ -25,7 +25,9 @@ fi
 
 LAVA_SSH_DESTINATION="${LAVA_SSH_USER}@${LAVA_SSH_HOST}"
 
-DEPLOY_DIR="/var/lib/lava/artifacts"
+LAVA_DEPLOY_DIR=${LAVA_DEPLOY_DIR:-"/var/lib/lava/artifacts"}
+DEPLOY_DIR="${LAVA_DEPLOY_DIR}/${CI_PIPELINE_ID}"
+ssh -p ${LAVA_SSH_PORT} ${LAVA_SSH_DESTINATION} 'install -d -m 755 "'${DEPLOY_DIR}'"'
 #KERNEL
 scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-vmlinuz \
     ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 9195275..e52ae9c 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -33,9 +33,20 @@ do
 done
 LAVA_MASTER_URI=http://localhost:${LAVA_MASTER_PORT}
 
+if [ -z "${TARGET}" ]; then
+    echo "no target was given"
+    exit -1
+fi
+artifact_url="${${LAVA_ARTIFACTS_URL}:-'http://localhost/artifacts'}"
+
 # connect to lava master
 lavacli identities add --token ${LAVA_MASTER_TOKEN} --uri ${LAVA_MASTER_URI} --username ${LAVA_MASTER_ACCOUNT} default
-test_id=$(lavacli jobs submit tests/jobs/xenomai-${TARGET}.yml)
+
+#generate lava job description from template
+DEPLOY_URL="${artifact_url}/${CI_PIPELINE_ID}"
+template=$(cat tests/jobs/xenomai-${TARGET}.yml)
+test_id=$(eval "cat <<EOF ${template}
+EOF" | lavacli jobs submit -)
 lavacli jobs logs ${test_id}
 lavacli results ${test_id}
 # change return code to generate a error in gitlab-ci if a test is failed
diff --git a/tests/jobs/xenomai-beaglebone.yml b/tests/jobs/xenomai-beaglebone.yml
index 85f2b88..138c8cb 100644
--- a/tests/jobs/xenomai-beaglebone.yml
+++ b/tests/jobs/xenomai-beaglebone.yml
@@ -35,12 +35,12 @@ actions:
       minutes: 5
     to: tftp
     kernel:
-      url: http://localhost/artifacts/demo-image-xenomai-demo-beagle-bone-black-vmlinuz
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-beagle-bone-black-vmlinuz
       type: zimage
     dtb:
-      url: http://localhost/artifacts/am335x-boneblack.dtb
+      url: ${DEPLOY_URL}/am335x-boneblack.dtb
     nfsrootfs:
-      url: http://localhost/artifacts/demo-image-xenomai-demo-beagle-bone-black.tar.gz
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-beagle-bone-black.tar.gz
       compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-minnow.yml b/tests/jobs/xenomai-minnow.yml
index d3b4a4d..27a0f81 100644
--- a/tests/jobs/xenomai-minnow.yml
+++ b/tests/jobs/xenomai-minnow.yml
@@ -31,13 +31,13 @@ actions:
       minutes: 5
     to: tftp
     kernel:
-      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi-vmlinuz
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-vmlinuz
       type: bzimage
     ramdisk:
-      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi-initrd.img
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-initrd.img
       compression: gz
     nfsrootfs:
-      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi.tar.gz
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi.tar.gz
       compression: gz
 # BOOT_BLOCK
 - boot:
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 2976f89..8f1e071 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -47,14 +47,13 @@ actions:
     images:
       kernel:
         image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0"
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-amd64-vmlinuz
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-amd64-initrd.img
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-amd64.ext4.img
-
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64.ext4.img
 # BOOT_BLOCK
 - boot:
     timeout:
@@ -69,6 +68,8 @@ actions:
       password: root
 
 - test:
+    timeout:
+      minutes: 30
     definitions:
     - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
       from: git
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index a5a9371..5099d95 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -54,14 +54,13 @@ actions:
     images:
       kernel:
         image_arg: -kernel {kernel} -append "root=/dev/vda"
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-arm64-vmlinuz
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-arm64-initrd.img
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-arm64.ext4.img
-
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64.ext4.img
 # BOOT_BLOCK
 - boot:
     timeout:
@@ -76,6 +75,8 @@ actions:
       password: root
 
 - test:
+    timeout:
+      minutes: 30
     definitions:
     - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
       from: git
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 238265b..5f36ca6 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -47,14 +47,13 @@ actions:
     images:
       kernel:
         image_arg: -kernel {kernel} -append "root=/dev/vdb"
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-armhf-vmlinuz
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-armhf-initrd.img
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: http://localhost/artifacts/demo-image-xenomai-demo-qemu-armhf.ext4.img
-
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf.ext4.img
 # BOOT_BLOCK
 - boot:
     timeout:
@@ -69,6 +68,8 @@ actions:
       password: root
 
 - test:
+    timeout:
+      minutes: 30
     definitions:
     - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
       from: git
diff --git a/tests/jobs/xenomai-x86-64.yml b/tests/jobs/xenomai-x86-64.yml
index 9d58c45..c7424c0 100644
--- a/tests/jobs/xenomai-x86-64.yml
+++ b/tests/jobs/xenomai-x86-64.yml
@@ -32,13 +32,13 @@ actions:
       minutes: 5
     to: tftp
     kernel:
-      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi-vmlinuz
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-vmlinuz
       type: bzimage
     ramdisk:
-      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi-initrd.img
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi-initrd.img
       compression: gz
     nfsrootfs:
-      url: http://localhost/artifacts/demo-image-xenomai-demo-x86-64-efi.tar.gz
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-x86-64-efi.tar.gz
       compression: gz
 # BOOT_BLOCK
 - boot:
-- 
2.20.1


