Message-ID: <eca31c54-15df-1e7b-e77a-025a9d07c730@siemens.com>
Date: Wed, 12 Jan 2022 19:13:31 +0100
MIME-Version: 1.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] xenomai, linux-xenomai: Remove "Architecture:
 all" hack for xenomai-kernel-source
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

The current workaround breaks compat-arch scenarios (32-bit xenomai
packages, 64-bit kernel).

Instead, we can achieve the needed tuning for cross-usage of
xenomai-kernel-source by appending :native to this dependency of
linux-xenomai. This is needed for arm or arm64, because dpkg request the
target arch package of xenomai-kernel-source otherwise - for unknown
reasons. All this is still a bit weird, but that's how dpkg sometimes is.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
  recipes-kernel/linux/linux-xenomai.inc | 2 +-
  recipes-xenomai/xenomai/xenomai.inc    | 6 ------
  2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index ccc5353..7dba96e 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -21,7 +21,7 @@ SRC_URI += "${@'file://${KERNEL_DEFCONFIG}' if d.getVar('KERNEL_DEFCONFIG') == d
  SRC_URI += "${@'file://common_nodbg.cfg' if d.getVar('XENOMAI_DEBUG') == '0' else ''}"
  
  DEPENDS += "xenomai-kernel-source"
-KBUILD_DEPENDS += "xenomai-kernel-source"
+KBUILD_DEPENDS += "xenomai-kernel-source:native"
  
  def get_commit(d):
      try:
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index 8f13767..fe84883 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -23,12 +23,6 @@ def get_commit(d):
  COMMIT="${@get_commit(d)}"
  
  do_prepare_build() {
-    # The xenomai-kernel-source package is supposed to be generic, but we
-    # build it per architecture in Isar, and those packages happen to be
-    # different in some file so far. Make sure they are pushed into the
-    # target architecture to avoid conflicts.
-    sudo sed -i 's/Architecture: all/Architecture: any/' ${S}/debian/control
-
      # Xenomai currently does not maintain its changelog, plus we want the
      # actual package version in there.
      deb_add_changelog
-- 
2.31.1

