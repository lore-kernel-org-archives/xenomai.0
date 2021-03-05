From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] ci: Print used kas configuration
Message-ID: <cf2e742a-1405-ad89-bf6b-82628dbcfa64@siemens.com>
Date: Fri, 5 Mar 2021 20:32:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

gitlab-ci does not tell us the value of the variables used in a job.
Print them explicitly so that they are easier to grab for local
reproduction.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ci/artifacts.yml    | 1 +
 ci/no-artifacts.yml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ci/artifacts.yml b/ci/artifacts.yml
index 96dae00..2a0d639 100644
--- a/ci/artifacts.yml
+++ b/ci/artifacts.yml
@@ -20,6 +20,7 @@
   extends: .add-lava-ssh-config
   stage: build
   script:
+    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
   artifacts:
     paths:
diff --git a/ci/no-artifacts.yml b/ci/no-artifacts.yml
index 99154ac..4efff7a 100644
--- a/ci/no-artifacts.yml
+++ b/ci/no-artifacts.yml
@@ -20,6 +20,7 @@
   extends: .add-lava-ssh-config
   stage: build
   script:
+    - echo "Building kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}"
     - kas build kas.yml:board-${TARGET}.yml${XENOMAI_BUILD_OPTION}${LINUX_BUILD_OPTION}${BUILD_OPTIONS}
     - scripts/deploy_for_testing.sh ${TARGET}
   except:
-- 
2.26.2

