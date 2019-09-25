From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
Subject: [PATCH] testsuite/xeno-test: add --vm option
Date: Wed, 25 Sep 2019 13:03:29 +0200
Message-Id: <20190925110329.28708-1-Quirin.Gylstorff@siemens.com>
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

If the xeno-test are excuted in a virtual environment the tests fail
due missed timing thresholds. To allow a successful test in a virtual
environment pass the --vm option to smokey.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 testsuite/xeno-test/xeno-test.in | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/testsuite/xeno-test/xeno-test.in b/testsuite/xeno-test/xeno-test.in
index bee0bccc7..505adfd75 100644
--- a/testsuite/xeno-test/xeno-test.in
+++ b/testsuite/xeno-test/xeno-test.in
@@ -24,6 +24,9 @@ If the script is passed the -r option, real-time stress is added to the test,
 with the help of the "switchtest" test. But beware: the latency test figures are
 then no longer meaningful.
 
+For running test in a virtual machine use the --vm option. This option relaxes
+some of the timing thresholds.
+
 Any other option passed on the command line is passed to the latency test.
 
 Example:
@@ -37,6 +40,7 @@ EOF
 }
 
 keep_going=
+run_on_vm=
 rt_load=false
 
 while :; do
@@ -51,6 +55,11 @@ while :; do
 	    shift
 	    ;;
 
+	--vm)
+	    run_on_vm=--vm
+	    shift
+	    ;;
+
 	-r)
 	    rt_load=true
 	    shift
@@ -73,7 +82,7 @@ echo 0 > /proc/xenomai/latency || :
 
 testdir=@testdir@
 
-$testdir/smokey --run $keep_going random_alloc_rounds=64 pattern_check_rounds=64
+$testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=64 pattern_check_rounds=64
 $testdir/clocktest -D -T 30 -C CLOCK_HOST_REALTIME || $testdir/clocktest -T 30
 $testdir/switchtest -T 30
 
-- 
2.20.1


