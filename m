From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH 6/9] ci: Add inline xenomai testsuite
Date: Thu,  5 Sep 2019 17:44:22 +0200
Message-Id: <20190905154425.10007-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
References: <20190905154425.10007-1-Quirin.Gylstorff@siemens.com>
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

Add the inline test definition to execute xeno-test for the images.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 tests/README.md                   |  5 +++++
 tests/jobs/xenomai-beaglebone.yml | 11 +++++++++++
 tests/jobs/xenomai-minnow.yml     | 11 +++++++++++
 tests/jobs/xenomai-qemu-amd64.yml | 11 +++++++++++
 tests/jobs/xenomai-qemu-arm64.yml | 13 +++++++++++++
 tests/jobs/xenomai-qemu-armhf.yml | 11 +++++++++++
 tests/jobs/xenomai-x86-64.yml     | 11 +++++++++++
 7 files changed, 73 insertions(+)

diff --git a/tests/README.md b/tests/README.md
index c7e2030..f107607 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -17,8 +17,13 @@ following images are test:
 
 Currently the following tests are executed on each target:
 - lava-smoketest
+- xenomai-test-suite
 
 ### lava-smoketest
 
 The lava smoke tests are part of http://git.linaro.org/lava-team/lava-functional-tests.git
 and check machine data from the target.
+
+### xenomai-test-suite
+
+The xenomai test suite executes the xeno-test tool from xenomai/testsuite.
diff --git a/tests/jobs/xenomai-beaglebone.yml b/tests/jobs/xenomai-beaglebone.yml
index 231c5d0..85f2b88 100644
--- a/tests/jobs/xenomai-beaglebone.yml
+++ b/tests/jobs/xenomai-beaglebone.yml
@@ -63,3 +63,14 @@ actions:
       from: git
       path: lava-test-shell/smoke-tests-basic.yaml
       name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-minnow.yml b/tests/jobs/xenomai-minnow.yml
index d60628d..dcdcc28 100644
--- a/tests/jobs/xenomai-minnow.yml
+++ b/tests/jobs/xenomai-minnow.yml
@@ -60,3 +60,14 @@ actions:
       from: git
       path: lava-test-shell/smoke-tests-basic.yaml
       name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index 12f4c7f..2976f89 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -74,3 +74,14 @@ actions:
       from: git
       path: lava-test-shell/smoke-tests-basic.yaml
       name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - lava-test-case xenomai-test --shell xeno-test -k
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index fceee0c..8ba4575 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -81,3 +81,16 @@ actions:
       from: git
       path: lava-test-shell/smoke-tests-basic.yaml
       name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai smokey test suite"
+          maintainer:
+            - quirin.gylstorff@siemens.org
+        run:
+          steps:
+            - lava-test-case xenomai-smokey --shell xeno-test -k
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index d6603af..238265b 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -74,3 +74,14 @@ actions:
       from: git
       path: lava-test-shell/smoke-tests-basic.yaml
       name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - lava-test-case xenomai-test --shell xeno-test -k
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-x86-64.yml b/tests/jobs/xenomai-x86-64.yml
index 0fb3ea8..9d58c45 100644
--- a/tests/jobs/xenomai-x86-64.yml
+++ b/tests/jobs/xenomai-x86-64.yml
@@ -61,3 +61,14 @@ actions:
       from: git
       path: lava-test-shell/smoke-tests-basic.yaml
       name: smoke-tests
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: xenomai-test-suite
+          description: "runs the xenomai test suite"
+        run:
+          steps:
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
+      from: inline
+      path: inline/xenomai-test-suite.yaml
+      name: xenomai-test-suite
-- 
2.20.1


