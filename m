MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Fri, 29 Apr 2022 00:04:34 -0700
Message-ID: <CA+K1mPF--SuW4W3Gh_4j8pk=YbX+E2R-aYRxXxh4T8HHbSfLMw@mail.gmail.com>
Subject: Interrupt handler illicit call
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai List <xenomai@xenomai.org>

I am unable to handle interrupts in my RTDM module with Xenomai 3.1,
ipipe kernel 4.19.229.
The interrupt handler code below was ported from Xenomai 2.6 where the
approach worked OK.
This is how I enable the parallel port interrupt in my module:

#define LPPORT                 0x378
#define LPPORT_CTL             (LPPORT+2)
#define LP_IRQ                 7
#define IRQ_7_ENAB             0x10

static rtdm_irq_t irq_handle;
rtdm_irq_request(&irq_handle,
                       irq_level,
                       Lp_port_handler,   /* This is the ISR */
                       RTDM_IRQTYPE_EDGE,
                       "parallel_port",
                       &irq_handle);
status = inb(LPPORT_CTL);
outb(status | IRQ_7_ENAB, LPPORT_CTL);
rtdm_irq_enable(&irq_handle);

Here is the interrupt handler:

int Lp_port_handler(rtdm_irq_t *irq_handle_p)
{
   static int err;
   unsigned long next;
   rtdm_irq_t *handle_p;

   handle_p = rtdm_irq_get_arg(irq_handle_p, rtdm_irq_t);

   next = rtdm_clock_read();
   // do some timing calculations with 'next' var here ...
   err = rtdm_irq_enable(handle_p);   //re-enable this for subsequent interrupts
   if (err)
      rtdm_printk("could not enable parallel port IRQ, error code: %d\n", err);
   return 0;
}

Interrupts are coming in at about 200Hz,
But after about 12000 interrupts, I got this fault in dmesg:

[  592.239842] I-pipe: Detected illicit call from head domain 'Xenomai'
                       into a regular Linux service
[  592.239849] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G           OE
  4.19.229xeno3.1-x8664H #4
[  592.239853] BUG: Unhandled exception over domain Xenomai at
0xffffffffb413c938 - switching to ROOT
[  592.239856] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G           OE
  4.19.229xeno3.1-x8664H #4
[  592.239859] Hardware name: To be filled by O.E.M. To be filled by
O.E.M./SHARKBAY, BIOS 4.6.5 08/29/2017
[  592.239861] I-pipe domain: Linux
[  592.239864] Call Trace:
[  592.239867]  <IRQ>
[  592.239873]  dump_stack+0x95/0xc4
[  592.239878]  __ipipe_trap_prologue.cold.10+0x27/0x55
[  592.239882]  invalid_op+0x26/0x51
[  592.239886] RIP: 0010:__ipipe_spin_unlock_debug+0x18/0x20
[  592.239890] Code: 77 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f
1f 00 e8 db 53 8c 00 f7 c7 00 02 00 00 74 0f 55 48 89 e5 9c 58 f6 c4
02 75 02 <0f> 0b 5d c3 c3 0f 1f 00 e8 bb 53 8c 00 55 48 89 e5 41 55 41
54 53
[  592.239892] RSP: 0018:ffff921d54d03b40 EFLAGS: 00010046
[  592.239895] RAX: 0000000000000006 RBX: ffffffffc06dfb00 RCX: 000000000000001f
[  592.239898] RDX: 0000000000000001 RSI: 0000000026e09369 RDI: 0000000000000200
[  592.239900] RBP: ffff921d54d03b40 R08: ffff921d54d284a0 R09: 0000000000000000
[  592.239902] R10: 0000000000000000 R11: 0000000000000002 R12: ffffffffc06dfb40
[  592.239905] R13: 0000000000000200 R14: 0000000000000007 R15: ffffffffb55d5340
[  592.239911]  xnintr_enable+0x3b/0xa0
[  592.239916]  Lp_port_handler+0x77/0x80 [myapp]
[  592.239919]  xnintr_irq_handler+0x127/0x450
[  592.239923]  __ipipe_do_sync_stage+0xec/0x1a0
[  592.239926]  ipipe_unstall_root+0x34/0x40
[  592.239930]  ipipe_restore_root+0x24/0x30
[  592.239933]  vprintk_emit+0x138/0x260
[  592.239936]  vprintk_default+0x1f/0x30
[  592.239939]  vprintk_func+0x44/0xd0
[  592.239942]  do_vprintk+0x3d/0xe0
[  592.239947]  printk+0x58/0x6f
[  592.239951]  dump_stack_print_info+0x7c/0xe0
[  592.239955]  dump_stack+0x8c/0xc4
[  592.239958]  ipipe_root_only.cold.18+0x11/0x2c
[  592.239961]  ipipe_stall_root+0x11/0x40
[  592.239965]  _raw_spin_lock_irqsave+0x27/0x50
[  592.239969]  xnintr_enable+0x27/0xa0
[  592.239972]  Lp_port_handler+0x77/0x80 [myapp]
[  592.239975]  xnintr_irq_handler+0x127/0x450
[  592.239979]  dispatch_irq_head+0x9d/0x110
[  592.239983]  __ipipe_dispatch_irq+0x1bc/0x1e0
[  592.239988]  __ipipe_handle_irq+0x93/0x200
[  592.239991]  common_interrupt+0xf/0x2c
[  592.239994]  </IRQ>

What in my handler routine is incorrect API or "illicit"?
thanks,
-C Smith

