From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH] testsuite/xeno-test: Restore timesyncd running state on
 smokey failure
Date: Thu, 21 Oct 2021 13:55:08 +0200
Message-Id: <20211021115508.36110-1-florian.bezdeka@siemens.com>
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

We stop systemd-timesyncd before running the smokey testsuite and start
it again once the smokey tests are complete. As xeno-test has a "set -e"
we will stop the execution on the first error. So if smokey reports an
error systemd-timesyncd is not started again. We don't properly restore
the system state in this case.

Install a bash trap to make sure that we restart the service in all
cases if it was running on script entry.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 testsuite/xeno-test/xeno-test.in | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/testsuite/xeno-test/xeno-test.in b/testsuite/xeno-test/xeno-test.in
index 95bf59606..cfa28df18 100644
--- a/testsuite/xeno-test/xeno-test.in
+++ b/testsuite/xeno-test/xeno-test.in
@@ -39,9 +39,19 @@ timer irq latency.
 EOF
 }
 
+start_timesyncd()
+{
+    if $timesyncd_was_running; then
+        systemctl start systemd-timesyncd
+        timesyncd_was_running=false
+    fi
+}
+trap start_timesyncd EXIT
+
 keep_going=
 run_on_vm=
 rt_load=false
+timesyncd_was_running=false
 
 while :; do
     case "$1" in
@@ -82,17 +92,14 @@ echo 0 > /proc/xenomai/latency || :
 
 testdir=@testdir@
 
-timesyncd_running=false
 if which systemctl > /dev/null && systemctl is-active --quiet systemd-timesyncd; then
-    timesyncd_running=true
+    timesyncd_was_running=true
     systemctl stop systemd-timesyncd
 fi
 
 $testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=64 pattern_check_rounds=64
 
-if $timesyncd_running; then
-    systemctl start systemd-timesyncd
-fi
+start_timesyncd
 
 $testdir/clocktest -D -T 30 -C CLOCK_HOST_REALTIME || $testdir/clocktest -T 30
 $testdir/switchtest -T 30
-- 
2.31.1


