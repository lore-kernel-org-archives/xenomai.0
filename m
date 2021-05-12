From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH 4/9] ci: Remove redundant job filtering on
 USE_GITLAB_ARTIFACTS
Date: Wed, 12 May 2021 10:32:18 +0200
Message-Id: <cb8aa4c02b9e8764419947d5db7ab14a4431e2a7.1620808343.git.jan.kiszka@siemens.com>
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

Already done by including only one of the two files.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/artifacts.yml    | 4 ----
 ci/no-artifacts.yml | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/ci/artifacts.yml b/ci/artifacts.yml
index fb1549f..9d6b0e1 100644
--- a/ci/artifacts.yml
+++ b/ci/artifacts.yml
@@ -30,7 +30,3 @@ variables:
     paths:
     - build/tmp/deploy/images/${TARGET}/
     expire_in: 1 week
-  only:
-    variables:
-      - $USE_GITLAB_ARTIFACTS
-
diff --git a/ci/no-artifacts.yml b/ci/no-artifacts.yml
index 4efff7a..f7e0aed 100644
--- a/ci/no-artifacts.yml
+++ b/ci/no-artifacts.yml
@@ -23,6 +23,3 @@
     - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh ${TARGET}
-  except:
-    variables:
-      - $USE_GITLAB_ARTIFACTS
-- 
2.26.2


