From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images PATCH v2] xenomai: Update changelog via Isar
Message-ID: <594dcca2-c8fb-07fd-e64a-1b61a44f7d75@siemens.com>
Date: Mon, 17 Feb 2020 21:02:17 +0100
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

For recipes that do not carry a release version, set a Debian-compliant
one. For those cases, we also need to remove upstream's source/format.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fix builds of non-release versions

 recipes-xenomai/xenomai/xenomai.inc             | 18 +++++++++++++-----
 recipes-xenomai/xenomai/xenomai_master.bb       |  2 ++
 recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb |  2 ++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index a2fc10b..8f13767 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -23,11 +23,19 @@ def get_commit(d):
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
+
+    # Remove upstream's "3.0 (native)" declaration so that we can define the
+    # package version more freely.
+    rm -f ${S}/debian/source/format
 }
 
 dpkg_runbuild_prepend() {
diff --git a/recipes-xenomai/xenomai/xenomai_master.bb b/recipes-xenomai/xenomai/xenomai_master.bb
index 298492f..a2e8802 100644
--- a/recipes-xenomai/xenomai/xenomai_master.bb
+++ b/recipes-xenomai/xenomai/xenomai_master.bb
@@ -12,6 +12,8 @@
 
 require xenomai.inc
 
+CHANGELOG_V = "9999-${PV}"
+
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=${PV}"
 SRCREV = "${AUTOREV}"
diff --git a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
index 6e8cd97..758d5ea 100644
--- a/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
+++ b/recipes-xenomai/xenomai/xenomai_stable-3.0.x.bb
@@ -12,6 +12,8 @@
 
 require xenomai.inc
 
+CHANGELOG_V = "3.0.x-head"
+
 SRC_URI = " \
     git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.0.x"
 SRCREV = "${AUTOREV}"
-- 
2.16.4

