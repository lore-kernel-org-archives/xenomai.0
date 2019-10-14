From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 1/1] kernel/linux: Add git commit sha to build
Date: Mon, 14 Oct 2019 15:28:40 +0200
Message-Id: <20191014132840.27249-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <a4c48259-2ffc-0bf9-d545-cacde8672bac@siemens.com>
References: <a4c48259-2ffc-0bf9-d545-cacde8672bac@siemens.com>
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

For debugging purposes print the commit sha used by the build.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index d93e614..bdf51f7 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -18,6 +18,7 @@ SRC_URI += "file://${KERNEL_DEFCONFIG}"
 DEPENDS += "xenomai-kernel-source"
 KBUILD_DEPENDS += "xenomai-kernel-source"
 
+LINUX_COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
 dpkg_runbuild_prepend() {
 	case ${DISTRO_ARCH} in
 	armhf)
@@ -33,6 +34,9 @@ dpkg_runbuild_prepend() {
 		bberror "Unsupported architecture ${DISTRO_ARCH}"
 		exit 1
 	esac
+    bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
+                     ${PV} ${LINUX_COMMIT})
+
 
 	sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
 		/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
-- 
2.20.1


