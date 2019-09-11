From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH] xenomai: Install debug symbols
Date: Wed, 11 Sep 2019 18:11:10 +0200
Message-Id: <20190911161110.2151-1-Quirin.Gylstorff@siemens.com>
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

To debug the xenomai runtime add the debug symbols to the demo
image.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/demo-image.bb   | 2 +-
 recipes-xenomai/xenomai/xenomai.inc | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index 2f1f522..d01142b 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -20,5 +20,5 @@ IMAGE_PREINSTALL += " \
     iw wireless-tools wpasupplicant dbus \
     gdb lsb-release"
 
-IMAGE_INSTALL += "xenomai-runtime"
+IMAGE_INSTALL += "xenomai-runtime xenomai-runtime-dbgsym libxenomai1-dbgsym"
 IMAGE_INSTALL += "customizations expand-on-first-boot"
diff --git a/recipes-xenomai/xenomai/xenomai.inc b/recipes-xenomai/xenomai/xenomai.inc
index aa53e57..bd07347 100644
--- a/recipes-xenomai/xenomai/xenomai.inc
+++ b/recipes-xenomai/xenomai/xenomai.inc
@@ -11,7 +11,7 @@
 
 inherit dpkg
 
-PROVIDES += "xenomai-kernel-source xenomai-runtime"
+PROVIDES += "xenomai-kernel-source xenomai-runtime xenomai-runtime-dbgsym libxenomai1-dbgsym"
 
 # use bitbake get_srcrev to get the current commit id
 COMMIT="${@bb.fetch2.get_srcrev(d).strip('AUTOINC+')}"
-- 
2.20.1


