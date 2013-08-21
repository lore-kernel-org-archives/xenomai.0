Message-ID: <5214D9B9.9000106@siemens.com>
Date: Wed, 21 Aug 2013 17:16:09 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] rtcan: Update procfs usage to latest kernel API
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Wolfgang Grandegger <wg@grandegger.com>

This both overcomes RTCAN_PROC_* macros and makes the CAN layer
compatible with kernel 3.10. We simply switch all procfs nodes to
seq_file.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

For review. This is part of my for-upstream queue. Note that I only
tested with virtual CAN, build-tested sja1000 and couldn't test MSCAN.

 include/asm-generic/wrappers.h                |   13 ++
 ksrc/drivers/can/mscan/rtcan_mscan_proc.c     |  147 +++++++-------
 ksrc/drivers/can/rtcan_internal.h             |   62 ------
 ksrc/drivers/can/rtcan_module.c               |  266 ++++++++++++-------------
 ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c |   48 ++---
 5 files changed, 233 insertions(+), 303 deletions(-)

diff --git a/include/asm-generic/wrappers.h b/include/asm-generic/wrappers.h
index 0a4b45b..9108cbd 100644
--- a/include/asm-generic/wrappers.h
+++ b/include/asm-generic/wrappers.h
@@ -784,6 +784,19 @@ proc_create_data(const char *name, mode_t mode, struct proc_dir_entry *parent,
 	return pde;
 }
 #endif /* < 2.6.26 */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,25)
+static inline struct proc_dir_entry *
+proc_create(const char *name, mode_t mode, struct proc_dir_entry *parent,
+	    const struct file_operations *proc_fops)
+{
+	struct proc_dir_entry *pde = create_proc_entry(name, mode, parent);
+
+	if (pde)
+		pde->proc_fops = proc_fops;
+	return pde;
+}
+#endif /* < 2.6.25 */
 #endif /* < 3.10 */
 
 #endif /* _XENO_ASM_GENERIC_WRAPPERS_H */
diff --git a/ksrc/drivers/can/mscan/rtcan_mscan_proc.c b/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
index 69f77a2..c5aad74 100644
--- a/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
+++ b/ksrc/drivers/can/mscan/rtcan_mscan_proc.c
@@ -33,8 +33,7 @@
 
 #ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
 
-static int rtcan_mscan_proc_regs(char *buf, char **start, off_t offset,
-				 int count, int *eof, void *data)
+static int rtcan_mscan_proc_regs(struct seq_file *p, void *data)
 {
 	struct rtcan_device *dev = (struct rtcan_device *)data;
 	struct mscan_regs *regs = (struct mscan_regs *)dev->base_addr;
@@ -43,98 +42,94 @@ static int rtcan_mscan_proc_regs(char *buf, char **start, off_t offset,
 	u32 port_config;
 #endif
 	u8 canctl0, canctl1;
-	RTCAN_PROC_PRINT_VARS(80);
 
-	if (!RTCAN_PROC_PRINT("MSCAN registers at %p\n", regs))
-		goto done;
+	seq_printf(p, "MSCAN registers at %p\n", regs);
+
 	canctl0 = in_8(&regs->canctl0);
-	if (!RTCAN_PROC_PRINT("canctl0  0x%02x%s%s%s%s%s%s%s%s\n",
-			      canctl0,
-			      (canctl0 & MSCAN_RXFRM) ? " rxfrm" :"",
-			      (canctl0 & MSCAN_RXACT) ? " rxact" :"",
-			      (canctl0 & MSCAN_CSWAI) ? " cswai" :"",
-			      (canctl0 & MSCAN_SYNCH) ? " synch" :"",
-			      (canctl0 & MSCAN_TIME)  ? " time"  :"",
-			      (canctl0 & MSCAN_WUPE)  ? " wupe"  :"",
-			      (canctl0 & MSCAN_SLPRQ) ? " slprq" :"",
-			      (canctl0 & MSCAN_INITRQ)? " initrq":"" ))
-		goto done;
+	seq_printf(p, "canctl0  0x%02x%s%s%s%s%s%s%s%s\n",
+		   canctl0,
+		   (canctl0 & MSCAN_RXFRM) ? " rxfrm" :"",
+		   (canctl0 & MSCAN_RXACT) ? " rxact" :"",
+		   (canctl0 & MSCAN_CSWAI) ? " cswai" :"",
+		   (canctl0 & MSCAN_SYNCH) ? " synch" :"",
+		   (canctl0 & MSCAN_TIME)  ? " time"  :"",
+		   (canctl0 & MSCAN_WUPE)  ? " wupe"  :"",
+		   (canctl0 & MSCAN_SLPRQ) ? " slprq" :"",
+		   (canctl0 & MSCAN_INITRQ)? " initrq":"" );
 	canctl1 = in_8(&regs->canctl1);
-	if (!RTCAN_PROC_PRINT("canctl1  0x%02x%s%s%s%s%s%s%s\n",
-			       canctl1,
-			      (canctl1 & MSCAN_CANE)  ? " cane"  :"",
-			      (canctl1 & MSCAN_CLKSRC)? " clksrc":"",
-			      (canctl1 & MSCAN_LOOPB) ? " loopb" :"",
-			      (canctl1 & MSCAN_LISTEN)? " listen":"",
-			      (canctl1 & MSCAN_WUPM)  ? " wump"  :"",
-			      (canctl1 & MSCAN_SLPAK) ? " slpak" :"",
-			      (canctl1 & MSCAN_INITAK)? " initak":""))
-		goto done;
-	if (!RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr0 )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canbtr1 )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrflg )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrier )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantflg )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantier )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantarq )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantaak )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantbsel)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidac )) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canrxerr)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(cantxerr)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar0)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar1)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar2)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar3)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr0)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr1)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr2)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr3)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar4)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar5)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar6)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidar7)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr4)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr5)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr6)) |
-	    !RTCAN_PROC_PRINT(MSCAN_REG_ARGS(canidmr7)))
-		goto done;
+	seq_printf(p, "canctl1  0x%02x%s%s%s%s%s%s%s\n",
+		   canctl1,
+		   (canctl1 & MSCAN_CANE)  ? " cane"  :"",
+		   (canctl1 & MSCAN_CLKSRC)? " clksrc":"",
+		   (canctl1 & MSCAN_LOOPB) ? " loopb" :"",
+		   (canctl1 & MSCAN_LISTEN)? " listen":"",
+		   (canctl1 & MSCAN_WUPM)  ? " wump"  :"",
+		   (canctl1 & MSCAN_SLPAK) ? " slpak" :"",
+		   (canctl1 & MSCAN_INITAK)? " initak":"");
+	seq_printf(p, MSCAN_REG_ARGS(canbtr0 ));
+	seq_printf(p, MSCAN_REG_ARGS(canbtr1 ));
+	seq_printf(p, MSCAN_REG_ARGS(canrflg ));
+	seq_printf(p, MSCAN_REG_ARGS(canrier ));
+	seq_printf(p, MSCAN_REG_ARGS(cantflg ));
+	seq_printf(p, MSCAN_REG_ARGS(cantier ));
+	seq_printf(p, MSCAN_REG_ARGS(cantarq ));
+	seq_printf(p, MSCAN_REG_ARGS(cantaak ));
+	seq_printf(p, MSCAN_REG_ARGS(cantbsel));
+	seq_printf(p, MSCAN_REG_ARGS(canidac ));
+	seq_printf(p, MSCAN_REG_ARGS(canrxerr));
+	seq_printf(p, MSCAN_REG_ARGS(cantxerr));
+	seq_printf(p, MSCAN_REG_ARGS(canidar0));
+	seq_printf(p, MSCAN_REG_ARGS(canidar1));
+	seq_printf(p, MSCAN_REG_ARGS(canidar2));
+	seq_printf(p, MSCAN_REG_ARGS(canidar3));
+	seq_printf(p, MSCAN_REG_ARGS(canidmr0));
+	seq_printf(p, MSCAN_REG_ARGS(canidmr1));
+	seq_printf(p, MSCAN_REG_ARGS(canidmr2));
+	seq_printf(p, MSCAN_REG_ARGS(canidmr3));
+	seq_printf(p, MSCAN_REG_ARGS(canidar4));
+	seq_printf(p, MSCAN_REG_ARGS(canidar5));
+	seq_printf(p, MSCAN_REG_ARGS(canidar6));
+	seq_printf(p, MSCAN_REG_ARGS(canidar7));
+	seq_printf(p, MSCAN_REG_ARGS(canidmr4));
+	seq_printf(p, MSCAN_REG_ARGS(canidmr5));
+	seq_printf(p, MSCAN_REG_ARGS(canidmr6));
+	seq_printf(p, MSCAN_REG_ARGS(canidmr7));
 
 #ifdef MPC5xxx_GPIO
-	if (!RTCAN_PROC_PRINT("GPIO registers\n"))
-		goto done;
+	seq_printf(p, "GPIO registers\n");
 	port_config = in_be32(&gpio->port_config);
-	if (!RTCAN_PROC_PRINT("port_config 0x%08x %s\n", port_config,
-			      (port_config & 0x10000000 ?
-			       "CAN1 on I2C1, CAN2 on TMR0/1 pins":
-			       (port_config & 0x70) == 0x10 ?
-			       "CAN1/2 on PSC2 pins": "MSCAN1/2 not routed")))
-		goto done;
+	seq_printf(p, "port_config 0x%08x %s\n", port_config,
+		   (port_config & 0x10000000 ?
+			"CAN1 on I2C1, CAN2 on TMR0/1 pins" :
+			(port_config & 0x70) == 0x10 ?
+				"CAN1/2 on PSC2 pins" :
+				"MSCAN1/2 not routed"));
 #endif
 
 done:
 	RTCAN_PROC_PRINT_DONE;
 }
 
-int rtcan_mscan_create_proc(struct rtcan_device* dev)
+static int rtcan_mscan_proc_regs_open(struct inode *inode, struct file *file)
 {
-	struct proc_dir_entry *proc_entry;
+	return single_open(file, rtcan_mscan_proc_regs, PDE_DATA(inode));
+}
+
+static const struct file_operations rtcan_mscan_proc_regs_ops = {
+	.open		= rtcan_mscan_proc_regs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 
+int rtcan_mscan_create_proc(struct rtcan_device* dev)
+{
 	if (!dev->proc_root)
 		return -EINVAL;
 
-	proc_entry = create_proc_entry("registers", S_IFREG | S_IRUGO | S_IWUSR,
-				       dev->proc_root);
-	if (!proc_entry)
-		goto error;
-	proc_entry->read_proc = rtcan_mscan_proc_regs;
-	proc_entry->data = dev;
-
+	proc_create_data("registers", S_IFREG | S_IRUGO | S_IWUSR,
+			 dev->proc_root, &rtcan_mscan_proc_regs_ops, dev);
 	return 0;
-
-error:
-	printk("%s: unable to create /proc entries for MSCAN\n", dev->name);
-	return -1;
 }
 
 void rtcan_mscan_remove_proc(struct rtcan_device* dev)
diff --git a/ksrc/drivers/can/rtcan_internal.h b/ksrc/drivers/can/rtcan_internal.h
index 35b778a..5b87956 100644
--- a/ksrc/drivers/can/rtcan_internal.h
+++ b/ksrc/drivers/can/rtcan_internal.h
@@ -45,68 +45,6 @@
 #define RTCAN_ASSERT(expr, func)
 #endif /* CONFIG_RTCAN_CHECKED */
 
-#ifdef CONFIG_PROC_FS
-#include <linux/proc_fs.h>
-
-/* Derived from Erwin Rol's rtai_proc_fs.h.
-   Standard version assumes that output fits into the provided buffer,
-   extended version also deals with potential fragmentation. */
-
-#define RTCAN_PROC_PRINT_VARS(MAX_BLOCK_LEN)                            \
-    const int max_block_len = MAX_BLOCK_LEN;                            \
-    off_t __limit           = count - MAX_BLOCK_LEN;                    \
-    int   __len             = 0;                                        \
-									\
-    *eof = 1;                                                           \
-    if (count < MAX_BLOCK_LEN)                                          \
-	return 0
-
-#define RTCAN_PROC_PRINT(fmt, args...)                                  \
-    ({                                                                  \
-	__len += snprintf(buf + __len, max_block_len, fmt, ##args);     \
-	(__len <= __limit);                                             \
-    })
-
-#define RTCAN_PROC_PRINT_DONE                                           \
-    return __len
-
-
-#define RTCAN_PROC_PRINT_VARS_EX(MAX_BLOCK_LEN)                         \
-    const int max_block_len = MAX_BLOCK_LEN;                            \
-    off_t __limit           = offset + count - MAX_BLOCK_LEN;           \
-    off_t __pos             = 0;                                        \
-    off_t __begin           = 0;                                        \
-    int   __len             = 0;                                        \
-									\
-    *eof = 1;                                                           \
-    if (count < MAX_BLOCK_LEN)                                          \
-	return 0
-
-#define RTCAN_PROC_PRINT_EX(fmt, args...)                               \
-    ({                                                                  \
-	int len = snprintf(buf + __len, max_block_len, fmt, ##args);    \
-	__len += len;                                                   \
-	__pos += len;                                                   \
-	if (__pos < offset) {                                           \
-	    __len = 0;                                                  \
-	    __begin = __pos;                                            \
-	}                                                               \
-	if (__pos > __limit)                                            \
-	    *eof = 0;                                                   \
-	(__pos <= __limit);                                             \
-    })
-
-#define RTCAN_PROC_PRINT_DONE_EX                                        \
-    *start = buf + (offset - __begin);                                  \
-    __len -= (offset - __begin);                                        \
-    if (__len > count)                                                  \
-	__len = count;                                                  \
-    if (__len < 0)                                                      \
-	__len = 0;                                                      \
-    return __len;
-
-#endif /* CONFIG_PROC_FS */
-
 #ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
 # define RTCAN_DBG(fmt,args...) do { printk(fmt ,##args); } while (0)
 # define RTCAN_RTDM_DBG(fmt,args...) do { rtdm_printk(fmt ,##args); } while (0)
diff --git a/ksrc/drivers/can/rtcan_module.c b/ksrc/drivers/can/rtcan_module.c
index 6301f63..2b25088 100644
--- a/ksrc/drivers/can/rtcan_module.c
+++ b/ksrc/drivers/can/rtcan_module.c
@@ -119,13 +119,11 @@ static void rtcan_get_timeout_name(nanosecs_rel_t timeout,
 	snprintf(name, max_len, "%lld", (long long)timeout);
 }
 
-static int rtcan_read_proc_devices(char *buf, char **start, off_t offset,
-				   int count, int *eof, void *data)
+static int rtcan_read_proc_devices(struct seq_file *p, void *data)
 {
-    int i, ret;
+    int i;
     struct rtcan_device *dev;
     char state_name[20], baudrate_name[20];
-    RTCAN_PROC_PRINT_VARS(80);
 
     if (down_interruptible(&rtcan_devices_nrt_lock))
 	return -ERESTARTSYS;
@@ -135,9 +133,8 @@ static int rtcan_read_proc_devices(char *buf, char **start, off_t offset,
      * rtcan1          undefined warning  1234567890 1234567890 1234567890
      * rtcan2          undefined scanning 1234567890 1234567890 1234567890
      */
-    if (!RTCAN_PROC_PRINT("Name___________ _Baudrate State___ "
-			  "TX_Counter RX_Counter ____Errors\n"))
-	goto done;
+    seq_printf(p, "Name___________ _Baudrate State___ TX_Counter RX_Counter "
+		  "____Errors\n");
 
     for (i = 1; i <= RTCAN_MAX_DEVICES; i++) {
 	if ((dev = rtcan_dev_get_by_index(i)) != NULL) {
@@ -145,23 +142,31 @@ static int rtcan_read_proc_devices(char *buf, char **start, off_t offset,
 				     state_name, sizeof(state_name));
 	    rtcan_dev_get_baudrate_name(dev->baudrate,
 					baudrate_name, sizeof(baudrate_name));
-	    ret = RTCAN_PROC_PRINT("%-15s %9s %-8s %10d %10d %10d\n",
-				   dev->name, baudrate_name, state_name,
-				   dev->tx_count, dev->rx_count, dev->err_count);
+	    seq_printf(p, "%-15s %9s %-8s %10d %10d %10d\n",
+		       dev->name, baudrate_name, state_name, dev->tx_count,
+		       dev->rx_count, dev->err_count);
 	    rtcan_dev_dereference(dev);
-	    if (!ret)
-		break;
 	}
     }
 
-  done:
     up(&rtcan_devices_nrt_lock);
-    RTCAN_PROC_PRINT_DONE;
+
+    return 0;
 }
 
+static int rtcan_proc_devices_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtcan_read_proc_devices, NULL);
+}
 
-static int rtcan_read_proc_sockets(char *buf, char **start, off_t offset,
-				   int count, int *eof, void *data)
+static const struct file_operations rtcan_proc_devices_ops = {
+	.open		= rtcan_proc_devices_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int rtcan_read_proc_sockets(struct seq_file *p, void *data)
 {
     struct rtcan_socket *sock;
     struct rtdm_dev_context *context;
@@ -170,7 +175,6 @@ static int rtcan_read_proc_sockets(char *buf, char **start, off_t offset,
     char rx_timeout[20], tx_timeout[20];
     rtdm_lockctx_t lock_ctx;
     int ifindex;
-    RTCAN_PROC_PRINT_VARS(120);
 
     if (down_interruptible(&rtcan_devices_nrt_lock))
 	return -ERESTARTSYS;
@@ -178,9 +182,8 @@ static int rtcan_read_proc_sockets(char *buf, char **start, off_t offset,
     /* fd Name___________ Filter ErrMask RX_Timeout TX_Timeout RX_BufFull TX_Lo
      *  0 rtcan0               1 0x00010 1234567890 1234567890 1234567890 12345
      */
-    if (!RTCAN_PROC_PRINT("fd Name___________ Filter ErrMask RX_Timeout_ns "
-			  "TX_Timeout_ns RX_BufFull TX_Lo\n"))
-	goto done;
+    seq_printf(p, "fd Name___________ Filter ErrMask RX_Timeout_ns "
+		  "TX_Timeout_ns RX_BufFull TX_Lo\n");
 
     rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
 
@@ -201,29 +204,37 @@ static int rtcan_read_proc_sockets(char *buf, char **start, off_t offset,
 			       tx_timeout, sizeof(tx_timeout));
 	rtcan_get_timeout_name(sock->rx_timeout,
 			       rx_timeout, sizeof(rx_timeout));
-	if (!RTCAN_PROC_PRINT("%2d %-15s %6d 0x%05x %13s %13s %10d %5d\n",
-			      context->fd, name, sock->flistlen,
-			      sock->err_mask, rx_timeout, tx_timeout,
-			      sock->rx_buf_full,
-			      rtcan_loopback_enabled(sock)))
-	    break;
+	seq_printf(p, "%2d %-15s %6d 0x%05x %13s %13s %10d %5d\n",
+		   context->fd, name, sock->flistlen, sock->err_mask,
+		   rx_timeout, tx_timeout, sock->rx_buf_full,
+		   rtcan_loopback_enabled(sock));
     }
 
     rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
 
-  done:
     up(&rtcan_devices_nrt_lock);
-    RTCAN_PROC_PRINT_DONE;
+
+    return 0;
+}
+
+static int rtcan_proc_sockets_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtcan_read_proc_sockets, NULL);
 }
 
+static const struct file_operations rtcan_proc_sockets_ops = {
+	.open		= rtcan_proc_sockets_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 
-static int rtcan_read_proc_info(char *buf, char **start, off_t offset,
-				int count, int *eof, void *data)
+static int rtcan_read_proc_info(struct seq_file *p, void *data)
 {
-    struct rtcan_device *dev = (struct rtcan_device *)data;
+    struct rtcan_device *dev = p->private;
     char state_name[20], baudrate_name[20];
     char ctrlmode_name[80], bittime_name[80];
-    RTCAN_PROC_PRINT_VARS(80);
 
     if (down_interruptible(&rtcan_devices_nrt_lock))
 	return -ERESTARTSYS;
@@ -237,46 +248,52 @@ static int rtcan_read_proc_info(char *buf, char **start, off_t offset,
     rtcan_dev_get_bittime_name(&dev->bit_time,
 			       bittime_name, sizeof(bittime_name));
 
-    if (!RTCAN_PROC_PRINT("%s %s\n", "Device    ", dev->name) ||
-	!RTCAN_PROC_PRINT("%s %s\n", "Controller", dev->ctrl_name) ||
-	!RTCAN_PROC_PRINT("%s %s\n", "Board     ", dev->board_name) ||
-	!RTCAN_PROC_PRINT("%s %d\n", "Clock-Hz  ", dev->can_sys_clock) ||
-	!RTCAN_PROC_PRINT("%s %s\n", "Baudrate  ", baudrate_name) ||
-	!RTCAN_PROC_PRINT("%s %s\n", "Bit-time  ", bittime_name) ||
-	!RTCAN_PROC_PRINT("%s %s\n", "Ctrl-Mode ", ctrlmode_name) ||
-	!RTCAN_PROC_PRINT("%s %s\n", "State     ", state_name) ||
-	!RTCAN_PROC_PRINT("%s %d\n", "TX-Counter", dev->tx_count) ||
-	!RTCAN_PROC_PRINT("%s %d\n", "RX-Counter", dev->rx_count) ||
-	!RTCAN_PROC_PRINT("%s %d\n", "Errors    ", dev->err_count))
-	goto done;
-
+    seq_printf(p, "Device     %s", dev->name);
+    seq_printf(p, "Controller %s", dev->ctrl_name);
+    seq_printf(p, "Board      %s", dev->board_name);
+    seq_printf(p, "Clock-Hz   %d", dev->can_sys_clock);
+    seq_printf(p, "Baudrate   %s", baudrate_name);
+    seq_printf(p, "Bit-time   %s", bittime_name);
+    seq_printf(p, "Ctrl-Mode  %s", ctrlmode_name);
+    seq_printf(p, "State      %s", state_name);
+    seq_printf(p, "TX-Counter %d", dev->tx_count);
+    seq_printf(p, "RX-Counter %d", dev->rx_count);
+    seq_printf(p, "Errors     %d", dev->err_count);
 #ifdef RTCAN_USE_REFCOUNT
-    if (!RTCAN_PROC_PRINT("%s %d\n", "Refcount  ", atomic_read(&dev->refcount)))
-	goto done;
+    seq_printf(p, "Refcount   %d", atomic_read(&dev->refcount));
 #endif
 
-  done:
     up(&rtcan_devices_nrt_lock);
-    RTCAN_PROC_PRINT_DONE;
+
+    return 0;
+}
+
+static int rtcan_proc_info_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtcan_read_proc_info, PDE_DATA(inode));
 }
 
+static const struct file_operations rtcan_proc_info_ops = {
+	.open		= rtcan_proc_info_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 
 
-static int rtcan_read_proc_filter(char *buf, char **start, off_t offset,
-				  int count, int *eof, void *data)
+static int rtcan_read_proc_filter(struct seq_file *p, void *data)
 {
-    struct rtcan_device *dev = (struct rtcan_device *)data;
+    struct rtcan_device *dev = p->private;
     struct rtcan_recv *recv_listener = dev->recv_list;
     struct rtdm_dev_context *context;
     rtdm_lockctx_t lock_ctx;
-    RTCAN_PROC_PRINT_VARS(80);
 
     /*  fd __CAN_ID__ _CAN_Mask_ Inv MatchCount
      *   3 0x12345678 0x12345678  no 1234567890
      */
 
-    if (!RTCAN_PROC_PRINT("fd __CAN_ID__ _CAN_Mask_ Inv MatchCount\n"))
-	goto done;
+    seq_printf(p, "fd __CAN_ID__ _CAN_Mask_ Inv MatchCount\n");
 
     rtdm_lock_get_irqsave(&rtcan_recv_list_lock, lock_ctx);
 
@@ -284,38 +301,57 @@ static int rtcan_read_proc_filter(char *buf, char **start, off_t offset,
     while (recv_listener != NULL) {
 	context = rtcan_socket_context(recv_listener->sock);
 
-	if (!RTCAN_PROC_PRINT("%2d 0x%08x 0x%08x %s %10d\n",
-			      context->fd,
-			      recv_listener->can_filter.can_id,
-			      recv_listener->can_filter.can_mask &
-			      ~CAN_INV_FILTER,
-			      (recv_listener->can_filter.can_mask &
-			       CAN_INV_FILTER) ? "yes" : " no",
-			      recv_listener->match_count))
-	    break;
+	seq_printf(p, "%2d 0x%08x 0x%08x %s %10d\n",
+		   context->fd,
+		   recv_listener->can_filter.can_id,
+		   recv_listener->can_filter.can_mask & ~CAN_INV_FILTER,
+		   (recv_listener->can_filter.can_mask & CAN_INV_FILTER) ?
+			"yes" : " no",
+		   recv_listener->match_count);
+
 	recv_listener = recv_listener->next;
     }
 
     rtdm_lock_put_irqrestore(&rtcan_recv_list_lock, lock_ctx);
 
-  done:
-    RTCAN_PROC_PRINT_DONE;
+    return 0;
 }
 
+static int rtcan_proc_filter_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtcan_read_proc_filter, PDE_DATA(inode));
+}
+
+static const struct file_operations rtcan_proc_filter_ops = {
+	.open		= rtcan_proc_filter_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 
 
-static int rtcan_read_proc_version(char *buf, char **start, off_t offset,
-				   int count, int *eof, void *data)
+static int rtcan_read_proc_version(struct seq_file *p, void *data)
 {
-    RTCAN_PROC_PRINT_VARS(80);
+	seq_printf(p, "RT-Socket-CAN %d.%d.%d - built on %s %s\n",
+		   RTCAN_MAJOR_VER, RTCAN_MINOR_VER, RTCAN_BUGFIX_VER,
+		   __DATE__, __TIME__);
 
-    RTCAN_PROC_PRINT("RT-Socket-CAN %d.%d.%d - built on %s %s\n",
-		     RTCAN_MAJOR_VER, RTCAN_MINOR_VER, RTCAN_BUGFIX_VER,
-		     __DATE__, __TIME__);
+	return 0;
+}
 
-    RTCAN_PROC_PRINT_DONE;
+static int rtcan_proc_version_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtcan_read_proc_version, NULL);
 }
 
+static const struct file_operations rtcan_proc_version_ops = {
+	.open		= rtcan_proc_version_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 
 void rtcan_dev_remove_proc(struct rtcan_device* dev)
 {
@@ -331,82 +367,39 @@ void rtcan_dev_remove_proc(struct rtcan_device* dev)
 
 int rtcan_dev_create_proc(struct rtcan_device* dev)
 {
-    struct proc_dir_entry *proc_entry;
-
     if (!rtcan_proc_root)
 	return -EINVAL;
 
-    dev->proc_root = create_proc_entry(dev->name, S_IFDIR, rtcan_proc_root);
-    if (!dev->proc_root)
-	goto error1;
-
-    proc_entry = create_proc_entry("info", S_IFREG | S_IRUGO | S_IWUSR,
-				   dev->proc_root);
-    if (!proc_entry)
-	goto error2;
-    proc_entry->read_proc = rtcan_read_proc_info;
-    proc_entry->data = dev;
-
-    proc_entry = create_proc_entry("filters", S_IFREG | S_IRUGO | S_IWUSR,
-				   dev->proc_root);
-    if (!proc_entry)
-	goto error3;
-    proc_entry->read_proc = rtcan_read_proc_filter;
-    proc_entry->data = dev;
+    dev->proc_root = proc_mkdir(dev->name, rtcan_proc_root);
+    if (!dev->proc_root) {
+	printk("%s: unable to create /proc device entries\n", dev->name);
+	return -1;
+    }
 
+    proc_create_data("info", S_IFREG | S_IRUGO | S_IWUSR, dev->proc_root,
+		     &rtcan_proc_info_ops, dev);
+    proc_create_data("filters", S_IFREG | S_IRUGO | S_IWUSR, dev->proc_root,
+		     &rtcan_proc_filter_ops, dev);
     return 0;
 
-  error3:
-    remove_proc_entry("info", dev->proc_root);
-  error2:
-    remove_proc_entry(dev->name, rtcan_proc_root);
-  error1:
-    printk("%s: unable to create /proc device entries\n", dev->name);
-    return -1;
-
 }
 
 
 static int rtcan_proc_register(void)
 {
-    struct proc_dir_entry *proc_entry;
-
-    rtcan_proc_root = create_proc_entry("rtcan", S_IFDIR, 0);
-    if (!rtcan_proc_root)
-	goto error1;
-
-    proc_entry = create_proc_entry("devices", S_IFREG | S_IRUGO | S_IWUSR,
-				   rtcan_proc_root);
-    if (!proc_entry)
-	goto error2;
-    proc_entry->read_proc = rtcan_read_proc_devices;
-
-    proc_entry = create_proc_entry("version", S_IFREG | S_IRUGO | S_IWUSR,
-				   rtcan_proc_root);
-    if (!proc_entry)
-	goto error3;
-    proc_entry->read_proc = rtcan_read_proc_version;
-
-    proc_entry = create_proc_entry("sockets", S_IFREG | S_IRUGO | S_IWUSR,
-				   rtcan_proc_root);
-    if (!proc_entry)
-	goto error4;
-    proc_entry->read_proc = rtcan_read_proc_sockets;
+    rtcan_proc_root = proc_mkdir("rtcan", NULL);
+    if (!rtcan_proc_root) {
+	printk("rtcan: unable to initialize /proc entries\n");
+	return -1;
+    }
 
+    proc_create("devices", S_IFREG | S_IRUGO | S_IWUSR, rtcan_proc_root,
+	        &rtcan_proc_devices_ops);
+    proc_create("version", S_IFREG | S_IRUGO | S_IWUSR, rtcan_proc_root,
+		&rtcan_proc_version_ops);
+    proc_create("sockets", S_IFREG | S_IRUGO | S_IWUSR, rtcan_proc_root,
+		&rtcan_proc_sockets_ops);
     return 0;
-
-  error4:
-    remove_proc_entry("version", rtcan_proc_root);
-
-  error3:
-    remove_proc_entry("devices", rtcan_proc_root);
-
-  error2:
-    remove_proc_entry("rtcan", 0);
-
-  error1:
-    printk("rtcan: unable to initialize /proc entries\n");
-    return -1;
 }
 
 
@@ -446,7 +439,6 @@ int __init rtcan_init(void)
 
 void __exit rtcan_exit(void)
 {
-
     rtcan_raw_proto_unregister();
 #ifdef CONFIG_PROC_FS
     rtcan_proc_unregister();
diff --git a/ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c b/ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c
index ae80b9a..d8e0a7f 100644
--- a/ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c
+++ b/ksrc/drivers/can/sja1000/rtcan_sja1000_proc.c
@@ -29,50 +29,42 @@
 
 #ifdef CONFIG_XENO_DRIVERS_CAN_DEBUG
 
-static int rtcan_sja_proc_regs(char *buf, char **start, off_t offset,
-				 int count, int *eof, void *data)
+static int rtcan_sja_proc_regs(struct seq_file *p, void *data)
 {
     struct rtcan_device *dev = (struct rtcan_device *)data;
     struct rtcan_sja1000 *chip = (struct rtcan_sja1000 *)dev->priv;
     int i;
-    RTCAN_PROC_PRINT_VARS(80);
 
-    if (!RTCAN_PROC_PRINT("SJA1000 registers"))
-	goto done;
+    seq_printf(p, "SJA1000 registers");
     for (i = 0; i < 0x20; i++) {
-	if ((i % 0x10) == 0) {
-	    if (!RTCAN_PROC_PRINT("\n%02x:", i))
-		goto done;
-	}
-	if (!RTCAN_PROC_PRINT(" %02x", chip->read_reg(dev, i)))
-	    goto done;
+	if ((i % 0x10) == 0)
+	    seq_printf(p, "\n%02x:", i);
+	seq_printf(p, " %02x", chip->read_reg(dev, i));
     }
-    if (!RTCAN_PROC_PRINT("\n"))
-	goto done;
+    seq_printf(p, "\n");
+    return 0;
+}
 
- done:
-    RTCAN_PROC_PRINT_DONE;
+static int rtcan_sja_proc_regs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtcan_sja_proc_regs, PDE_DATA(inode));
 }
 
+static const struct file_operations rtcan_sja_proc_regs_ops = {
+	.open		= rtcan_sja_proc_regs_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 int rtcan_sja_create_proc(struct rtcan_device* dev)
 {
-    struct proc_dir_entry *proc_entry;
-
     if (!dev->proc_root)
 	return -EINVAL;
 
-    proc_entry = create_proc_entry("registers", S_IFREG | S_IRUGO | S_IWUSR,
-				   dev->proc_root);
-    if (!proc_entry)
-	goto error;
-    proc_entry->read_proc = rtcan_sja_proc_regs;
-    proc_entry->data = dev;
-
+    proc_create_data("registers", S_IFREG | S_IRUGO | S_IWUSR, dev->proc_root,
+		     &rtcan_sja_proc_regs_ops, dev);
     return 0;
-
-  error:
-    printk("%s: unable to create /proc entries for SJA\n", dev->name);
-    return -1;
 }
 
 void rtcan_sja_remove_proc(struct rtcan_device* dev)
-- 
1.7.3.4

