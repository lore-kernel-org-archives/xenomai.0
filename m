From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] linux-xenomai: Use --outpatch for preparing
 the kernel
Message-ID: <b1ae7e43-999b-3be6-7556-beb60d648ee4@siemens.com>
Date: Wed, 27 Nov 2019 08:24:23 +0100
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

This ensures that we no longer depend on xenomai-kernel-source for the
generated linux-headers package. This will become important when using
it in environments that do not have the former installed because the
headers packages does not express this dependency.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-xenomai.inc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/recipes-kernel/linux/linux-xenomai.inc b/recipes-kernel/linux/linux-xenomai.inc
index 1d153cd..3388776 100644
--- a/recipes-kernel/linux/linux-xenomai.inc
+++ b/recipes-kernel/linux/linux-xenomai.inc
@@ -37,7 +37,9 @@ dpkg_runbuild_prepend() {
 	bbplain $(printf "linux-xenomai-%s: Building revision %.20s\n" \
 			 ${PV} ${LINUX_COMMIT})
 
-	sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
-		/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
-			--linux=${PP}/${PPS} --arch=$ARCH
+	${BUILDCHROOT_DIR}/usr/src/xenomai-kernel-source/scripts/prepare-kernel.sh \
+		--linux=${BUILDCHROOT_DIR}/${PP}/${PPS} --arch=$ARCH \
+		--outpatch=${WORKDIR}/xenomai-kernel.patch
+	patch -d ${BUILDCHROOT_DIR}/${PP}/${PPS} \
+		-p1 -i ${WORKDIR}/xenomai-kernel.patch
 }
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

