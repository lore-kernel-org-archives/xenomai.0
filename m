From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v2] ci: Add 3.2.x stable, confine next
Message-ID: <9ecf0a8c-f695-8dcc-c522-e40fb5e9f732@siemens.com>
Date: Wed, 15 Dec 2021 11:33:14 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Open up the building & testing for stable/v3.2.x by moving current
'next' rules over. As the next Xenomai release will drop support for
I-pipe kernels, drop anything but 5.10 from the related CI rules for the
development head. That also avoids increasing the CI load too much.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fixed xenomai_next.yml - dropped too much

 .gitlab-ci.yml                             | 6 ++++++
 ci/{xenomai_next.yml => xenomai_3_2_x.yml} | 1 +
 ci/xenomai_next.yml                        | 3 +--
 3 files changed, 8 insertions(+), 2 deletions(-)
 copy ci/{xenomai_next.yml => xenomai_3_2_x.yml} (99%)

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
similarity index 99%
copy from ci/xenomai_next.yml
copy to ci/xenomai_3_2_x.yml
index b13dfa8..e8c7705 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_3_2_x.yml
@@ -8,6 +8,7 @@
 #
 # SPDX-License-Identifier: MIT
 #
+
 include:
   - local: '/ci/gitlab-ci-base.yml'
   - local: '/ci/kernel_4_19_xenomai_next.yml'
diff --git a/ci/xenomai_next.yml b/ci/xenomai_next.yml
index b13dfa8..4f50b71 100644
--- a/ci/xenomai_next.yml
+++ b/ci/xenomai_next.yml
@@ -8,8 +8,7 @@
 #
 # SPDX-License-Identifier: MIT
 #
+
 include:
   - local: '/ci/gitlab-ci-base.yml'
-  - local: '/ci/kernel_4_19_xenomai_next.yml'
-  - local: '/ci/kernel_5_4_xenomai_next.yml'
   - local: '/ci/kernel_5_10_xenomai_next.yml'
-- 
2.31.1

