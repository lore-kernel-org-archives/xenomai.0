From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] cobalt/init: Fail if CPU 0 is missing from real-time CPU mask
Message-ID: <a42b9b34-cda2-d44e-8d48-339ef2aeda2f@siemens.com>
Date: Mon, 5 Jul 2021 12:31:54 +0200
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

The core assumes in some places that CPU 0 is available for real-time.
Therefore fail if the mask is excluding it.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cobalt/init.c b/kernel/cobalt/init.c
index f94943f2d0..5168b56035 100644
--- a/kernel/cobalt/init.c
+++ b/kernel/cobalt/init.c
@@ -202,6 +202,11 @@ static int __init xenomai_init(void)
 		set_realtime_core_state(COBALT_STATE_DISABLED);
 		return 0;
 	}
+	if (!cpumask_test_cpu(0, &xnsched_realtime_cpus)) {
+		printk(XENO_ERR "CPU 0 is missing in real-time CPU mask\n");
+		set_realtime_core_state(COBALT_STATE_DISABLED);
+		return -EINVAL;
+	}
 	cobalt_cpu_affinity = xnsched_realtime_cpus;
 #endif /* CONFIG_SMP */
 
-- 
2.26.2

