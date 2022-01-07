From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH v4 4/8] ci: Drop no longer user
 TARGET_EXTENSION variable
Date: Fri, 7 Jan 2022 16:02:59 +0100
Message-ID: <26931a66cf444cb9cf0d97600f3fa88dc88ad4bc.1641567783.git.jan.kiszka@siemens.com>
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

Was obsoleted by d3a501ebfe2c.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/gitlab-ci-base.yml | 2 +-
 tests/README.md       | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index cdf20e5..057b9dd 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -50,7 +50,7 @@ default:
     - scripts/install-lavacli.sh
     - scripts/run-lava-tests.sh ${TARGET}
   variables:
-    BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}${TARGET_EXTENSION}"
+    BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}"
   artifacts:
     when: always
     reports:
diff --git a/tests/README.md b/tests/README.md
index 24ffb81..5779e9b 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -111,7 +111,6 @@ The following variables are used and set by the ci system:
 - General build settings
   - `BUILD_OPTIONS` : optional parameter. Used for triggers. Overwrite to build the newest ipipe together with xenomai or other combinations.
   - `DEPLOY_DIR_EXTENSION`: Extension path to store artifacts for the same target
-  - `TARGET_EXTENSION`: Extension of the build job name
 
 ## LAVA Template variable
 
-- 
2.31.1


