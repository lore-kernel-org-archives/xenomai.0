From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 2/3] Rename local_conf_header section for
 kernel version
Date: Thu,  9 Sep 2021 19:44:33 +0200
Message-Id: <e32b86ff119e0d3d704846d85a48f834e390ff96.1631209474.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1631209474.git.jan.kiszka@siemens.com>
References: <cover.1631209474.git.jan.kiszka@siemens.com>
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

Use a more intuitive name. No functional changes.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 opt-linux-4.19.yml        | 4 ++--
 opt-linux-4.4.yml         | 4 ++--
 opt-linux-latest-5.10.yml | 2 +-
 opt-linux-latest-5.4.yml  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/opt-linux-4.19.yml b/opt-linux-4.19.yml
index fb3657f..d5fa5ef 100644
--- a/opt-linux-4.19.yml
+++ b/opt-linux-4.19.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2021
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,5 +13,5 @@ header:
   version: 10
 
 local_conf_header:
-  linux-xenomai-latest: |
+  linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai = "4.19%"
diff --git a/opt-linux-4.4.yml b/opt-linux-4.4.yml
index c4afa68..2b9dd14 100644
--- a/opt-linux-4.4.yml
+++ b/opt-linux-4.4.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2021
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -13,5 +13,5 @@ header:
   version: 10
 
 local_conf_header:
-  linux-xenomai-latest: |
+  linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai = "4.4%"
diff --git a/opt-linux-latest-5.10.yml b/opt-linux-latest-5.10.yml
index 89530b8..a6bb221 100644
--- a/opt-linux-latest-5.10.yml
+++ b/opt-linux-latest-5.10.yml
@@ -13,6 +13,6 @@ header:
   version: 10
 
 local_conf_header:
-  linux-xenomai-latest: |
+  linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai = "9999-%"
     LATEST_GIT_BRANCH = "5.10"
diff --git a/opt-linux-latest-5.4.yml b/opt-linux-latest-5.4.yml
index 7767be4..d3164e3 100644
--- a/opt-linux-latest-5.4.yml
+++ b/opt-linux-latest-5.4.yml
@@ -13,6 +13,6 @@ header:
   version: 10
 
 local_conf_header:
-  linux-xenomai-latest: |
+  linux-xenomai-version: |
     PREFERRED_VERSION_linux-xenomai = "9999-%"
     LATEST_GIT_BRANCH = "5.4"
-- 
2.31.1


