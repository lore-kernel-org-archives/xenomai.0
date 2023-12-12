Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FBB76DCA
	for <xenomai@lists.linux.dev>; Tue, 12 Dec 2023 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cMc9xVwG"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202312121543069d7cb0fb7ebd03780b
        for <xenomai@lists.linux.dev>;
        Tue, 12 Dec 2023 16:43:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+ljMTItfGNhZEXY85cI60dQPTliaGD2gnLGTL1BoveY=;
 b=cMc9xVwG5vPUA+lqi+YRjX70WS3BXkonyNQXIvk1buMKJ9y87pXYl/ibExeO14r9OI8SQ+
 FNHvkTva3kEdnv5ghPH3ESxQTCsb7Qvbg2rh/CgkWBUlWOBPMJyH3zv0tMLnOL4e61AONOQF
 T5ho+44QoVWxu5ThhkVH/h9TxPgIA=;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
Date: Tue, 12 Dec 2023 16:43:03 +0100
Subject: [PATCH v4] lib/psos/task.c: fix build with gcc >= 12 and -Ofast
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-flo-fix-psos-tests-v4-1-8c694902c07a@siemens.com>
X-B4-Tracking: v=1; b=H4sIAIZ/eGUC/x3NywqDQAyF4VeRrA3UOCD0VUoXc4k1MMzIxIogv
 rvB5X/g45yg3IQV3t0JjXdRqcXC9R3ExZcfoyRroBeNAw2Ec644y4GrVsWNdVNMY/COp0hTcmA
 weGUMzZe4GC3/nG1cGxt7nj7f67oBFmC0KnkAAAA=
To: jan.kiszka@siemens.com, xenomai@lists.linux.dev
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>, 
 Florian Bezdeka <florian.bezdeka@siemens.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

Fix the following build failure with gcc >= 12 and -Ofast (found by
buildroot autobuilders on xenomai 3.0.10 [1]):

task.c: In function 't_start':
task.c:398:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
  398 |         return ret;
      |                ^~~
task.c:364:13: note: 'ret' was declared here
  364 |         int ret;
      |             ^~~
task.c: In function 't_resume':
task.c:444:16: error: 'ret' may be used uninitialized [-Werror=maybe-uninitialized]
  444 |         return ret;
      |                ^~~
task.c:428:13: note: 'ret' was declared here
  428 |         int ret;
      |             ^~~

[1] http://autobuild.buildroot.org/results/bc1b40de22e563b704ad7f20b6bf4d1f73a6ed8a

CC: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---
Difference to v3:
  - Removed caller initializations of err_r
  - find_psos_task() will initialize err_r in any case
---
 lib/psos/task.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/psos/task.c b/lib/psos/task.c
index f678be61d..6d075c19d 100644
--- a/lib/psos/task.c
+++ b/lib/psos/task.c
@@ -62,8 +62,10 @@ static struct psos_task *find_psos_task(u_long tid, int *err_r)
 
 	magic = threadobj_get_magic(&task->thobj);
 
-	if (magic == task_magic)
+	if (magic == task_magic) {
+		*err_r = SUCCESS;
 		return task;
+	}
 
 	if (magic == ~task_magic) {
 		*err_r = ERR_OBJDEL;
@@ -141,6 +143,8 @@ struct psos_task *get_psos_task_or_self(u_long tid, int *err_r)
 		return NULL;
 	}
 
+	*err_r = SUCCESS;
+
 	/* This one might block but can't fail, it is ours. */
 	threadobj_lock(&current->thobj);
 
@@ -447,8 +451,8 @@ out:
 
 u_long t_setpri(u_long tid, u_long newprio, u_long *oldprio_r)
 {
-	int policy, ret = SUCCESS, cprio = 1;
 	struct sched_param_ex param_ex;
+	int policy, ret, cprio = 1;
 	struct psos_task *task;
 	struct service svc;
 
@@ -556,7 +560,7 @@ u_long t_getreg(u_long tid, u_long regnum, u_long *regvalue_r)
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret = SUCCESS;
+	int ret;
 
 	if (regnum >= PSOSTASK_NR_REGS)
 		return ERR_REGNUM;
@@ -579,7 +583,7 @@ u_long t_setreg(u_long tid, u_long regnum, u_long regvalue)
 {
 	struct psos_task *task;
 	struct service svc;
-	int ret = SUCCESS;
+	int ret;
 
 	if (regnum >= PSOSTASK_NR_REGS)
 		return ERR_REGNUM;
@@ -601,9 +605,9 @@ out:
 u_long t_mode(u_long mask, u_long newmask, u_long *oldmode_r)
 {
 	struct sched_param_ex param_ex;
-	int policy, ret = SUCCESS;
 	struct psos_task *task;
 	struct service svc;
+	int policy, ret;
 
 	CANCEL_DEFER(svc);
 

---
base-commit: ed69c34214f9fcf57b459e701ed4f65f6753bb8c
change-id: 20231212-flo-fix-psos-tests-d3ba4e7c27d4

Best regards,
-- 
Florian Bezdeka <florian.bezdeka@siemens.com>

