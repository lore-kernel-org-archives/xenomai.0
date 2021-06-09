From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/xeno-test: Stop systemd-timesyncd across smokey runs
Message-ID: <46f42fa7-be5c-1b0c-4e04-67098423c68f@siemens.com>
Date: Wed, 9 Jun 2021 21:53:24 +0200
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

With dovetail, clock_settime affects the Linux wall clock as well. When
systemd-timesyncd is running, the posix-clock test will fail because its
check of clock settings will immediately be overwritten by timesyncd
again. So stop that service if present and running and restart it after
the test.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/xeno-test/xeno-test.in | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testsuite/xeno-test/xeno-test.in b/testsuite/xeno-test/xeno-test.in
index 505adfd75..95bf59606 100644
--- a/testsuite/xeno-test/xeno-test.in
+++ b/testsuite/xeno-test/xeno-test.in
@@ -82,7 +82,18 @@ echo 0 > /proc/xenomai/latency || :
 
 testdir=@testdir@
 
+timesyncd_running=false
+if which systemctl > /dev/null && systemctl is-active --quiet systemd-timesyncd; then
+    timesyncd_running=true
+    systemctl stop systemd-timesyncd
+fi
+
 $testdir/smokey --run $run_on_vm $keep_going random_alloc_rounds=64 pattern_check_rounds=64
+
+if $timesyncd_running; then
+    systemctl start systemd-timesyncd
+fi
+
 $testdir/clocktest -D -T 30 -C CLOCK_HOST_REALTIME || $testdir/clocktest -T 30
 $testdir/switchtest -T 30
 
-- 
2.26.2

