From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 2 Nov 2008 22:23:34 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811022223.35962.niklaus.giger@domain.hid>
Subject: [Xenomai-help] Xenomai interrupt handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi

I have the following problem.

I have a stack overflow as I get a eternal loop like this:
> gdb) i s
> #0  0x0ff56f34 in rt_task_sigharden () from
> /opt/eldk/ppc_4xx/usr/xenomai/lib/libnative.so.3 #1  0x0ffad8b4 in
> wind_task_sigharden () from
> /opt/eldk/ppc_4xx/usr/xenomai/lib/libvxworks.so.1 #2  0x0ff56f78 in
> rt_task_sigharden () from /opt/eldk/ppc_4xx/usr/xenomai/lib/libnative.so.3
> #3  0x0ffad8b4 in wind_task_sigharden () from
> /opt/eldk/ppc_4xx/usr/xenomai/lib/libvxworks.so.1 #4  0x0ff56f78 in
> rt_task_sigharden () from /opt/eldk/ppc_4xx/usr/xenomai/lib/libnative.so.3

The disassembler tells me:
> (gdb) x /10i 0x0ffad8a0
> 0xffad8a0 <wind_task_sigharden+48>:     lwz     r0,-32764(r30)
> 0xffad8a4 <wind_task_sigharden+52>:     cmpw    cr7,r9,r0
> 0xffad8a8 <wind_task_sigharden+56>:     beq-    cr7,0xffad8b4
> <wind_task_sigharden+68> 0xffad8ac <wind_task_sigharden+60>:     mtctr   r9
> 0xffad8b0 <wind_task_sigharden+64>:     bctrl
> 0xffad8b4 <wind_task_sigharden+68>:     lis     r0,512
> 0xffad8> static irqreturn_t cpld_interrupt(int irq, void *dev_id)
> b8 <wind_task_sigharden+72>:     ori     r0,r0,555
> 0xffad8bc <wind_task_sigharden+76>:     li      r3,1
> 0xffad8c0 <wind_task_sigharden+80>:     sc
> 0xffad8c4 <wind_task_sigharden+84>:     mfcr    r0
> (gdb) x /10i 0x0ff56f60
> 0xff56f60 <rt_task_sigharden+44>:       beq-    cr7,0xff56f78
> <rt_task_sigharden+68> 0xff56f64 <rt_task_sigharden+48>:       lwz    
> r0,-32764(r30)
> 0xff56f68 <rt_task_sigharden+52>:       cmpw    cr7,r9,r0
> 0xff56f6c <rt_task_sigharden+56>:       beq-    cr7,0xff56f78
> <rt_task_sigharden+68> 0xff56f70 <rt_task_sigharden+60>:       mtctr   r9
> 0xff56f74 <rt_task_sigharden+64>:       bctrl
> 0xff56f78 <rt_task_sigharden+68>:       lis     r0,512
> 0xff56f7c <rt_task_sigharden+72>:       ori     r0,r0,555
> 0xff56f80 <rt_task_sigharden+76>:       li      r3,1
> 0xff56f84 <rt_task_sigharden+80>:       sc
> (gdb)

Here some interrupt related infos:
>  cat /proc/interrupts
>            CPU0
>  16:        589   UIC   Level     serial
>  17:      12114   UIC   Level     MAL TX EOB
>  18:      16702   UIC   Level     MAL RX EOB
>  19:          0   UIC   Level     CAN_0
>  20:          0   UIC   Level     CAN_1
>  21:          0   UIC   Level     MAL SERR
>  22:          0   UIC   Level     MAL TX DE
>  23:          0   UIC   Level     MAL RX DE
>  24:          0   UIC   Level     EMAC
>  25:          0   UIC   Level     CPLD
> BAD:          0
> -bash-3.2# cat /proc/xenomai/irq
> IRQ         CPU0
>  19:           1         intr_19
>  25:           0         intr_25
> 512:      202313         [virtual]
> 515:         229         [virtual]

Here are is the kernel code of my interrupt handlers:

> {
> #if 1
> 	/* TODO: make interval selectable */
> 	out_be16(tick_ctrl_reg, TICK_INT_ENABLE | TICK_INT_RESET |
> 				TICK_START | TICK_INTERVAL_1000_US);
> 	out_be16(tick_ctrl_reg, TICK_INT_ENABLE |
> 				TICK_START | TICK_INTERVAL_1000_US);
> #endif
> 	return IRQ_HANDLED;
> }
>
> /* can_interrupt is just a placeholder for the xenomai IRQ object. But it
>  * needs to be here. Else it is not possible to create a (XENOMAI)
> interrupt * object from user-space.
>  */
>
> static irqreturn_t can_interrupt(int irq, void *dev_id)
> {
> 	return IRQ_HANDLED;
> }

If I restart the program a second time, I usually have no problem.
Has anybody an idea, what is going wrong?

Best regards

-- 
NIklaus Giger


