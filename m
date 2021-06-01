From: Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 1/9] y2038: libcobalt: Centralize sc_cobalt_clock_gettime
 syscall
Date: Tue,  1 Jun 2021 11:43:26 +0200
Message-Id: <20210601094334.774394-2-florian.bezdeka@siemens.com>
In-Reply-To: <20210601094334.774394-1-florian.bezdeka@siemens.com>
References: <20210601094334.774394-1-florian.bezdeka@siemens.com>
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
Cc: jan.kiszka@siemens.com, chensong@tj.kylinos.cn, Florian Bezdeka <florian.bezdeka@siemens.com>

There were two places invoking the sc_cobalt_clock_gettime syscalls
and both places would be updated while introducing y2038 support. To
keep y2038 compatibility as simple as possible the code has been moved
into a simple helper function.

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
 lib/cobalt/clock.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/clock.c b/lib/cobalt/clock.c
index a0673d1fc..3f87278ce 100644
--- a/lib/cobalt/clock.c
+++ b/lib/cobalt/clock.c
@@ -149,6 +149,11 @@ static int __do_clock_host_realtime(struct timespec *ts)
 	return 0;
 }
 
+static int __do_clock_gettime(clockid_t clock_id, struct timespec *tp)
+{
+	return -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+}
+
 static int gettime_via_tsc(clockid_t clock_id, struct timespec *tp)
 {
 	unsigned long rem;
@@ -172,7 +177,7 @@ static int gettime_via_tsc(clockid_t clock_id, struct timespec *tp)
 		tp->tv_nsec = rem;
 		return 0;
 	default:
-		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+		ret = __do_clock_gettime(clock_id, tp);
 	}
 
 	if (ret) {
@@ -197,7 +202,7 @@ static int gettime_via_vdso(clockid_t clock_id, struct timespec *tp)
 		ret = __cobalt_vdso_gettime(clock_id, tp);
 		break;
 	default:
-		ret = -XENOMAI_SYSCALL2(sc_cobalt_clock_gettime, clock_id, tp);
+		ret = __do_clock_gettime(clock_id, tp);
 	}
 
 	if (ret) {
-- 
2.31.1


