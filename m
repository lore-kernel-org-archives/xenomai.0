From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 2/4] ci: Use compression for rootfs
Date: Tue,  1 Oct 2019 14:52:01 +0200
Message-Id: <20191001125203.10757-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191001125203.10757-1-Quirin.Gylstorff@siemens.com>
References: <20191001125203.10757-1-Quirin.Gylstorff@siemens.com>
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

The ext4 images are patted with zeros and are transmitted as full size images.
To increase the uploaded speed compress the rootfs.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 scripts/deploy_for_testing.sh     | 3 +++
 tests/jobs/xenomai-qemu-amd64.yml | 3 ++-
 tests/jobs/xenomai-qemu-arm64.yml | 3 ++-
 tests/jobs/xenomai-qemu-armhf.yml | 3 ++-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/deploy_for_testing.sh b/scripts/deploy_for_testing.sh
index 3bfe6bb..f8f71e3 100755
--- a/scripts/deploy_for_testing.sh
+++ b/scripts/deploy_for_testing.sh
@@ -35,6 +35,9 @@ scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET
 scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}-initrd.img \
     ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
 # ROOTFS
+if [ -n ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.*.gz  ]; then
+    gzip ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.*
+fi
 scp -P ${LAVA_SSH_PORT} ${IMAGES_DIR}/${TARGET}/demo-image-xenomai-demo-${TARGET}.* \
     ${LAVA_SSH_DESTINATION}:${DEPLOY_DIR}
 # DTB
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 8f1e071..26f42fa 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -53,7 +53,8 @@ actions:
         url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64.ext4.img
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-amd64.ext4.img.gz
+        compression: gz
 # BOOT_BLOCK
 - boot:
     timeout:
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 5099d95..a14c0b2 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -60,7 +60,8 @@ actions:
         url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64.ext4.img
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-arm64.ext4.img.gz
+        compression: gz
 # BOOT_BLOCK
 - boot:
     timeout:
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 5f36ca6..f080d1a 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -53,7 +53,8 @@ actions:
         url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf-initrd.img
       rootfs:
         image_arg: -drive file={rootfs},discard=unmap,if=none,id=disk,format=raw
-        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf.ext4.img
+        url: ${DEPLOY_URL}/demo-image-xenomai-demo-qemu-armhf.ext4.img.gz
+        compression: gz
 # BOOT_BLOCK
 - boot:
     timeout:
-- 
2.20.1


