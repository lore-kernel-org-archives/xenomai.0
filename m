From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images PATCH 1/2] tests: hikey xenomai-tests
Date: Tue,  5 Nov 2019 17:22:38 +0100
Message-Id: <20191105162239.18949-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191105162239.18949-1-Quirin.Gylstorff@siemens.com>
References: <20191105162239.18949-1-Quirin.Gylstorff@siemens.com>
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

For arm64 tests a hikey620 board is used. The board uses u-boot
as bootloader to detect a USB2.0 Ethernet adapter to load the
kernel, devicetree and rootfs.

The U-boot bootloader was build and deployed according [1].

[1]: https://gitlab.denx.de/u-boot/u-boot/tree/master/board/hisilicon/hikey

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/hikey.conf                    |  2 +
 recipes-kernel/linux/files/arm64_defconfig |  6 +-
 tests/jobs/xenomai-hikey.yml               | 72 ++++++++++++++++++++++
 3 files changed, 77 insertions(+), 3 deletions(-)
 create mode 100644 tests/jobs/xenomai-hikey.yml

diff --git a/conf/machine/hikey.conf b/conf/machine/hikey.conf
index 11cf635..c28c350 100644
--- a/conf/machine/hikey.conf
+++ b/conf/machine/hikey.conf
@@ -17,3 +17,5 @@ IMAGER_INSTALL += "${GRUB_BOOTLOADER_INSTALL}"
 IMAGE_PREINSTALL_append = " firmware-ti-connectivity"
 
 PREFERRED_VERSION_xenomai = "next"
+# DTB for testing
+DTB_FILE = "hi6220-hikey.dtb"
diff --git a/recipes-kernel/linux/files/arm64_defconfig b/recipes-kernel/linux/files/arm64_defconfig
index f1d7c31..d4e717e 100644
--- a/recipes-kernel/linux/files/arm64_defconfig
+++ b/recipes-kernel/linux/files/arm64_defconfig
@@ -2071,9 +2071,9 @@ CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
 CONFIG_USB_RTL8152=m
 # CONFIG_USB_LAN78XX is not set
-CONFIG_USB_USBNET=m
-CONFIG_USB_NET_AX8817X=m
-CONFIG_USB_NET_AX88179_178A=m
+CONFIG_USB_USBNET=y
+CONFIG_USB_NET_AX8817X=y
+CONFIG_USB_NET_AX88179_178A=y
 CONFIG_USB_NET_CDCETHER=m
 # CONFIG_USB_NET_CDC_EEM is not set
 CONFIG_USB_NET_CDC_NCM=m
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
new file mode 100644
index 0000000..3e52212
--- /dev/null
+++ b/tests/jobs/xenomai-hikey.yml
@@ -0,0 +1,72 @@
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
+device_type: hikey
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
+  docs-source: xenomai-hikey
+  docs-filename: pipeline-xenomai-hikey
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 30
+    to: tftp
+    kernel:
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-hikey-vmlinuz
+      type: image
+    dtb:
+      url: ${DEPLOY_URL}/hi6220-hikey.dtb
+    nfsrootfs:
+      url: ${DEPLOY_URL}/demo-image-xenomai-demo-hikey.tar.gz
+      compression: gz
+#  BOOT_BLOCK
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
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
-- 
2.20.1


