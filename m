Message-ID: <5074986C.8000509@xenomai.org>
Date: Tue, 09 Oct 2012 23:34:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <505EB99F.7050705@wanadoo.fr> <505EBD61.1050009@wanadoo.fr>
	<505F0D40.9030105@xenomai.org> <50741C5B.4060206@wanadoo.fr>
In-Reply-To: <50741C5B.4060206@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Target frozen with rtcan_virt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 10/09/2012 02:45 PM, Thierry Bultel wrote:
> (snip)

> (gdb) bt
> #0  __ticket_spin_lock (lock=<optimized out>) at 
> /home/thierry/workspace/Buildroot/output/build/linux-3.2.21/arch/x86/include/asm/spinlock.h:63
> #1  arch_spin_lock (lock=<optimized out>) at 
> /home/thierry/workspace/Buildroot/output/build/linux-3.2.21/arch/x86/include/asm/spinlock.h:129
> #2  rtcan_raw_recvmsg (context=0xc7ff0000, user_info=0xd00b2290, 
> msg=0xd796df04, flags=<optimized out>) at 
> drivers/xenomai/can/rtcan_raw.c:655
> (snip)
> 
> 
> In my previous configuration, disabling CONFIG_SMP was enough to 
> workaround it, but in that new case
> I have other bad side-effects (console and X server frozen at startup) 
> that prevent me to work correctly.


That is essentially the same backtrace as in the first case. Could you
try the following patch?

diff --git a/ksrc/drivers/can/rtcan_raw.c b/ksrc/drivers/can/rtcan_raw.c
index ded024e..b07f19c 100644
--- a/ksrc/drivers/can/rtcan_raw.c
+++ b/ksrc/drivers/can/rtcan_raw.c
@@ -695,10 +695,7 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_dev_context *context,
 
     /* Message completely read from the socket's ring buffer. Now check if
      * caller is just peeking. */
-    if (flags & MSG_PEEK)
-	/* Next one, please! */
-	rtdm_sem_up(&sock->recv_sem);
-    else
+    if ((flags & MSG_PEEK) == 0)
 	/* Adjust begin of first message in the ring buffer. */
 	sock->recv_head = recv_buf_index;
 
@@ -707,6 +704,11 @@ ssize_t rtcan_raw_recvmsg(struct rtdm_dev_context *context,
     rtdm_lock_put_irqrestore(&rtcan_socket_lock, lock_ctx);
 
 
+    if (flags & MSG_PEEK)
+	/* Next one, please! */
+	rtdm_sem_up(&sock->recv_sem);
+
+
     /* Create CAN socket address to give back */
     if (msg->msg_namelen) {
 	scan.can_family = AF_CAN;


-- 
                                                                Gilles.

