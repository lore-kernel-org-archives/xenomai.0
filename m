From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 2/4] scripts/run-lava-tests: upload lava
 test report
Date: Wed, 14 Jul 2021 09:41:53 +0200
Message-Id: <20210714074155.2625-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210714074155.2625-1-Quirin.Gylstorff@siemens.com>
References: <20210714074155.2625-1-Quirin.Gylstorff@siemens.com>
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
To: jan.kiszka@siemens.com, xenomai@xenomai.org

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

upload a test report to gitlab to increase tracing of build
errors.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 ci/gitlab-ci-base.yml     | 6 ++++++
 scripts/run-lava-tests.sh | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
index 96b9c2c..7f245e3 100644
--- a/ci/gitlab-ci-base.yml
+++ b/ci/gitlab-ci-base.yml
@@ -57,6 +57,12 @@ default:
     - scripts/run-lava-tests.sh ${TARGET}
   variables:
     BUILD_JOB_NAME: "build-${BUILD_IDENTIFIER}:${TARGET}${TARGET_EXTENSION}"
+  artifacts:
+    when: always
+    reports:
+      junit:
+        - report.xml
+    expire_in: 1 week
   only:
     variables:
       - $LAVA_TESTS_ENABLED == "true"
diff --git a/scripts/run-lava-tests.sh b/scripts/run-lava-tests.sh
index 72138c3..e398afd 100755
--- a/scripts/run-lava-tests.sh
+++ b/scripts/run-lava-tests.sh
@@ -74,8 +74,17 @@ echo "submit lava job"
 test_id=$(lavacli jobs submit "${template}")
 lavacli jobs logs "${test_id}"
 lavacli results "${test_id}"
+
+# add test report download
+api="${lava_master_uri}/api/v0.2/jobs/${test_id}/junit"
+auth="?token=${LAVA_MASTER_TOKEN}"
+url="${api}/${auth}"
+
+curl --silent "${url}" -o report.xml
+
 # change return code to generate a error in gitlab-ci if a test is failed
 number_of_fails="$(lavacli results "${test_id}" | grep -c fail )"
+
 if [ -n "${ssh_pid}" ];then
    kill "${ssh_pid}"
 fi
-- 
2.20.1


