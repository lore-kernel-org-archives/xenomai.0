From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <12104543.1177686610343.JavaMail.ngmail@domain.hid>
References: <1177686318.5010.106.camel@domain.hid>
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>
	<784082.1177682909759.JavaMail.ngmail@domain.hid>
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>
	<1177685762.5010.104.camel@domain.hid>
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 17:36:16 +0200
Message-Id: <1177688176.5010.135.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org, jan.kiszka@domain.hid

On Fri, 2007-04-27 at 17:10 +0200, M. Koehrer wrote:
> Hi Philippe,
> 
> here is the next result (I have switched off the "quiet" kernel parameter to get everything).
> 

Thanks, I will look at this output asap. On your side, please run
$ objdump -d vmlinux > foo

then search for the kernel routine embodying the text address 0xc03e5680
in the dump file (leftmost column). I'd be interested to see the
disassembly of the entire routine.

> IRQ 219 vectored at #e9
> BUG: unable to handle kernel paging request at virtual address 511203b2
>  printing eip:
> c03e5680
> *pde = 00000000
> Oops: 0002 [#1]
> SMP 
> Modules linked in: e1000
> CPU:    0
> EIP:    0060:[<c03e5680>]    Not tainted VLI
> EFLAGS: 00010092   (2.6.20.4 #18)
> EIP is at 0xc03e5680
> eax: c011226c   ebx: 00000006   ecx: c0114375   edx: dfc1a000
> esi: 00000046   edi: ffffffff   ebp: 00000000   esp: dfc1be24
> ds: 007b   es: 007b   ss: 0068
> Process ifconfig (pid: 1241, ti=dfc1a000 task=dfcb3030 task.ti=dfc1a000)
> Stack: 000000db 00000000 c03d9100 c010efa9 00006d80 00000001 00000060 e099a210 
>        00000286 ffffff24 df7015c8 00000000 0000000f 00000001 c0103439 df7015c8 
>        e099a0ff e09c0000 00000000 0000000f 00000001 80080740 c14a007b df70007b 
> Call Trace:
>  [<c010efa9>] __ipipe_handle_irq+0x1b9/0x20b
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c0103439>] common_interrupt+0x21/0x38
>  [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c02dcfb1>] __dev_mc_upload+0x1d/0x1e
>  [<c02dd0d1>] dev_mc_upload+0x24/0x37
>  [<c02db5dc>] dev_open+0x44/0x62
>  [<c02da0a9>] dev_change_flags+0x47/0xe4
>  [<c030d1c2>] devinet_ioctl+0x252/0x56f
>  [<c02db1ba>] dev_ifsioc+0x113/0x38d
>  [<c02d15d4>] sock_ioctl+0x0/0x1ad
>  [<c02d1762>] sock_ioctl+0x18e/0x1ad
>  [<c02d15d4>] sock_ioctl+0x0/0x1ad
>  [<c015e1bf>] do_ioctl+0x1f/0x62
>  [<c015e446>] vfs_ioctl+0x244/0x256
>  [<c015e48b>] sys_ioctl+0x33/0x4c
>  [<c01029f3>] sysenter_past_esp+0x6c/0x70
>  =======================
> Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <00> 91 3d c0 00 91 3d c0 00 00 00 00 00 00 00 00 00 00 00 00 00 
> EIP: [<c03e5680>] 0xc03e5680 SS:ESP 0068:dfc1be24
>  <0>Kernel panic - not syncing: Fatal exception in interrupt
>  BUG: at arch/i386/kernel/smp.c:565 smp_call_function()
>  [<c010b903>] smp_call_function+0x66/0x10a
>  [<c0118e3a>] printk+0x62/0xd5
>  [<c010b9c2>] smp_send_stop+0x1b/0x2b
>  [<c01183d5>] panic+0x4d/0xe4
>  [<c0103f71>] die+0x1f2/0x226
>  [<c01116a4>] do_page_fault+0x447/0x517
>  [<c013fbae>] __alloc_pages+0x52/0x286
>  [<c010f643>] __ipipe_handle_exception+0xce/0x158
>  [<c01521e3>] kmem_cache_alloc+0x5d/0x67
>  [<c010bb1e>] smp_call_function_interrupt+0x31/0x4c
>  [<c033339d>] error_code+0x81/0x90
>  [<c0114375>] try_to_wake_up+0x33c/0x346
>  [<c011226c>] __activate_task+0x1c/0x29
>  [<c010efa9>] __ipipe_handle_irq+0x1b9/0x20b
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c0103439>] common_interrupt+0x21/0x38
>  [<e099a0ff>] e1000_set_multi+0x0/0x189 [e1000]
>  [<e099a210>] e1000_set_multi+0x111/0x189 [e1000]
>  [<c02dcfb1>] __dev_mc_upload+0x1d/0x1e
>  [<c02dd0d1>] dev_mc_upload+0x24/0x37
>  [<c02db5dc>] dev_open+0x44/0x62
>  [<c02da0a9>] dev_change_flags+0x47/0xe4
>  [<c030d1c2>] devinet_ioctl+0x252/0x56f
>  [<c02db1ba>] dev_ifsioc+0x113/0x38d
>  [<c02d15d4>] sock_ioctl+0x0/0x1ad
>  [<c02d1762>] sock_ioctl+0x18e/0x1ad
>  [<c02d15d4>] sock_ioctl+0x0/0x1ad
>  [<c015e1bf>] do_ioctl+0x1f/0x62
>  [<c015e446>] vfs_ioctl+0x244/0x256
>  [<c015e48b>] sys_ioctl+0x33/0x4c
>  [<c01029f3>] sysenter_past_esp+0x6c/0x70
>  =======================
> 
> 
> 
> 
> ----- Original Nachricht ----
> Von:     Philippe Gerum <rpm@xenomai.org>
> An:      "M. Koehrer" <mathias_koehrer@domain.hid>
> Datum:   27.04.2007 17:05
> Betreff: Re: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
> 
> > On Fri, 2007-04-27 at 16:56 +0200, Philippe Gerum wrote:
> > > On Fri, 2007-04-27 at 16:28 +0200, M. Koehrer wrote:
> > > > Hello Philippe,
> > > > 
> > > > here it is: (I have no idea what BUGON does...)
> > > > 
> > > 
> > > This patch will print out the irq/vector mappings. I'm interested in
> > > reading this output.
> > > 
> > > --- arch/i386/kernel/io_apic.c~	2007-02-26 10:31:39.000000000 +0100
> > > +++ arch/i386/kernel/io_apic.c	2007-04-27 16:51:51.000000000 +0200
> > > @@ -1259,6 +1259,7 @@
> > >  	current_vector = vector;
> > >  	current_offset = offset;
> > >  	irq_vector[irq] = vector;
> > > +	printk("IRQ %d vectored at #%2x\n", irq, vector);
> > 
> > Please s/%2x/%.2x
> > 
> > >  
> > >  	return vector;
> > >  }
> > > 
> > -- 
> > Philippe.
> > 
> > 
> > 
> 
-- 
Philippe.



