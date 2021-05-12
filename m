From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 7/9] ci: Rename and reorder child pipeline
Date: Wed, 12 May 2021 10:32:21 +0200
Message-Id: <bf3d41701b404261dabe5a59ed28a553bb410816.1620808343.git.jan.kiszka@siemens.com>
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

Ordering for pure aesthetic reasons, naming to align with the branch
names from the main Xenomai repo. The latter will help with setting
triggers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/child_pipelines_artifacts.yml    | 12 ++++++------
 ci/child_pipelines_no_artifacts.yml | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/ci/child_pipelines_artifacts.yml b/ci/child_pipelines_artifacts.yml
index 6d8ce9f..eb97f31 100644
--- a/ci/child_pipelines_artifacts.yml
+++ b/ci/child_pipelines_artifacts.yml
@@ -11,26 +11,26 @@
 stages:
   - parent
 
-xenomai next:
+stable/v3.0.x:
   stage: parent
   trigger:
     include:
       - local: '/ci/artifacts.yml'
-      - local: '/ci/xenomai_next.yml'
+      - local: '/ci/xenomai_3_0_x.yml'
     strategy: depend
 
-xenomai 3.0.x:
+stable/v3.1.x:
   stage: parent
   trigger:
     include:
       - local: '/ci/artifacts.yml'
-      - local: '/ci/xenomai_3_0_x.yml'
+      - local: '/ci/xenomai_3_1_x.yml'
     strategy: depend
 
-xenomai 3.1.x:
+next:
   stage: parent
   trigger:
     include:
       - local: '/ci/artifacts.yml'
-      - local: '/ci/xenomai_3_1_x.yml'
+      - local: '/ci/xenomai_next.yml'
     strategy: depend
diff --git a/ci/child_pipelines_no_artifacts.yml b/ci/child_pipelines_no_artifacts.yml
index e347990..2ff4d7b 100644
--- a/ci/child_pipelines_no_artifacts.yml
+++ b/ci/child_pipelines_no_artifacts.yml
@@ -11,26 +11,26 @@
 stages:
   - parent
 
-xenomai next:
+stable/v3.0.x:
   stage: parent
   trigger:
     include:
       - local: '/ci/no-artifacts.yml'
-      - local: '/ci/xenomai_next.yml'
+      - local: '/ci/xenomai_3_0_x.yml'
     strategy: depend
 
-xenomai 3.0.x:
+stable/v3.1.x:
   stage: parent
   trigger:
     include:
       - local: '/ci/no-artifacts.yml'
-      - local: '/ci/xenomai_3_0_x.yml'
+      - local: '/ci/xenomai_3_1_x.yml'
     strategy: depend
 
-xenomai 3.1.x:
+next:
   stage: parent
   trigger:
     include:
       - local: '/ci/no-artifacts.yml'
-      - local: '/ci/xenomai_3_1_x.yml'
+      - local: '/ci/xenomai_next.yml'
     strategy: depend
-- 
2.26.2


