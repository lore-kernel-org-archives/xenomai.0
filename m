From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [xenomai-images][PATCH] tests: Consolidate xeno-test parameters
Message-ID: <f0a7fe76-2daa-1eac-7866-a71c094df1dc@siemens.com>
Date: Wed, 14 Jul 2021 15:10:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

QEMU targets were run the full default 15 minutes while real targets
only used 5. Use 5 min. for all now.

Furthermore, '-p 1000' was passed to real targets. This is redundant as
latency already uses 1000 µs as default period.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 tests/jobs/xenomai-beagle-bone-black.yml | 2 +-
 tests/jobs/xenomai-hikey.yml             | 2 +-
 tests/jobs/xenomai-qemu-amd64.yml        | 2 +-
 tests/jobs/xenomai-qemu-arm64.yml        | 2 +-
 tests/jobs/xenomai-qemu-armhf.yml        | 2 +-
 tests/jobs/xenomai-x86-64-efi.yml        | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/jobs/xenomai-beagle-bone-black.yml b/tests/jobs/xenomai-beagle-bone-black.yml
index 034ac99..9a4acf1 100644
--- a/tests/jobs/xenomai-beagle-bone-black.yml
+++ b/tests/jobs/xenomai-beagle-bone-black.yml
@@ -67,7 +67,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-hikey.yml b/tests/jobs/xenomai-hikey.yml
index a2cbdaa..14fd9f3 100644
--- a/tests/jobs/xenomai-hikey.yml
+++ b/tests/jobs/xenomai-hikey.yml
@@ -66,7 +66,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-amd64.yml b/tests/jobs/xenomai-qemu-amd64.yml
index c335292..29f5216 100644
--- a/tests/jobs/xenomai-qemu-amd64.yml
+++ b/tests/jobs/xenomai-qemu-amd64.yml
@@ -83,7 +83,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k --vm
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" --vm
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-arm64.yml b/tests/jobs/xenomai-qemu-arm64.yml
index 88fb880..fa0b5bb 100644
--- a/tests/jobs/xenomai-qemu-arm64.yml
+++ b/tests/jobs/xenomai-qemu-arm64.yml
@@ -89,7 +89,7 @@ actions:
             - quirin.gylstorff@siemens.org
         run:
           steps:
-            - lava-test-case xenomai-smokey --shell xeno-test -k --vm
+            - lava-test-case xenomai-smokey --shell xeno-test -k -l \"dohell -m /tmp 300\" --vm
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-qemu-armhf.yml b/tests/jobs/xenomai-qemu-armhf.yml
index 3e3a8ab..9507a4f 100644
--- a/tests/jobs/xenomai-qemu-armhf.yml
+++ b/tests/jobs/xenomai-qemu-armhf.yml
@@ -83,7 +83,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k --vm
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" --vm
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
diff --git a/tests/jobs/xenomai-x86-64-efi.yml b/tests/jobs/xenomai-x86-64-efi.yml
index 5a2f533..ec28291 100644
--- a/tests/jobs/xenomai-x86-64-efi.yml
+++ b/tests/jobs/xenomai-x86-64-efi.yml
@@ -68,7 +68,7 @@ actions:
           description: "runs the xenomai test suite"
         run:
           steps:
-            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\" -p 1000
+            - lava-test-case xenomai-test --shell xeno-test -k -l \"dohell -m /tmp 300\"
       from: inline
       path: inline/xenomai-test-suite.yaml
       name: xenomai-test-suite
-- 
2.26.2

