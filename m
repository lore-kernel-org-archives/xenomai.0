From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Fri, 7 Nov 2014 15:21:15 -0500
Message-ID: <20141107202115.GT24110@csclub.uwaterloo.ca>
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <20141107182600.GS24110@csclub.uwaterloo.ca>
 <545D12D2.2020104@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <545D12D2.2020104@xenomai.org>
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

On Fri, Nov 07, 2014 at 07:43:30PM +0100, Philippe Gerum wrote:
> On 11/07/2014 07:26 PM, Lennart Sorensen wrote:
> > On Wed, Oct 01, 2014 at 10:24:16AM -0400, Lennart Sorensen wrote:
> >> I tried using an omap-gpio as an interrupt in xenomai and got this message when registering it:
> >>
> >> [58531.105521] I-pipe: Detected illicit call from head domain 'Xenomai'
> >> [58531.105521]         into a regular Linux service
> >> [58531.105538] CPU: 0 PID: 9816 Comm: StartTask Tainted: G           O 3.12-1-am5726 #1 Debian 3.12.27-0.1RR6
> >> [58531.105558] [<c0016410>] (unwind_backtrace+0x0/0xf8) from [<c001286c>] (show_stack+0x10/0x14)
> >> [58531.105577] [<c001286c>] (show_stack+0x10/0x14) from [<c0440784>] (dump_stack+0x70/0x8c)
> >> [58531.105594] [<c0440784>] (dump_stack+0x70/0x8c) from [<c001a55c>] (ipipe_test_and_stall_root+0x8/0x8c)
> >> [58531.105611] [<c001a55c>] (ipipe_test_and_stall_root+0x8/0x8c) from [<c04449c4>] (_raw_spin_lock_irqsave+0xc/0x4c)
> >> [58531.105626] [<c04449c4>] (_raw_spin_lock_irqsave+0xc/0x4c) from [<c0016238>] (unwind_frame+0x2c4/0x49c)
> >> [58531.105641] [<c0016238>] (unwind_frame+0x2c4/0x49c) from [<c0016490>] (unwind_backtrace+0x80/0xf8)
> >> [58531.105657] [<c0016490>] (unwind_backtrace+0x80/0xf8) from [<c001286c>] (show_stack+0x10/0x14)
> >> [58531.105673] [<c001286c>] (show_stack+0x10/0x14) from [<c0440784>] (dump_stack+0x70/0x8c)
> >> [58531.105689] [<c0440784>] (dump_stack+0x70/0x8c) from [<c0040060>] (warn_slowpath_common+0x68/0x8c)
> >> [58531.105705] [<c0040060>] (warn_slowpath_common+0x68/0x8c) from [<c00400a0>] (warn_slowpath_null+0x1c/0x24)
> >> [58531.105721] [<c00400a0>] (warn_slowpath_null+0x1c/0x24) from [<c001a308>] (ipipe_set_irq_affinity+0x98/0xd8)
> >> [58531.105783] [<c001a308>] (ipipe_set_irq_affinity+0x98/0xd8) from [<bf0a689c>] (xnintr_attach+0x2c/0x39c [xeno_nucleus])
> >> [58531.105907] [<bf0a689c>] (xnintr_attach+0x2c/0x39c [xeno_nucleus]) from [<bf1510cc>] (rt_intr_create+0x258/0x4cc [xeno_native])
> >> [58531.106009] [<bf1510cc>] (rt_intr_create+0x258/0x4cc [xeno_native]) from [<bf132de8>] (__rt_intr_create+0x9c/0x124 [xeno_native])
> >> [58531.106124] [<bf132de8>] (__rt_intr_create+0x9c/0x124 [xeno_native]) from [<bf0c2658>] (hisyscall_event+0x184/0x34c [xeno_nucleus])
> >> [58531.106198] [<bf0c2658>] (hisyscall_event+0x184/0x34c [xeno_nucleus]) from [<c00afb9c>] (ipipe_syscall_hook+0x68/0xa8)
> >> [58531.106216] [<c00afb9c>] (ipipe_syscall_hook+0x68/0xa8) from [<c00ae698>] (__ipipe_notify_syscall+0x170/0x408)
> >> [58531.106233] [<c00ae698>] (__ipipe_notify_syscall+0x170/0x408) from [<c000eefc>] (pipeline_syscall+0x8/0x24)
> >> [58531.106336] [<bf0a689c>] (xnintr_attach+0x2c/0x39c [xeno_nucleus]) from [<bf1510cc>] (rt_intr_create+0x258/0x4cc [xeno_native])
> >> [58531.106434] [<bf1510cc>] (rt_intr_create+0x258/0x4cc [xeno_native]) from [<bf132de8>] (__rt_intr_create+0x9c/0x124 [xeno_native])
> >> [58531.106538] [<bf132de8>] (__rt_intr_create+0x9c/0x124 [xeno_native]) from [<bf0c2658>] (hisyscall_event+0x184/0x34c [xeno_nucleus])
> >> [58531.106609] [<bf0c2658>] (hisyscall_event+0x184/0x34c [xeno_nucleus]) from [<c00afb9c>] (ipipe_syscall_hook+0x68/0xa8)
> >> [58531.106626] [<c00afb9c>] (ipipe_syscall_hook+0x68/0xa8) from [<c00ae698>] (__ipipe_notify_syscall+0x170/0x408)
> >> [58531.106641] [<c00ae698>] (__ipipe_notify_syscall+0x170/0x408) from [<c000eefc>] (pipeline_syscall+0x8/0x24)
> >> [58531.106652] ---[ end trace dff1d3990fff1b03 ]---
> >> [58531.106718] ------------[ cut here ]------------
> >> [58531.106729] WARNING: CPU: 0 PID: 9816 at /tmp/linux/linux-3.12.27.rr1/arch/arm/kernel/ipipe.c:158 ipipe_set_irq_affinity+0x98/0xd8(
> >> )
> >> [58531.106738] Modules linked in: 8021q garp stp mrp llc l2tp_eth l2tp_netlink l2tp_core ip_gre ip_tunnel gre macvlan ti_pru_eth rcksa
> >> pi_layer2(O) iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack dummy xeno_posix xeno_rtdm xeno_native xeno_
> >> nucleus max6369_wdt iptable_filter ip_tables x_tables xhci_hcd dwc3 ahci_platform omap_aes phy_omap_usb2 phy_omap_pipe3 phy_omap_contr
> >> ol dwc3_omap lm75 [last unloaded: xfrm_user]
> >> [58531.106980] CPU: 0 PID: 9816 Comm: StartTask Tainted: G           O 3.12-1-am5726 #1 Debian 3.12.27-0.1RR6
> >> [58531.106990] [<c0016410>] (unwind_backtrace+0x0/0xf8) from [<c001286c>] (show_stack+0x10/0x14)
> >> [58531.106998] [<c001286c>] (show_stack+0x10/0x14) from [<c0440784>] (dump_stack+0x70/0x8c)
> >> [58531.107007] [<c0440784>] (dump_stack+0x70/0x8c) from [<c0040060>] (warn_slowpath_common+0x68/0x8c)
> >> [58531.107016] [<c0040060>] (warn_slowpath_common+0x68/0x8c) from [<c00400a0>] (warn_slowpath_null+0x1c/0x24)
> >> [58531.107025] [<c00400a0>] (warn_slowpath_null+0x1c/0x24) from [<c001a308>] (ipipe_set_irq_affinity+0x98/0xd8)
> >> [58531.107034] [<c001a308>] (ipipe_set_irq_affinity+0x98/0xd8) from [<bf0a689c>] (xnintr_attach+0x2c/0x39c [xeno_nucleus])
> >>
> >> I saw ipipe patches in the gpio-omap.c but maybe something is still
> >> missing.
> >>
> >> Any ideas?
> >>
> >> Of course it may be that our code is used to running on an older xenomai
> >> where it first called request_irq and then xenomai took over the irq
> >> handling.  I wish the person that wrote that code still worked here to
> >> explain why that was done.
> >>
> >> If I don't use the gpio irq but instead use an irq that is one level
> >> lower, then I get no such error message (although the pin isn't setup
> >> properly either then so it doesn't actually work either).
> > 
> > I discovered that if I comment out:
> > 
> > #ifdef CONFIG_SMP
> >         xnarch_set_irq_affinity(intr->irq, nkaffinity);
> > #endif /* CONFIG_SMP */
> > 
> > I stop getting the huge backtrace and warning about calling a linux
> > service from xenomai.
> 
> For this particular issue, Xenomai 2.x is deadly wrong. Creating,
> deleting, enabling or disabling an IRQ channel must be done from
> secondary mode. The syscall mode bits for these native API calls are
> wrong, should be as follows instead:
> 
> diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.c
> index 950b092..dff7f4d 100644
> --- a/ksrc/skins/native/syscall.c
> +++ b/ksrc/skins/native/syscall.c
> @@ -4145,12 +4145,12 @@ static xnsysent_t __systab[] = {
>  	[__native_alarm_stop] = {&__rt_alarm_stop, __xn_exec_any},
>  	[__native_alarm_wait] = {&__rt_alarm_wait, __xn_exec_primary},
>  	[__native_alarm_inquire] = {&__rt_alarm_inquire, __xn_exec_any},
> -	[__native_intr_create] = {&__rt_intr_create, __xn_exec_any},
> +	[__native_intr_create] = {&__rt_intr_create, __xn_exec_lostage},
>  	[__native_intr_bind] = {&__rt_intr_bind, __xn_exec_conforming},
> -	[__native_intr_delete] = {&__rt_intr_delete, __xn_exec_any},
> +	[__native_intr_delete] = {&__rt_intr_delete, __xn_exec_lostage},
>  	[__native_intr_wait] = {&__rt_intr_wait, __xn_exec_primary},
> -	[__native_intr_enable] = {&__rt_intr_enable, __xn_exec_any},
> -	[__native_intr_disable] = {&__rt_intr_disable, __xn_exec_any},
> +	[__native_intr_enable] = {&__rt_intr_enable, __xn_exec_lostage},
> +	[__native_intr_disable] = {&__rt_intr_disable, __xn_exec_lostage},
>  	[__native_intr_inquire] = {&__rt_intr_inquire, __xn_exec_any},
>  	[__native_pipe_create] = {&__rt_pipe_create, __xn_exec_lostage},
>  	[__native_pipe_bind] = {&__rt_pipe_bind, __xn_exec_conforming},

Oh nifty.  Will give that a try then.

-- 
Len Sorensen

