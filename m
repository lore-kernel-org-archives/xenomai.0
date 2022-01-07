From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v4 6/8] ci: Add 3.2.x stable, confine next
Date: Fri, 7 Jan 2022 16:03:01 +0100
Message-ID: <f7056d1a16b0ed0cebaa555b09172c6b0f23dcdf.1641567783.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1641567783.git.jan.kiszka@siemens.com>
References: <cover.1641567783.git.jan.kiszka@siemens.com>
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

Open up the building & testing for stable/v3.2.x by moving current
'next' rules over. As the next Xenomai release dropped support for
I-pipe kernels, drop anything but 5.10 from the related CI rules for the
development head. That also avoids increasing the CI load too much.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml                             | 6 ++++++
 ci/{xenomai_next.yml => xenomai_3_2_x.yml} | 4 ++--
 ci/xenomai_next.yml                        | 2 --
 3 files changed, 8 insertions(+), 4 deletions(-)
 copy ci/{xenomai_next.yml => xenomai_3_2_x.yml} (81%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c1eb0b3..58398fc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -32,6 +32,12 @@ stable/v3.1.x:
     include:
       - local: '/ci/xenomai_3_1_x.yml'
 
+stable/v3.2.x:
+  extends: .parent
+  trigger:
+    include:
+      - local: '/ci/xenomai_3_2_x.yml'
+
 next:
   extends: .parent
   trigger:
diff --git a/ci/xenomai_next.yml b/ci/xenomai_3_2_x.yml
similarity index 81%
copy from ci/xenomai_next.yml
copy to ci/xenomai_3_2_x.yml
index 91275ae..7ca77a3 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -16,5 +16,5 @@ include:
   - local: '/ci/kernel_5_10.yml'
 
 variables:
-  XENOMAI_BUILD_OPTION: ":opt-xenomai-next.yml"
-  XENOMAI_VERSION: "next"
+  XENOMAI_BUILD_OPTION: ":opt-xenomai-3.2.x.yml"
+  XENOMAI_VERSION: "3.2.x"
diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
index 91275ae..adb5990 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_next.yml
@@ -11,8 +11,6 @@
 
 include:
   - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_4_19.yml'
-  - local: '/ci/kernel_5_4.yml'
   - local: '/ci/kernel_5_10.yml'
 
 variables:
-- 
2.31.1


