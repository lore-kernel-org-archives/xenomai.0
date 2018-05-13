References: <5AF7623E.8020101@freyder.net>
 <CALLqZ8Sb_qmi-wgw1g2sEQvBSyAaszO9SPyChsX5bZ87z_RupQ@mail.gmail.com>
 <5AF7B9F3.1090204@freyder.net>
 <CALLqZ8Tk1zce5bX1Knq+xEno56frgHd2igDHPcy_Xicehpb7MQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <957ef9c6-51ee-2217-b98f-a1994d133285@xenomai.org>
Date: Sun, 13 May 2018 16:16:53 +0200
MIME-Version: 1.0
In-Reply-To: <CALLqZ8Tk1zce5bX1Knq+xEno56frgHd2igDHPcy_Xicehpb7MQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM serial illicit call from head domain 'Xenomai'
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, Steve Freyder <steve@freyder.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/13/2018 07:02 AM, Greg Gallagher wrote:
> I won't say the driver is improperly written, this ioctl call may not
> be expected to be used in a low latency situation.  Some code maybe
> expected to be called at initialization time and then never again so
> it doesn't impact RT operation.  The rt_imx_uart driver is part of the
> Xenomai code base, I'm not 100% sure if this functions shouldn't be
> called from an RTDM driver or if the author needs to be aware they
> could just introduce latency when used in the rt context.
> These panics aren't kernel or driver errors, we are creating them on
> purpose to try to track down domain switches which could impact
> latency.  So as long as your latency number are acceptable you don't
> need to enable the debug flag to track down domain switches and these
> panics can be ignored for now.
> 

I would recommend to fix the situation asap in the RTDM driver though
[1], because this may actually lead to crashes.

Those debug checks trap invalid re-entries of the regular kernel code
from the co-kernel (rt) context. This is an illustration of a possible
scenario involving such a bad re-entry:

   /* regular kernel context */
   spin_lock_irqsave(&lock, flags);
      <IRQx received: rt handler installed>
         handle_rt_event();
            <context_switch>
            /* rt thread context. */
            ioctl(imx_fd, ...);
               /* invalid call of regular kernel code */
               spin_lock_irqsave(&lock, flags);
               <DEADLOCK>

IOW, we have to keep in mind that any IRQ routed to the real-time
co-kernel may preempt most of the regular kernel code, even though the
latter has [only virtually] disabled interrupts: making this event
possible is the purpose of the interrupt pipeline. The restriction which
is paired to this feature is that we may not re-enter the preempted
code, because the logic there still rightfully assumes this may not happen.

As a matter of fact, the interrupt pipeline potentially turns any device
IRQ as a NMI from the standpoint of a Linux kernel. In addition, the
co-kernel has its own scheduler to manage rt threads. In short, rt
activities are not serialized by the regular kernel locking scheme.

[1]
diff --git a/kernel/drivers/serial/rt_imx_uart.c
b/kernel/drivers/serial/rt_imx_uart.c
index 61836ae09..1aec219b7 100644
--- a/kernel/drivers/serial/rt_imx_uart.c
+++ b/kernel/drivers/serial/rt_imx_uart.c
@@ -963,6 +963,13 @@ static int rt_imx_uart_ioctl(struct rtdm_fd *fd,
 		struct rtser_config config_buf;
 		uint64_t *hist_buf = NULL;

+		/*
+		 * We may call regular kernel services ahead, ask for
+		 * re-entering secondary mode if need be.
+		 */
+		if (rtdm_in_rt_context())
+			return -ENOSYS;
+
 		config = (struct rtser_config *)arg;

 		if (rtdm_fd_is_user(fd)) {
@@ -984,13 +991,6 @@ static int rt_imx_uart_ioctl(struct rtdm_fd *fd,
 			return -EINVAL;

 		if (config->config_mask & RTSER_SET_TIMESTAMP_HISTORY) {
-			/*
-			 * Reflect the call to non-RT as we will likely
-			 * allocate or free the buffer.
-			 */
-			if (rtdm_in_rt_context())
-				return -ENOSYS;
-
 			if (config->timestamp_history &
 						RTSER_RX_TIMESTAMP_HISTORY)
 				hist_buf = kmalloc(IN_BUFFER_SIZE *
@@ -1000,7 +1000,8 @@ static int rt_imx_uart_ioctl(struct rtdm_fd *fd,

 		rt_imx_uart_set_config(ctx, config, &hist_buf);

-		kfree(hist_buf);
+		if (hist_buf)
+			kfree(hist_buf);
 		break;
 	}


-- 
Philippe.

