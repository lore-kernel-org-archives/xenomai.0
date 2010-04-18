From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:55 +0200
Message-Id: <44af668cf3431ede8ab56b9e9100ea06bf397f2f.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 14/23] native: Convert the alarm registry
	proc entry to seq_single
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/native/alarm.c |   43 +++++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/ksrc/skins/native/alarm.c b/ksrc/skins/native/alarm.c
index 1130dfb..4ff14a7 100644
--- a/ksrc/skins/native/alarm.c
+++ b/ksrc/skins/native/alarm.c
@@ -45,20 +45,18 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int __alarm_read_proc(char *page,
-			     char **start,
-			     off_t off, int count, int *eof, void *data)
+#include <linux/seq_file.h>
+
+static int alarm_seq_show(struct seq_file *f, void *v)
 {
-	RT_ALARM *alarm = (RT_ALARM *)data;
-	char *p = page;
-	int len;
+	RT_ALARM *alarm = (RT_ALARM *)f->private;
 	spl_t s;
 
 	xnlock_get_irqsave(&nklock, s);
 
-	p += sprintf(p, "interval=%Lu:expiries=%lu\n",
-		     rt_timer_tsc2ns(xntimer_interval(&alarm->timer_base)),
-		     alarm->expiries);
+	seq_printf(f, "interval=%Lu:expiries=%lu\n",
+		   rt_timer_tsc2ns(xntimer_interval(&alarm->timer_base)),
+		   alarm->expiries);
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
 	{
@@ -67,7 +65,7 @@ static int __alarm_read_proc(char *page,
 
 		while (holder) {
 			xnthread_t *sleeper = link2thread(holder, plink);
-			p += sprintf(p, "+%s\n", xnthread_name(sleeper));
+			seq_printf(f, "+%s\n", xnthread_name(sleeper));
 			holder =
 			    nextpq(xnsynch_wait_queue(&alarm->synch_base),
 				   holder);
@@ -77,18 +75,22 @@ static int __alarm_read_proc(char *page,
 
 	xnlock_put_irqrestore(&nklock, s);
 
-	len = (p - page) - off;
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
+	return 0;
+}
 
-	return len;
+static int alarm_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, alarm_seq_show, PDE(inode)->data);
 }
 
+static struct file_operations alarm_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = alarm_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
+
 extern xnptree_t __native_ptree;
 
 static xnpnode_t __alarm_pnode = {
@@ -96,8 +98,9 @@ static xnpnode_t __alarm_pnode = {
 	.dir = NULL,
 	.type = "alarms",
 	.entries = 0,
-	.read_proc = &__alarm_read_proc,
+	.read_proc = NULL,
 	.write_proc = NULL,
+	.fops = &alarm_proc_fops,
 	.root = &__native_ptree,
 };
 
-- 
1.6.0.2


