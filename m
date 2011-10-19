Sender: Thomas De Schampheleire <patrickdepinguin@domain.hid>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <c2a2a1a093ea9baee853.1318861193@domain.hid>
In-Reply-To: <patchbomb.1318861189@domain.hid>
References: <patchbomb.1318861189@domain.hid>
Date: Wed, 19 Oct 2011 09:35:21 +0200
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Subject: [Xenomai-help] [PATCH 4 of 4] psos: fix compiler warning: cprio
 could be used uninitialized
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Assign default 1 to satisfy compiler (tested with gcc 4.4.3)

Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire@domain.hid>
Signed-off-by: Ronny Meeus <ronny.meeus@domain.hid>

---
 lib/psos/task.c |  4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/psos/task.c b/lib/psos/task.c
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -247,7 +247,7 @@ u_long t_create(const char *name, u_long
 	pthread_attr_t thattr;
 	struct syncstate syns;
 	struct service svc;
-	int ret, cprio;
+	int ret, cprio = 1;
 	char short_name[5];
 
 	ret = check_task_priority(prio, &cprio);
@@ -414,7 +414,7 @@ u_long t_resume(u_long tid)
 u_long t_setpri(u_long tid, u_long newprio, u_long *oldprio_r)
 {
 	struct psos_task *task;
-	int ret, cprio;
+	int ret, cprio = 1;
 
 	task = get_psos_task_or_self(tid, &ret);
 	if (task == NULL)



