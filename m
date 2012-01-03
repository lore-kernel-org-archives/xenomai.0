MIME-Version: 1.0
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Tue, 3 Jan 2012 18:49:58 +0100
Message-ID: <CAL8zT=h3+AYe56fWhbKr3nY8VhYcNjx=sPRe0cak5hvF+aM6yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai-core] Ipipe breaks my MPC8541 board boot
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

First of all, I wish you a Happy new year !

I am currently facing an issue, which is ipipe related.
I have a board, based on a MPC8541 and with several ethernet interfaces.
When I compile my kernel (2.6.35) without ipipe support, everything
works fine, but when ipipe is here (2.12-01) I get an oops :
[   25.329505] BUG: spinlock lockup on CPU#0, swapper/0, c03b06a8
[   25.399320] Call Trace:
[   25.428515] [c03cdc30] [c0008290] show_stack+0x3c/0x17c (unreliable)
[   25.504602] [c03cdc70] [c01b9d64] do_raw_spin_lock+0x154/0x180
[   25.574424] [c03cdca0] [c02bc5f0] _raw_spin_lock+0x3c/0x50
[   25.640075] [c03cdcc0] [c00235b8] task_rq_lock+0x58/0x70
[   25.703645] [c03cdce0] [c00246e4] try_to_wake_up+0x24/0x14c
[   25.770350] [c03cdd10] [c0031098] wakeup_softirqd+0x3c/0x4c
[   25.837051] [c03cdd20] [c0225f3c] dev_kfree_skb_irq+0x7c/0xc4
[   25.905828] [c03cdd40] [c0201bd0] fs_enet_interrupt+0x528/0x70c
[   25.976694] [c03cdd90] [c006b4b8] handle_IRQ_event+0x74/0x1e8
[   26.045470] [c03cddc0] [c006ea74] handle_level_irq+0x80/0x108
[   26.114250] [c03cdde0] [c001a44c] cpm2_cascade+0x38/0x6c
[   26.177816] [c03cde00] [c000a1d4] __ipipe_ack_irq+0x18/0x28
[   26.244510] [c03cde10] [c000a4e0] __ipipe_handle_irq+0x188/0x1b4
[   26.316414] [c03cde40] [c000a610] __ipipe_grab_irq+0x3c/0x70
[   26.384158] [c03cde50] [c0012704] __ipipe_ret_from_except+0x0/0xc
[   26.457102] [c03cdf10] [c0008c48] __switch_to+0x94/0xbc
[   26.519630] [c03cdf30] [c02b9f10] schedule+0x22c/0x41c
[   26.581111] [c03cdf80] [c0009650] cpu_idle+0xc8/0xd8
[   26.640514] [c03cdfa0] [c0002398] rest_init+0xb4/0xcc

cpm2_cascade is dedicated to my board, but has nothing impressive :
static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
{
        int cascade_irq;

        while ((cascade_irq = cpm2_get_irq()) >= 0)
                generic_handle_irq(cascade_irq);

        desc->chip->eoi(irq);
}

If you need the device tree, I can give it to you.
I am looking for any help, or known bugs, maybe ?

Thanks in advance for your help !
Regards,
JM

