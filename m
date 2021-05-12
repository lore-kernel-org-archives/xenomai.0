From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 8/9] ci: Factor out common bridge jobs
Date: Wed, 12 May 2021 10:32:22 +0200
Message-Id: <415b61ef8ffe882f5ba8a751e6ee8f277cd2b13d.1620808343.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620808343.git.jan.kiszka@siemens.com>
References: <cover.1620808343.git.jan.kiszka@siemens.com>
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

Further reduces the duplicate parts in
child_pipelines_[no_]artifacts.yml.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/child_pipelines_artifacts.yml    | 14 ++++++--------
 ci/child_pipelines_common.yml       | 19 +++++++++++++++++++
 ci/child_pipelines_no_artifacts.yml | 14 ++++++--------
 3 files changed, 31 insertions(+), 16 deletions(-)
 create mode 100644 ci/child_pipelines_common.yml

diff --git a/ci/child_pipelines_artifacts.yml b/ci/child_pipelines_artifacts.yml
index eb97f31..1dd856c 100644
--- a/ci/child_pipelines_artifacts.yml
+++ b/ci/child_pipelines_artifacts.yml
@@ -8,29 +8,27 @@
 #
 # SPDX-License-Identifier: MIT
 #
-stages:
-  - parent
+
+include:
+  - local: '/ci/child_pipelines_common.yml'
 
 stable/v3.0.x:
-  stage: parent
+  extends: .parent
   trigger:
     include:
       - local: '/ci/artifacts.yml'
       - local: '/ci/xenomai_3_0_x.yml'
-    strategy: depend
 
 stable/v3.1.x:
-  stage: parent
+  extends: .parent
   trigger:
     include:
       - local: '/ci/artifacts.yml'
       - local: '/ci/xenomai_3_1_x.yml'
-    strategy: depend
 
 next:
-  stage: parent
+  extends: .parent
   trigger:
     include:
       - local: '/ci/artifacts.yml'
       - local: '/ci/xenomai_next.yml'
-    strategy: depend
diff --git a/ci/child_pipelines_common.yml b/ci/child_pipelines_common.yml
new file mode 100644
index 0000000..d742041
--- /dev/null
+++ b/ci/child_pipelines_common.yml
@@ -0,0 +1,19 @@
+#
+# Xenomai Real-Time System
+#
+# Copyright (c) Siemens AG, 2019 - 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+stages:
+  - parent
+
+.parent:
+  stage: parent
+  trigger:
+    strategy: depend
diff --git a/ci/child_pipelines_no_artifacts.yml b/ci/child_pipelines_no_artifacts.yml
index 2ff4d7b..c90204d 100644
--- a/ci/child_pipelines_no_artifacts.yml
+++ b/ci/child_pipelines_no_artifacts.yml
@@ -8,29 +8,27 @@
 #
 # SPDX-License-Identifier: MIT
 #
-stages:
-  - parent
+
+include:
+  - local: '/ci/child_pipelines_common.yml'
 
 stable/v3.0.x:
-  stage: parent
+  extends: .parent
   trigger:
     include:
       - local: '/ci/no-artifacts.yml'
       - local: '/ci/xenomai_3_0_x.yml'
-    strategy: depend
 
 stable/v3.1.x:
-  stage: parent
+  extends: .parent
   trigger:
     include:
       - local: '/ci/no-artifacts.yml'
       - local: '/ci/xenomai_3_1_x.yml'
-    strategy: depend
 
 next:
-  stage: parent
+  extends: .parent
   trigger:
     include:
       - local: '/ci/no-artifacts.yml'
       - local: '/ci/xenomai_next.yml'
-    strategy: depend
-- 
2.26.2


