Message-ID: <542C1DA3.8080306@xenomai.org>
Date: Wed, 01 Oct 2014 17:28:35 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20141001142416.GA4435@csclub.uwaterloo.ca>
 <542C165E.6060809@xenomai.org> <20141001150206.GB4435@csclub.uwaterloo.ca>
In-Reply-To: <20141001150206.GB4435@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe error when requesting irq that is on omap gpio
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 10/01/2014 05:02 PM, Lennart Sorensen wrote:
> On Wed, Oct 01, 2014 at 04:57:34PM +0200, Gilles Chanteperdrix wrote:
>> On 10/01/2014 04:24 PM, Lennart Sorensen wrote:
>>> I tried using an omap-gpio as an interrupt in xenomai and got this message when registering it:
>>>
>>> [58531.105521] I-pipe: Detected illicit call from head domain 'Xenomai'
>>> [58531.105521]         into a regular Linux service
>>> [58531.105538] CPU: 0 PID: 9816 Comm: StartTask Tainted: G           O 3.12-1-am5726 #1 Debian 3.12.27-0.1RR6
>>> [58531.105558] [<c0016410>] (unwind_backtrace+0x0/0xf8) from [<c001286c>] (show_stack+0x10/0x14)
>>> [58531.105577] [<c001286c>] (show_stack+0x10/0x14) from [<c0440784>] (dump_stack+0x70/0x8c)
>>> [58531.105594] [<c0440784>] (dump_stack+0x70/0x8c) from [<c001a55c>] (ipipe_test_and_stall_root+0x8/0x8c)
>>> [58531.105611] [<c001a55c>] (ipipe_test_and_stall_root+0x8/0x8c) from [<c04449c4>] (_raw_spin_lock_irqsave+0xc/0x4c)
>>> [58531.105626] [<c04449c4>] (_raw_spin_lock_irqsave+0xc/0x4c) from [<c0016238>] (unwind_frame+0x2c4/0x49c)
>>> [58531.105641] [<c0016238>] (unwind_frame+0x2c4/0x49c) from [<c0016490>] (unwind_backtrace+0x80/0xf8)
>>> [58531.105657] [<c0016490>] (unwind_backtrace+0x80/0xf8) from [<c001286c>] (show_stack+0x10/0x14)
>>> [58531.105673] [<c001286c>] (show_stack+0x10/0x14) from [<c0440784>] (dump_stack+0x70/0x8c)
>>> [58531.105689] [<c0440784>] (dump_stack+0x70/0x8c) from [<c0040060>] (warn_slowpath_common+0x68/0x8c)
>>> [58531.105705] [<c0040060>] (warn_slowpath_common+0x68/0x8c) from [<c00400a0>] (warn_slowpath_null+0x1c/0x24)
>>> [58531.105721] [<c00400a0>] (warn_slowpath_null+0x1c/0x24) from [<c001a308>] (ipipe_set_irq_affinity+0x98/0xd8)
>>> [58531.105783] [<c001a308>] (ipipe_set_irq_affinity+0x98/0xd8) from [<bf0a689c>] (xnintr_attach+0x2c/0x39c [xeno_nucleus])
>>> [58531.105907] [<bf0a689c>] (xnintr_attach+0x2c/0x39c [xeno_nucleus]) from [<bf1510cc>] (rt_intr_create+0x258/0x4cc [xeno_native])
>>> [58531.106009] [<bf1510cc>] (rt_intr_create+0x258/0x4cc [xeno_native]) from [<bf132de8>] (__rt_intr_create+0x9c/0x124 [xeno_native])
>>> [58531.106124] [<bf132de8>] (__rt_intr_create+0x9c/0x124 [xeno_native]) from [<bf0c2658>] (hisyscall_event+0x184/0x34c [xeno_nucleus])
>>> [58531.106198] [<bf0c2658>] (hisyscall_event+0x184/0x34c [xeno_nucleus]) from [<c00afb9c>] (ipipe_syscall_hook+0x68/0xa8)
>>> [58531.106216] [<c00afb9c>] (ipipe_syscall_hook+0x68/0xa8) from [<c00ae698>] (__ipipe_notify_syscall+0x170/0x408)
>>> [58531.106233] [<c00ae698>] (__ipipe_notify_syscall+0x170/0x408) from [<c000eefc>] (pipeline_syscall+0x8/0x24)
>>> [58531.106336] [<bf0a689c>] (xnintr_attach+0x2c/0x39c [xeno_nucleus]) from [<bf1510cc>] (rt_intr_create+0x258/0x4cc [xeno_native])
>>> [58531.106434] [<bf1510cc>] (rt_intr_create+0x258/0x4cc [xeno_native]) from [<bf132de8>] (__rt_intr_create+0x9c/0x124 [xeno_native])
>>> [58531.106538] [<bf132de8>] (__rt_intr_create+0x9c/0x124 [xeno_native]) from [<bf0c2658>] (hisyscall_event+0x184/0x34c [xeno_nucleus])
>>> [58531.106609] [<bf0c2658>] (hisyscall_event+0x184/0x34c [xeno_nucleus]) from [<c00afb9c>] (ipipe_syscall_hook+0x68/0xa8)
>>> [58531.106626] [<c00afb9c>] (ipipe_syscall_hook+0x68/0xa8) from [<c00ae698>] (__ipipe_notify_syscall+0x170/0x408)
>>> [58531.106641] [<c00ae698>] (__ipipe_notify_syscall+0x170/0x408) from [<c000eefc>] (pipeline_syscall+0x8/0x24)
>>> [58531.106652] ---[ end trace dff1d3990fff1b03 ]---
>>> [58531.106718] ------------[ cut here ]------------
>>> [58531.106729] WARNING: CPU: 0 PID: 9816 at /tmp/linux/linux-3.12.27.rr1/arch/arm/kernel/ipipe.c:158 ipipe_set_irq_affinity+0x98/0xd8(
>>> )
>>> [58531.106738] Modules linked in: 8021q garp stp mrp llc l2tp_eth l2tp_netlink l2tp_core ip_gre ip_tunnel gre macvlan ti_pru_eth rcksa
>>> pi_layer2(O) iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack dummy xeno_posix xeno_rtdm xeno_native xeno_
>>> nucleus max6369_wdt iptable_filter ip_tables x_tables xhci_hcd dwc3 ahci_platform omap_aes phy_omap_usb2 phy_omap_pipe3 phy_omap_contr
>>> ol dwc3_omap lm75 [last unloaded: xfrm_user]
>>> [58531.106980] CPU: 0 PID: 9816 Comm: StartTask Tainted: G           O 3.12-1-am5726 #1 Debian 3.12.27-0.1RR6
>>> [58531.106990] [<c0016410>] (unwind_backtrace+0x0/0xf8) from [<c001286c>] (show_stack+0x10/0x14)
>>> [58531.106998] [<c001286c>] (show_stack+0x10/0x14) from [<c0440784>] (dump_stack+0x70/0x8c)
>>> [58531.107007] [<c0440784>] (dump_stack+0x70/0x8c) from [<c0040060>] (warn_slowpath_common+0x68/0x8c)
>>> [58531.107016] [<c0040060>] (warn_slowpath_common+0x68/0x8c) from [<c00400a0>] (warn_slowpath_null+0x1c/0x24)
>>> [58531.107025] [<c00400a0>] (warn_slowpath_null+0x1c/0x24) from [<c001a308>] (ipipe_set_irq_affinity+0x98/0xd8)
>>> [58531.107034] [<c001a308>] (ipipe_set_irq_affinity+0x98/0xd8) from [<bf0a689c>] (xnintr_attach+0x2c/0x39c [xeno_nucleus])
>>>
>>> I saw ipipe patches in the gpio-omap.c but maybe something is still
>>> missing.
>>>
>>> Any ideas?
>>>
>>> Of course it may be that our code is used to running on an older xenomai
>>> where it first called request_irq and then xenomai took over the irq
>>> handling.  I wish the person that wrote that code still worked here to
>>> explain why that was done.
>>>
>>> If I don't use the gpio irq but instead use an irq that is one level
>>> lower, then I get no such error message (although the pin isn't setup
>>> properly either then so it doesn't actually work either).
>>>
>> This is a simple warning which should be harmless, it should not prevent
>> the irq from working. Now we had an old issue on ARM, which is that an
>> irq line should be enabled before using it, the simplest way to get it
>> enabled being to call request_irq before rtdm_irq_request. Maybe this
>> issue we believed fixed is still there?
> 
> Or maybe I still haven't got the gpio bank configured correctly to
> actually be an interrupt pin.  It looked like the omap-gpio driver did
> that all correctly, but with all the registers on these chips, who knows.
> 
> We are currently doing request_irq first, and it still doesn't see any
> interrupts on the line.

Do you use gpio_to_irq to obtain the irq number?

> 
> So is this message a case of the gpio driver doing some setup that ipipe
> thinks should only be done from linux while doing the irq reqeust from
> xenomai's domain?
> 
> I wish the message had told me which linux thing I called that it didn't
> think I should have.  That would have been helpful.

Actually, it tells you that you called rt_intr_create from user-space,
which ends-up calling ipipe_set_irq_affinity, which is not happy because
it is not called from Linux domain. We modified ipipe_virtualize_irq to
avoid that (only checking for root domain when CONFIG_IPIPE_LEGACY is
not set), but we probably forgot the SMP case with ipipe_set_irq_affinity.

-- 
                                                                Gilles.

