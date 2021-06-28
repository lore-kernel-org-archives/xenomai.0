From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [xenomai-images 2/2] tests: restrict realtime cpu for x86 and qemu
 type of devices
Date: Mon, 28 Jun 2021 02:26:24 -0400
Message-Id: <20210628062624.2244-2-hongzhan.chen@intel.com>
In-Reply-To: <20210628062624.2244-1-hongzhan.chen@intel.com>
References: <20210628062624.2244-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, jan.kiszka@siemens.com

If there is no CPU restriction on the bootargs, smokey cpu_affinity
test would be skipped reporting with "no kernel support" for those
without non-RT cpu.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/tests/jobs/xenomai-ipc227e.yml b/tests/jobs/xenomai-ipc227e.yml
index a5a181c..209c5d4 100644
--- a/tests/jobs/xenomai-ipc227e.yml
+++ b/tests/jobs/xenomai-ipc227e.yml
@@ -72,3 +72,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=7
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index c335292..e42f6ec 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -46,7 +46,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0"
+        image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0 xenomai.supported_cpus=1"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 88fb880..cc60564 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -50,7 +50,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/vda"
+        image_arg: -kernel {kernel} -append "root=/dev/vda xenomai.supported_cpus=1"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 3e3a8ab..2afe250 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -46,7 +46,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/vdb"
+        image_arg: -kernel {kernel} -append "root=/dev/vdb xenomai.supported_cpus=1"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index bc71b75..d1418c1 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -72,3 +72,5 @@ actions:
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
+context:
+  extra_kernel_args: xenomai.supported_cpus=7
-- 
2.17.1


