From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] tests: qemu-amd64: Select rootfs via
 disk/by-path
Message-ID: <bc370785-b4d4-b60c-a149-c2db2a896f50@siemens.com>
Date: Mon, 19 Jul 2021 12:47:23 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

This should resolve sporadic test failures because Linux reordered sda
and sdb.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/jobs/xenomai-qemu-amd64.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 29f5216..921c70b 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -46,7 +46,7 @@ actions:
     to: tmpfs
     images:
       kernel:
-        image_arg: -kernel {kernel} -append "root=/dev/sdb console=ttyS0,115200 console=tty0"
+        image_arg: -kernel {kernel} -append "root=/dev/disk/by-path/pci-0000:00:1f.2-ata-6 console=ttyS0,115200 console=tty0"
         url: ${DEPLOY_URL}/${ISAR_IMAGE}-${ISAR_DISTRIBUTION}-${TARGET}-vmlinuz
       initrd:
         image_arg: -initrd {initrd}
-- 
2.26.2

