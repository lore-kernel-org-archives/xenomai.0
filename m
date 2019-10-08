From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/3] ci: Speedup arm64 build
Date: Tue,  8 Oct 2019 15:14:40 +0200
Message-Id: <20191008131442.21295-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191008131442.21295-1-Quirin.Gylstorff@siemens.com>
References: <20191008131442.21295-1-Quirin.Gylstorff@siemens.com>
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

The arm64 qemu emulation slows during bootup increase the test execution time and
tune qemu settings.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 tests/jobs/xenomai-qemu-arm64.yml | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 44c8731..bcc3d81 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -27,18 +27,15 @@ context:
   # the template uses that to ensure that qemu-system-x86_64 is executed.
   arch: arm64
   extra_options:
-  - -global
-  - virtio-blk-device.scsi=off
-  - -smp
-  - 4
-  - -device
-  - virtio-serial-device
-  - -device
-  - virtconsole,chardev=con
-  - -chardev
-  - vc,id=con
-  - -device
-  - virtio-blk-device,drive=disk
+  - -cpu cortex-a57
+  - -global virtio-blk-device.scsi=off
+  - -smp 2
+  - -device virtio-serial-device
+  - -device virtconsole,chardev=con
+  - -chardev vc,id=con
+  - -device virtio-blk-device,drive=disk
+  - -device virtio-net-pci,netdev=net
+  - -netdev user,id=net
   guestfs_interface: virtio
 metadata:
   # please change these fields when modifying this job for your own tests.
@@ -65,7 +62,7 @@ actions:
 # BOOT_BLOCK
 - boot:
     timeout:
-      minutes: 2
+      minutes: 15
     method: qemu
     media: tmpfs
     prompts: ["root@demo:"]
@@ -77,7 +74,7 @@ actions:
 
 - test:
     timeout:
-      minutes: 30
+      minutes: 45
     definitions:
     - repository: http://git.linaro.org/lava-team/lava-functional-tests.git
       from: git
-- 
2.20.1


