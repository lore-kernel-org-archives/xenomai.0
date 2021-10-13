From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH v2 1/8] kas: Rename opt-lava-test.yml to
 opt-ci-board.yml
Date: Wed, 13 Oct 2021 14:17:25 +0200
Message-Id: <20211013121732.140595-2-florian.bezdeka@siemens.com>
In-Reply-To: <20211013121732.140595-1-florian.bezdeka@siemens.com>
References: <20211013121732.140595-1-florian.bezdeka@siemens.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

This kas option file is used for real test / ci boards only. The
previous name indicated that it is used for all ci tests including
virtual devices like (qemu).

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ci/gitlab-ci-base.yml                 | 6 +++---
 opt-lava-test.yml => opt-ci-board.yml | 0
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename opt-lava-test.yml => opt-ci-board.yml (100%)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 8a1dbfb..3ea2467 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -97,7 +97,7 @@ default:
   extends: .build
   variables:
     TARGET: hikey
-    BUILD_OPTIONS: ":opt-lava-test.yml"
+    BUILD_OPTIONS: ":opt-ci-board.yml"
 
 .lava-test:hikey:
   extends: .test
@@ -109,7 +109,7 @@ default:
   extends: .build
   variables:
     TARGET: beagle-bone-black
-    BUILD_OPTIONS: ":opt-lava-test.yml"
+    BUILD_OPTIONS: ":opt-ci-board.yml"
 
 .lava-test:beagle-bone-black:
   extends: .test
@@ -121,7 +121,7 @@ default:
   extends: .build
   variables:
     TARGET: x86-64-efi
-    BUILD_OPTIONS: ":opt-lava-test.yml"
+    BUILD_OPTIONS: ":opt-ci-board.yml"
 
 .lava-test:x86-64-efi:
   extends: .test
diff --git a/opt-lava-test.yml b/opt-ci-board.yml
similarity index 100%
rename from opt-lava-test.yml
rename to opt-ci-board.yml
-- 
2.31.1


