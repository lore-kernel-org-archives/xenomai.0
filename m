From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: x86: Enable vfat support for
 UEFI boot
Date: Thu,  8 Apr 2021 17:12:55 +0200
Message-Id: <20210408151255.946852-1-florian.bezdeka@siemens.com>
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

Trying to boot up the example image on an x86 board with UEFI failed
because vfat support was missing. The x86 defconfig has been
re-synchronized with the arm64 defconfig to enable UEFI boot support.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 recipes-kernel/linux/files/amd64_defconfig | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/recipes-kernel/linux/files/amd64_defconfig b/recipes-kernel/linux/files/amd64_defconfig
index bc5cd0b..2b7e63f 100644
--- a/recipes-kernel/linux/files/amd64_defconfig
+++ b/recipes-kernel/linux/files/amd64_defconfig
@@ -3609,7 +3609,10 @@ CONFIG_FSCACHE_HISTOGRAM=y
 # DOS/FAT/NT Filesystems
 #
 # CONFIG_MSDOS_FS is not set
-# CONFIG_VFAT_FS is not set
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_FAT_DEFAULT_UTF8 is not set
 # CONFIG_NTFS_FS is not set
 
 #
@@ -3681,8 +3684,8 @@ CONFIG_9P_FSCACHE=y
 CONFIG_9P_FS_POSIX_ACL=y
 # CONFIG_9P_FS_SECURITY is not set
 CONFIG_NLS=y
-CONFIG_NLS_DEFAULT="cp437"
-# CONFIG_NLS_CODEPAGE_437 is not set
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
 # CONFIG_NLS_CODEPAGE_737 is not set
 # CONFIG_NLS_CODEPAGE_775 is not set
 # CONFIG_NLS_CODEPAGE_850 is not set
@@ -3706,7 +3709,7 @@ CONFIG_NLS_DEFAULT="cp437"
 # CONFIG_NLS_CODEPAGE_1250 is not set
 # CONFIG_NLS_CODEPAGE_1251 is not set
 # CONFIG_NLS_ASCII is not set
-# CONFIG_NLS_ISO8859_1 is not set
+CONFIG_NLS_ISO8859_1=y
 # CONFIG_NLS_ISO8859_2 is not set
 # CONFIG_NLS_ISO8859_3 is not set
 # CONFIG_NLS_ISO8859_4 is not set
-- 
2.30.2


