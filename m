From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] alchemy: Fully initialize tcb->self
Message-ID: <f27e1822-6516-0dcd-6b94-2a31df16eb87@siemens.com>
Date: Tue, 19 Nov 2019 17:24:38 +0100
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

Make sure the thread field of tcb->self is always initialized as
rt_task_self returns it.

Reported-by: Mauro Salvini <mauro.salvini@smigroup.net>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/task.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index 079d11b6e7..949a996d00 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -443,10 +443,12 @@ int rt_task_create(RT_TASK *task, const char *name,
 	cta.stacksize = stksize;
 
 	ret = __bt(copperplate_create_thread(&cta, &tcb->thobj.ptid));
-	if (ret)
+	if (ret) {
 		delete_tcb(tcb);
-	else
+	} else {
+		tcb->self.thread = tcb->thobj.ptid;
 		task->thread = tcb->thobj.ptid;
+	}
 out:
 	CANCEL_RESTORE(svc);
 
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

