From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 9/9] ci: Add job filter variable
Date: Wed, 12 May 2021 10:32:23 +0200
Message-Id: <566181deff98317051f959197171615b5cd9a1f9.1620808343.git.jan.kiszka@siemens.com>
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

This allows to set a filter variable when triggering the pipeline,
effectively running only one of the currently three child pipelines.
Will permit automatic triggering from the Xenomai repo on pushes to the
corresponding branches.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/child_pipelines_common.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ci/child_pipelines_common.yml b/ci/child_pipelines_common.yml
index d742041..a96a81f 100644
--- a/ci/child_pipelines_common.yml
+++ b/ci/child_pipelines_common.yml
@@ -17,3 +17,5 @@ stages:
   stage: parent
   trigger:
     strategy: depend
+  rules:
+    - if: '$ONLY_RUN == null || $ONLY_RUN == $CI_JOB_NAME'
-- 
2.26.2


