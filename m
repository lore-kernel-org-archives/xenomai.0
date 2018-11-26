From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 1/3] customizations: Remove obsolete cleanup
 and chown
Date: Mon, 26 Nov 2018 16:08:23 +0100
Message-Id: <edd6ad88d06f8deb1160ee225f4909a5d29d1c29.1543244905.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543244905.git.jan.kiszka@siemens.com>
References: <cover.1543244905.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1543244905.git.jan.kiszka@siemens.com>
References: <cover.1543244905.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

From: Jan Kiszka <jan.kiszka@siemens.com>

Isar does that for us now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/customizations/customizations.bb | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index fd41a09..e35c0a5 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -21,13 +21,9 @@ SRC_URI = " \
 DEBIAN_DEPENDS = "passwd"
 
 do_install() {
-	sudo rm -rf ${D}/etc ${D}/root
-
 	install -v -d ${D}/etc/network/interfaces.d
 	install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
 
 	install -v -d ${D}/etc/sysctl.d
 	install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
-
-	sudo chown -R root:root ${D}/etc
 }
-- 
2.16.4


