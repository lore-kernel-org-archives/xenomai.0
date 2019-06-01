From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 4/8] testsuite/smokey: sched-quota: allow up to 1.5% deviation
 from plan
Date: Sat,  1 Jun 2019 17:14:58 +0200
Message-Id: <20190601151502.27216-5-rpm@xenomai.org>
In-Reply-To: <20190601151502.27216-1-rpm@xenomai.org>
References: <20190601151502.27216-1-rpm@xenomai.org>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

[+/-]0.5% is too strict on some architectures (e.g. x86) where the
test run may crunch numbers faster than the calibration did. 1.5% is a
probabilistic attempt to cope with this variation while remaining
within acceptable bounds.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/smokey/sched-quota/sched-quota.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/sched-quota/sched-quota.c b/testsuite/smokey/sched-quota/sched-quota.c
index 10ecfad44..5c35b551d 100644
--- a/testsuite/smokey/sched-quota/sched-quota.c
+++ b/testsuite/smokey/sched-quota/sched-quota.c
@@ -327,7 +327,7 @@ static int run_sched_quota(struct smokey_test *t, int argc, char *const argv[])
 	smokey_trace("%d thread%s: cap=%d%%, effective=%.1f%%",
 		     nrthreads, nrthreads > 1 ? "s": "", quota, effective);
 
-	if (!smokey_on_vm && fabs(effective - (double)quota) > 0.5) {
+	if (!smokey_on_vm && fabs(effective - (double)quota) > 1.5) {
 		smokey_warning("out of quota: %.1f%%",
 			       effective - (double)quota);
 		return -EPROTO;
-- 
2.20.1


