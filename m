From: Uladzimir Bely <ubely@ilbers.de>
Subject: [xenomai-images] [PATCH v2 1/2] xenomai: remove bootstrap task from
 dpkg_runbuild_prepend
Date: Tue, 18 Jan 2022 11:51:27 +0100
Message-Id: <20220118105128.3007-2-ubely@ilbers.de>
In-Reply-To: <20220118105128.3007-1-ubely@ilbers.de>
References: <20220118105128.3007-1-ubely@ilbers.de>
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
To: xenomai@xenomai.org, ubely@ilbers.de

This looks unneeded while bootstrapping is done in the same way
in debian/rules file before the build.

Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
---
 recipes-xenomai/xenomai/xenomai.inc | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index fe84883..b8ec5bd 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -13,15 +13,6 @@ inherit dpkg
 
 PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1 libxenomai-dev libxenomai1-dbgsym"
 
-# use bitbake get_srcrev to get the current commit id
-def get_commit(d):
-    try:
-        return bb.fetch2.get_srcrev(d).strip('AUTOINC+')
-    except bb.fetch2.FetchError:
-        return ""
-
-COMMIT="${@get_commit(d)}"
-
 do_prepare_build() {
     # Xenomai currently does not maintain its changelog, plus we want the
     # actual package version in there.
@@ -31,11 +22,3 @@ do_prepare_build() {
     # package version more freely.
     rm -f ${S}/debian/source/format
 }
-
-dpkg_runbuild_prepend() {
-    bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
-                     ${PV} ${COMMIT})
-
-    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
-        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
-}
-- 
2.20.1


