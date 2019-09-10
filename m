From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [xenomai-images][PATCH v2 8/9] tests/README: Add deployment and Setup
Date: Tue, 10 Sep 2019 16:44:58 +0200
Message-Id: <20190910144459.13239-9-Quirin.Gylstorff@siemens.com>
In-Reply-To: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
References: <40515a30-f023-af93-5662-e47c70da438e@siemens.com>
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

Add links to setup lava and instructions howto deploy a test.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 tests/README.md | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tests/README.md b/tests/README.md
index f107607..ffe7ba2 100644
--- a/tests/README.md
+++ b/tests/README.md
@@ -13,7 +13,14 @@ following images are test:
 - x86-64-efi
 - beagle-bone-black
 
-## Tests
+## Deploy test
+
+After the [LAVA setup](#lava-setup) a test can be deploy with the lavacli tool, e.g.:
+```
+lavacli jobs run tests/jobs/xenomai-qemu-amd64.yml
+```
+
+# Tests
 
 Currently the following tests are executed on each target:
 - lava-smoketest
@@ -27,3 +34,9 @@ and check machine data from the target.
 ### xenomai-test-suite
 
 The xenomai test suite executes the xeno-test tool from xenomai/testsuite.
+
+# LAVA Setup
+
+Setup a lava environment by following the
+[installation guide](https://docs.lavasoftware.org/lava/first-installation.html)
+or use [lava-docker](https://github.com/kernelci/lava-docker).
-- 
2.20.1


