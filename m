Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4A2681F5.7090904@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 03 Jun 2009 15:59:13 +0200
Message-ID: <20090603135912.22120.24720.stgit@domain.hid>
In-Reply-To: <20090603135912.22120.29245.stgit@domain.hid>
References: <20090603135912.22120.29245.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 1/4] nucleus: Add missing header for
	isspace
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 ksrc/nucleus/intr.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ksrc/nucleus/intr.c b/ksrc/nucleus/intr.c
index 81db8bc..97458f5 100644
--- a/ksrc/nucleus/intr.c
+++ b/ksrc/nucleus/intr.c
@@ -973,6 +973,7 @@ int xnintr_query_next(int irq, xnintr_iterator_t *iterator, char *name_buf)
 #ifdef CONFIG_PROC_FS
 
 #include <linux/proc_fs.h>
+#include <linux/ctype.h>
 
 static int format_irq_proc(unsigned int irq, char *str)
 {


