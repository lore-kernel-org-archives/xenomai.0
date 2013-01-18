Message-ID: <50F980C1.3050504@siemens.com>
Date: Fri, 18 Jan 2013 18:05:05 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH 2.6] nucleus: Fix migration race in
	schedule_linux_call
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

schedule_linux_call may also be invoked over preemptible, thus
migratable Linux contexts. Therefore we must not read the CPU number
outside the splhigh/splexit section.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ksrc/nucleus/shadow.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 260fdef..c91a6f3 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -820,7 +820,7 @@ static void lostage_handler(void *cookie)
 
 static void schedule_linux_call(int type, struct task_struct *p, int arg)
 {
-	int cpu = rthal_processor_id(), reqnum;
+	int cpu, reqnum;
 	struct __lostagerq *rq;
 	spl_t s;
 
@@ -832,6 +832,7 @@ static void schedule_linux_call(int type, struct task_struct *p, int arg)
 
 	splhigh(s);
 
+	cpu = rthal_processor_id();
 	rq = &lostagerq[cpu];
 	reqnum = rq->in;
 	rq->in = (reqnum + 1) & (LO_MAX_REQUESTS - 1);
-- 
1.7.3.4

