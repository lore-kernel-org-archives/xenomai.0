From: Uladzimir Bely <ubely@ilbers.de>
Subject: [xenomai-images] [PATCH v2 2/2] linux-xenomai: handle xenomai-kernel
 patch in Debian way
Date: Tue, 18 Jan 2022 11:51:28 +0100
Message-Id: <20220118105128.3007-3-ubely@ilbers.de>
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

This change moves generating xenomai-kernel.patch and applying it
from the recipe into a build script in 'debian/' subdirectory.

This makes linux-xenomai recipe buildchroot-independent and
allows to use it with any build system (e.g. sbuild).

Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
---
 recipes-kernel/linux/linux-xenomai.inc | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 7dba96e..bd7db7d 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -49,9 +49,12 @@ dpkg_runbuild_prepend() {
 	bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
 			 ${PV} ${LINUX_COMMIT})
 
-	${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
-		--linux=${BUILDCHROOT_DIR}/${PP}/${PPS} --arch=$ARCH \
-		--outpatch=${WORKDIR}/xenomai-kernel.patch
-	patch -d ${BUILDCHROOT_DIR}/${PP}/${PPS} \
-		-p1 -i ${WORKDIR}/xenomai-kernel.patch
+	if ! grep -q "prepare-kernel.sh" ${S}/debian/isar/build; then
+		cat << EOF | sed -i '/^do_build/ r /dev/stdin' ${S}/debian/isar/build
+    /usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \\
+        --linux=. --arch=$ARCH \\
+        --outpatch=../xenomai-kernel.patch
+    patch -d . -p1 -i ../xenomai-kernel.patch
+EOF
+	fi
 }
-- 
2.20.1


