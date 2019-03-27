From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 6/8] ipipe: Fix output layout of tracer
Date: Wed, 27 Mar 2019 14:18:05 +0100
Message-Id: <81d998f526596e75bd5cc903f6d24c45d1579093.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1553692686.git.jan.kiszka@siemens.com>
References: <cover.1553692686.git.jan.kiszka@siemens.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Philippe Gerum <rpm@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

A long time ago (probably in 2.6-times), someone converted spaces to
tabs, shuffling the layout around this way, and by forgetting to account
for the multi-domain removal.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/ipipe/tracer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/ipipe/tracer.c b/kernel/ipipe/tracer.c
index 8d58ab143469..2d75199b086b 100644
--- a/kernel/ipipe/tracer.c
+++ b/kernel/ipipe/tracer.c
@@ -842,7 +842,7 @@ __ipipe_print_delay(struct seq_file *m, struct ipipe_trace_point *point)
 {
 	unsigned long delay = 0;
 	int next;
-	char *mark = "	";
+	char *mark = "  ";
 
 	next = WRAP_POINT_NO(point+1 - print_path->point);
 
@@ -916,12 +916,12 @@ static void __ipipe_print_headline(struct seq_file *m)
 			   " +----- Hard IRQs ('|': locked)\n"
 			   " |+-- %s\n"
 			   " ||+- %s%s\n"
-			   " |||			  +---------- "
+		           " |||                        +---------- "
 			       "Delay flag ('+': > %d us, '!': > %d us)\n"
-			   " |||			  |	   +- "
+			   " |||                        |        +- "
 			       "NMI noise ('N')\n"
-			   " |||			  |	   |\n"
-			   "	  Type	  User Val.   Time    Delay  Function "
+			   " |||                        |        |\n"
+			   "    Type    User Val.   Time    Delay  Function "
 			       "(Parent)\n",
 			   name[1], name[0],
 			   " ('*': domain stalled, '+': current, "
@@ -930,9 +930,9 @@ static void __ipipe_print_headline(struct seq_file *m)
 	} else
 		seq_printf(m,
 			   " +--------------- Hard IRQs ('|': locked)\n"
-			   " |		   +- Delay flag "
+			   " |             +- Delay flag "
 			       "('+': > %d us, '!': > %d us)\n"
-			   " |		   |\n"
+			   " |             |\n"
 			   "  Type     Time   Function (Parent)\n",
 			   IPIPE_DELAY_NOTE/1000, IPIPE_DELAY_WARN/1000);
 }
-- 
2.16.4


