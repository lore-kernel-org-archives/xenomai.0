From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 2/3] kas: update isar
Date: Fri, 20 Sep 2019 16:57:30 +0200
Message-Id: <20190920145731.25281-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190920145731.25281-1-Quirin.Gylstorff@siemens.com>
References: <20190920145731.25281-1-Quirin.Gylstorff@siemens.com>
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

Update isar to current next.
Add mandatory sshd-regen-keys.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas.yml                           | 2 +-
 recipes-core/images/demo-image.bb | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas.yml b/kas.yml
index a4d12c2..06b59ac 100644
--- a/kas.yml
+++ b/kas.yml
@@ -20,7 +20,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 59c7dd2b8b3172d53de1c7a39fbd49751193559a
+    refspec: a5d575a15285b7f66efbf3e2409a7f65d25ff15e
     layers:
       meta:
 
diff --git a/recipes-core/images/demo-image.bb b/recipes-core/images/demo-image.bb
index d01142b..df849f2 100644
--- a/recipes-core/images/demo-image.bb
+++ b/recipes-core/images/demo-image.bb
@@ -21,4 +21,4 @@ IMAGE_PREINSTALL += " \
     gdb lsb-release"
 
 IMAGE_INSTALL += "xenomai-runtime xenomai-runtime-dbgsym libxenomai1-dbgsym"
-IMAGE_INSTALL += "customizations expand-on-first-boot"
+IMAGE_INSTALL += "customizations sshd-regen-keys expand-on-first-boot"
-- 
2.20.1


