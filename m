From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [xenomai-images][PATCH 2/6] kas: Integrate opt-debug.yml into
 opt-ci.yml
Date: Wed, 13 Oct 2021 09:18:20 +0200
Message-Id: <20211013071824.9394-3-florian.bezdeka@siemens.com>
In-Reply-To: <20211013071824.9394-1-florian.bezdeka@siemens.com>
References: <20211013071824.9394-1-florian.bezdeka@siemens.com>
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

Whenever the kas option file opt-ci.yml is used we want the same build
options as the CI does, which includes setting the debug options.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 ci/gitlab-ci-base.yml | 4 ++--
 opt-ci.yml            | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 26c3f60..3378fcf 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -39,8 +39,8 @@ default:
   stage: build
   script:
     - sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"
-    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml:opt-ci.yml"
-    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-debug.yml:opt-ci.yml
+    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml"
+    - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}:opt-ci.yml
     - if [ -n "${USE_S3_BUCKET}" ]; then scripts/deploy_to_aws.sh ${TARGET}; fi
 
 .test:
diff --git a/opt-ci.yml b/opt-ci.yml
index 6766cb0..663a908 100644
--- a/opt-ci.yml
+++ b/opt-ci.yml
@@ -11,6 +11,8 @@
 
 header:
   version: 10
+  includes:
+    - opt-debug.yml
 
 local_conf_header:
   xenomai-ci: |
-- 
2.31.1


