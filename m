From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:16:04 +0200
Message-Id: <b41dbc593c386b7c72e5eece3013f26666f27625.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 23/23] nucleus: Convert timebases proc entry
	to seq_file
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

Admittedly, the proc page cannot overflow right now, but since the number
of time bases is at least in theory unlimited, let's convert the file
while we are at it. Also properly take the nklock when accessing the
nktimebase list.

Signed-off-by: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/timebase.c |   64 +++++++++++++++++++++++++----------------------
 1 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/ksrc/nucleus/timebase.c b/ksrc/nucleus/timebase.c
index 48be711..c3717e9 100644
--- a/ksrc/nucleus/timebase.c
+++ b/ksrc/nucleus/timebase.c
@@ -810,57 +810,61 @@ void xntbase_remove_proc(xntbase_t *base)
 
 #endif /* CONFIG_XENO_OPT_STATS */
 
-static int timebase_read_proc(char *page,
-			      char **start,
-			      off_t off, int count, int *eof, void *data)
+static int timebase_seq_show(struct seq_file *f, void *v)
 {
 	xnholder_t *holder;
 	xntbase_t *tbase;
-	char *p = page;
-	int len = 0;
+	spl_t s;
+
+	seq_printf(f, "%-10s %10s  %10s   %s\n",
+		   "NAME", "RESOLUTION", "JIFFIES", "STATUS");
 
-	p += sprintf(p, "%-10s %10s  %10s   %s\n",
-		     "NAME", "RESOLUTION", "JIFFIES", "STATUS");
+	xnlock_get_irqsave(&nklock, s);
 
 	for (holder = getheadq(&nktimebaseq);
 	     holder != NULL; holder = nextq(&nktimebaseq, holder)) {
 		tbase = link2tbase(holder);
 		if (xntbase_periodic_p(tbase))
-			p += sprintf(p, "%-10s %10lu  %10Lu   %s%s%s\n",
-				     tbase->name,
-				     tbase->tickvalue,
-				     tbase->jiffies,
-				     xntbase_enabled_p(tbase) ? "enabled" : "disabled",
-				     xntbase_timeset_p(tbase) ? ",set" : ",unset",
-				     xntbase_isolated_p(tbase) ? ",isolated" : "");
+			seq_printf(f, "%-10s %10lu  %10Lu   %s%s%s\n",
+				   tbase->name,
+				   tbase->tickvalue,
+				   tbase->jiffies,
+				   xntbase_enabled_p(tbase) ? "enabled" : "disabled",
+				   xntbase_timeset_p(tbase) ? ",set" : ",unset",
+				   xntbase_isolated_p(tbase) ? ",isolated" : "");
 		else
-			p += sprintf(p, "%-10s %10s  %10s   %s\n",
-				     tbase->name,
-				     "1",
-				     "n/a",
-				     "enabled,set");
+			seq_printf(f, "%-10s %10s  %10s   %s\n",
+				   tbase->name,
+				   "1",
+				   "n/a",
+				   "enabled,set");
 	}
 
-	len = p - page - off;
-	if (len <= off + count)
-		*eof = 1;
-	*start = page + off;
-	if (len > count)
-		len = count;
-	if (len < 0)
-		len = 0;
+	xnlock_put_irqrestore(&nklock, s);
+
+	return 0;
+}
 
-	return len;
+static int timebase_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, timebase_seq_show, NULL);
 }
 
+static struct file_operations timebase_proc_fops = {
+        .owner          = THIS_MODULE,
+        .open           = timebase_seq_open,
+        .read           = seq_read,
+        .llseek         = seq_lseek,
+};
+
 void xntbase_init_proc(void)
 {
 #ifdef CONFIG_XENO_OPT_STATS
 	tmstat_proc_root =
 		create_proc_entry("timerstat", S_IFDIR, rthal_proc_root);
 #endif /* CONFIG_XENO_OPT_STATS */
-	rthal_add_proc_leaf("timebases", &timebase_read_proc, NULL, NULL,
-			    rthal_proc_root);
+	rthal_add_proc_seq("timebases", &timebase_proc_fops, 0,
+			  rthal_proc_root);
 }
 
 void xntbase_cleanup_proc(void)
-- 
1.6.0.2


