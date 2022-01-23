From: Konstantin Smola <ksmola51@gmail.com>
Subject: [PATCH 1/1] Added verbosity to 16550A serial driver. dmesg shows the
 ports, irqs, baudbases.
Date: Sun, 23 Jan 2022 00:18:59 -0800
Message-Id: <20220123081859.3266-1-ksmola51@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Konstantin Smola <ksmola51@gmail.com>

kernel/drivers/serial: Added verbosity to 16550A serial driver. dmesg shows the ports, irqs, baudbases.
Signed-off-by: Konstantin Smola <ksmola51@gmail.com>
---
 kernel/drivers/serial/16550A.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.c
index c9274fb19..325737f65 100644
--- a/kernel/drivers/serial/16550A.c
+++ b/kernel/drivers/serial/16550A.c
@@ -31,6 +31,7 @@ MODULE_VERSION("1.5.2");
 MODULE_LICENSE("GPL");
 
 #define RT_16550_DRIVER_NAME	"xeno_16550A"
+static char mod_name[64]=RT_16550_DRIVER_NAME;
 
 #define MAX_DEVICES		8
 
@@ -1128,6 +1129,8 @@ int __init rt_16550_init(void)
 		name = (char *)(dev + 1);
 		ksformat(name, RTDM_MAX_DEVNAME_LEN, dev->label, i);
 
+		rtdm_printk("%s: %s io=0x%x irq=%d baud_base=%d\n", mod_name, name, (unsigned)rt_16550_base_addr(i),irq[i],baud_base[i]);
+
 		err = rt_16550_init_io(i, name);
 		if (err)
 			goto kfree_out;
-- 
2.27.0


