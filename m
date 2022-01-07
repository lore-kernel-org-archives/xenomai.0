From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6/6] ci: Drop some I-pipe left-overs
Date: Fri, 7 Jan 2022 12:35:35 +0100
Message-ID: <5d525d62b139eb991641d0cf0e134e196bb8d018.1641555334.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641555334.git.jan.kiszka@siemens.com>
References: <cover.1641555334.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
 .gitlab-ci.yml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8a9a631d41..ca3c086200 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,7 +1,7 @@
 #
 # Xenomai Real-Time System
 #
-# Copyright (c) Siemens AG, 2020-2021
+# Copyright (c) Siemens AG, 2020-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -20,7 +20,6 @@ variables:
   KDIR: "/tmp/kernel"
   USE_CCACHE: "1"
   CCACHE_MAXSIZE: "1G"
-  IPIPE_URL: "https://source.denx.de/Xenomai"
   DOVETAIL_URL: "https://source.denx.de/Xenomai/linux-dovetail.git"
   GCC_VERSION: "10"
   PACKAGES: "u-boot-tools git make bc bison libelf-dev autotools-dev \
@@ -74,7 +73,6 @@ variables:
     # Generic settings
     - ./scripts/config -d DEBUG_INFO
     # I-pipe and Xenomai settings
-    - ./scripts/config -e IPIPE
     - ./scripts/config -e DOVETAIL
     - ./scripts/config -e XENOMAI
     - ./scripts/config -e XENO_OPT_SCHED_CLASSES
-- 
2.31.1


