Message-ID: <500C7472.50601@xenomai.org>
Date: Sun, 22 Jul 2012 23:45:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5009DF76.5010306@nta-inc.net>
In-Reply-To: <5009DF76.5010306@nta-inc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Issue with Xenomai 2.6.1 / Linux 2.6.38.8 on logout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <jeff.webb@nta-inc.net>
Cc: xenomai@xenomai.org

On 07/21/2012 12:45 AM, Jeff Webb wrote:
> I have built and installed Xenomai 2.6.1 with a Linux 2.6.38.8 kernel on
> an Intel X5650 machine running Ubuntu 10.04.  It seems to boot and run
> fine.  If I try to log out of my GUI session, the monitors go into power
> save mode and never come back.  I can SSH into the machine to reboot
> it.  I get the following in /var/log/syslog:
>
> irq 16: nobody cared (try booting with the "irqpoll" option)
> Pid: 2694, comm: Xorg Tainted: P            2.6.38.8-xenomai-2.6.1 #1
> Call Trace:
>   [<ffffffff8109da26>] ? __report_bad_irq+0x26/0xa0
>   [<ffffffff8109dc2c>] ? note_interrupt+0x18c/0x1d0
>   [<ffffffff8109e89d>] ? handle_fasteoi_irq+0xed/0x120
>   [<ffffffff81005bdd>] ? handle_irq+0x1d/0x30
>   [<ffffffff81005091>] ? do_IRQ+0x61/0xf0
>   [<ffffffff810a4790>] ? __ipipe_sync_stage+0x1f0/0x1f6
>   [<ffffffff81005030>] ? do_IRQ+0x0/0xf0
>   [<ffffffff810a4796>] ? __xirq_end+0x0/0xa
>   [<ffffffff81005030>] ? do_IRQ+0x0/0xf0
>   [<ffffffff810a4c0e>] ? __ipipe_walk_pipeline+0x10e/0x120
>   [<ffffffff8101c587>] ? __ipipe_handle_irq+0x137/0x300
>   [<ffffffff8109e0b0>] ? __ipipe_ack_fasteoi_irq+0x0/0x20
>   [<ffffffff81555ad3>] ? common_interrupt+0x13/0x30
> handlers:
> [<ffffffff813e2990>] (usb_hcd_irq+0x0/0xb0)
> Disabling IRQ #16
>
> I have tried changing some kernel config option to no avail.  I have
> attached the .config that goes with the information above.  Any help in
> debugging would be appreciated.
>

Could you provide a dump of /proc/interrupts?

TIA,

-- 
Philippe.



