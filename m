From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 02/10] xenomai: Update to 3.0.10
Date: Mon, 10 Feb 2020 19:17:41 +0100
Message-Id: <fa24d7c349e4f9b589626e48ff3d754be60a0a4e.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1581358669.git.jan.kiszka@siemens.com>
References: <cover.1581358669.git.jan.kiszka@siemens.com>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/include/xenomai-version.inc                         | 2 +-
 recipes-xenomai/xenomai/{xenomai_3.0.9.bb => xenomai_3.0.10.bb} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename recipes-xenomai/xenomai/{xenomai_3.0.9.bb => xenomai_3.0.10.bb} (100%)

diff --git a/conf/distro/include/xenomai-version.inc b/conf/distro/include/xenomai-version.inc
index 524ca39..286d3a7 100644
--- a/conf/distro/include/xenomai-version.inc
+++ b/conf/distro/include/xenomai-version.inc
@@ -10,7 +10,7 @@
 #
 
 XENOMAI_NEXT_KERNEL_VERSION = "4.19%"
-XENOMAI_STABLE_VERSION_LIST = "stable 3.0 3.0% 3.0.% 3.0.9"
+XENOMAI_STABLE_VERSION_LIST = "stable 3.0 3.0% 3.0.% 3.0.10"
 XENOMAI_STABLE_KERNEL_VERSION = "4.14%"
 # if PREFERRED_VERSION_xenomai contains any item from XENOMAI_STABLE_VERSION_LIST use
 # XENOMAI_STABLE_KERNEL_VERSION
diff --git a/recipes-xenomai/xenomai/xenomai_3.0.9.bb b/recipes-xenomai/xenomai/xenomai_3.0.10.bb
similarity index 100%
rename from recipes-xenomai/xenomai/xenomai_3.0.9.bb
rename to recipes-xenomai/xenomai/xenomai_3.0.10.bb
-- 
2.16.4


