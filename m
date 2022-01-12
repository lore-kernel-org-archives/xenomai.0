Message-ID: <8d00db33-83aa-96dc-1267-b31350287f58@siemens.com>
Date: Wed, 12 Jan 2022 19:12:55 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] kconfig: Fix qemu-armhf selection
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
  Kconfig | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index bdc67b7..7940180 100644
--- a/Kconfig
+++ b/Kconfig
@@ -51,7 +51,7 @@ config KAS_INCLUDE_TARGET
  	string
  	default "board-qemu-amd64.yml" if TARGET_QEMU_AMD64
  	default "board-x86-64-efi.yml" if TARGET_X86_64_EFI
-	default "board-qemu-arm.yml" if TARGET_QEMU_ARM
+	default "board-qemu-armhf.yml" if TARGET_QEMU_ARM
  	default "board-beagle-bone-black.yml" if TARGET_BBB
  	default "board-qemu-arm64.yml" if TARGET_QEMU_ARM64
  	default "board-hikey.yml" if TARGET_HIKEY
-- 
2.31.1

