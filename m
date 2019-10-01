From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 3/4] ci: Run qemu tests with --vm option
Date: Tue,  1 Oct 2019 11:24:42 +0200
Message-Id: <20191001092443.19602-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20191001092443.19602-1-Quirin.Gylstorff@siemens.com>
References: <20191001092443.19602-1-Quirin.Gylstorff@siemens.com>
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

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To avoid failing test due to virtualization add the newly introduced
option --vm to the xeno-test execution.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 tests/jobs/xenomai-qemu-amd64.yml | 2 +-
 tests/jobs/xenomai-qemu-arm64.yml | 2 +-
 tests/jobs/xenomai-qemu-armhf.yml | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 26f42fa..9520e16 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -83,7 +83,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k
+            - lava-test-case xenomai-test --shell xeno-test -k --vm
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index a14c0b2..44c8731 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -92,7 +92,7 @@ actions:
             - quirin.gylstorff@siemens.org
         run:
           steps:
-            - lava-test-case xenomai-smokey --shell xeno-test -k
+            - lava-test-case xenomai-smokey --shell xeno-test -k --vm
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index f080d1a..1c5cb2e 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -83,7 +83,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k
+            - lava-test-case xenomai-test --shell xeno-test -k --vm
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
-- 
2.20.1


