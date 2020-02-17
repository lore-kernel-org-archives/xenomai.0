From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images PATCH] xenomai: Update changelog via Isar
Message-ID: <be42e949-4dca-3e8a-3084-d53d37091d26@siemens.com>
Date: Mon, 17 Feb 2020 20:24:57 +0100
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

This fixes the version of the generated packages.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-xenomai/xenomai/xenomai.inc | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index a2fc10b..8b43855 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -23,11 +23,15 @@ def get_commit(d):
 COMMIT="${@get_commit(d)}"
 
 do_prepare_build() {
-	# The xenomai-kernel-source package is supposed to be generic, but we
-	# build it per architecture in Isar, and those packages happen to be
-	# different in some file so far. Make sure they are pushed into the
-	# target architecture to avoid conflicts.
-	sudo sed -i 's/Architecture: all/Architecture: any/' ${S}/debian/control
+    # The xenomai-kernel-source package is supposed to be generic, but we
+    # build it per architecture in Isar, and those packages happen to be
+    # different in some file so far. Make sure they are pushed into the
+    # target architecture to avoid conflicts.
+    sudo sed -i 's/Architecture: all/Architecture: any/' ${S}/debian/control
+
+    # Xenomai currently does not maintain its changelog, plus we want the
+    # actual package version in there.
+    deb_add_changelog
 }
 
 dpkg_runbuild_prepend() {
-- 
2.16.4

