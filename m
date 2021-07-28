From: Hongzhan Chen <hongzhan.chen@intel.com>
Subject: [PATCH] ci/gitlab-ci-base: Switch xenomai debug on for ci build
Date: Wed, 28 Jul 2021 08:35:20 -0400
Message-Id: <20210728123520.10270-1-hongzhan.chen@intel.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Some smokey test items depend on xenomai debug and we need to switch
it on to help smokey test pass.

Signed-off-by: Hongzhan Chen <hongzhan.chen@intel.com>

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index e23849d..2638dec 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -39,8 +39,8 @@ default:
   extends: .add-proxy-config
   stage: build
   script:
-    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
+    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml"
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
-- 
2.17.1


