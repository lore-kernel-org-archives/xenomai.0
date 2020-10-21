From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: [PATCH v2][wip/dovetail] cobalt/intr: post proxy tick irq instead of
 host tick irq
Date: Wed, 21 Oct 2020 02:43:22 +0000
Message-ID: <MWHPR11MB1710DDA2A93EF043BBA274B7F21C0@MWHPR11MB1710.namprd11.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>, "Chen, Hongzhan" <hongzhan.chen@intel.com>

make use of dovetail proxy tick infastructure in place of host
tick

Signed-off-by: hongzha1 <hongzhan.chen@intel.com>

diff --git a/kernel/cobalt/intr.c b/kernel/cobalt/intr.c
index 8ffe7f2b6..20d7ab9eb 100644
--- a/kernel/cobalt/intr.c
+++ b/kernel/cobalt/intr.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 /*#include <linux/ipipe.h>
 #include <linux/ipipe_tickdev.h>*/
+#include <linux/clockchips.h>
 #include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/intr.h>
 #include <cobalt/kernel/stat.h>
@@ -190,6 +191,8 @@ void xnintr_host_tick(struct xnsched *sched) /* Interru=
pts off. */
 #ifdef XNARCH_HOST_TICK_IRQ
        //ipipe_post_irq_root(XNARCH_HOST_TICK_IRQ);
 #warning TODO
+       /* use proxy tick to replace host tick */
+       tick_notify_proxy();
 #endif
 }

@@ -207,6 +210,7 @@ void xnintr_core_clock_handler(void)
 #ifdef XNARCH_HOST_TICK_IRQ
                //ipipe_post_irq_root(XNARCH_HOST_TICK_IRQ);
 #warning TODO
+               tick_notify_proxy();
 #endif
                return;
        }
--
2.17.1

