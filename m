From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 2/5] xenomai: Update to 3.1.1
Date: Fri, 11 Jun 2021 22:13:09 +0200
Message-Id: <a75cbe097129686703a47ce3c2b02af10ce1344a.1623442392.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1623442392.git.jan.kiszka@siemens.com>
References: <cover.1623442392.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-xenomai/xenomai/{xenomai_3.1.bb => xenomai_3.1.1.bb} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename recipes-xenomai/xenomai/{xenomai_3.1.bb => xenomai_3.1.1.bb} (78%)

diff --git a/recipes-xenomai/xenomai/xenomai_3.1.bb b/recipes-xenomai/xenomai/xenomai_3.1.1.bb
similarity index 78%
rename from recipes-xenomai/xenomai/xenomai_3.1.bb
rename to recipes-xenomai/xenomai/xenomai_3.1.1.bb
index f117eee..5a3c41d 100644
--- a/recipes-xenomai/xenomai/xenomai_3.1.bb
+++ b/recipes-xenomai/xenomai/xenomai_3.1.1.bb
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2021
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,6 +12,6 @@
 require xenomai.inc
 
 SRC_URI = " \
-    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=master;tag=v${PV}"
+    git://github.com/xenomai-ci/xenomai.git;protocol=https;branch=stable/v3.1.x;tag=v${PV}"
 
 S = "${WORKDIR}/git"
-- 
2.26.2


