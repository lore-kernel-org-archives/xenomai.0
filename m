From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sun, 18 Apr 2010 16:15:48 +0200
Message-Id: <0a27df5d2fcbd23a15f4ffbc0c233a4536c727b6.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
In-Reply-To: <cover.1271600150.git.jan.kiszka@domain.hid>
References: <cover.1271600150.git.jan.kiszka@domain.hid>
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 07/23] RTDM: Extend device name space in
	open_fildes proc output
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@domain.hid>

Device names can be up to 31 characters long.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/skins/rtdm/proc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ksrc/skins/rtdm/proc.c b/ksrc/skins/rtdm/proc.c
index e83c0c4..20c9ad8 100644
--- a/ksrc/skins/rtdm/proc.c
+++ b/ksrc/skins/rtdm/proc.c
@@ -146,7 +146,7 @@ static int open_fildes_seq_show(struct seq_file *seq, void *v)
 	spl_t s;
 
 	if (v == SEQ_START_TOKEN) {
-		seq_printf(seq, "Index\tLocked\tDevice\t\tOwner [PID]\n");
+		seq_printf(seq, "Index\tLocked\tDevice\t\t\t\tOwner [PID]\n");
 		return 0;
 	}
 
@@ -173,7 +173,7 @@ static int open_fildes_seq_show(struct seq_file *seq, void *v)
 
 	xnlock_put_irqrestore(&rt_fildes_lock, s);
 
-	seq_printf(seq, "%d\t%d\t%-15s %s [%d]\n",
+	seq_printf(seq, "%d\t%d\t%-31s %s [%d]\n",
 		   (int)(fildes - fildes_table), close_lock_count,
 		   (device->device_flags & RTDM_NAMED_DEVICE) ?
 				device->device_name : device->proc_name,
-- 
1.6.0.2


