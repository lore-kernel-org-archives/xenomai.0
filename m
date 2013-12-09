MIME-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset="us-ascii"
From: Kurijn Buys <Kurijn.Buys@open.ac.uk>
In-Reply-To: <52A05ED2.9050003@xenomai.org>
Date: Mon, 9 Dec 2013 15:19:41 +0000
Content-Transfer-Encoding: quoted-printable
Message-ID: <E8F821A2-2BD0-440D-BDA1-3751BD443662@open.ac.uk>
References: <40A5BE95-8E78-4CD6-81D2-C97AA7A58FBB@open.ac.uk>
 <529DCF2F.1070702@xenomai.org>
 <1507DF58-4A8D-42E0-92B8-4A9EAB4289E3@open.ac.uk>
 <529DDB58.3090709@xenomai.org>
 <5B55252A-19D2-4A0D-82BE-FC77BFA6AEE1@open.ac.uk>
 <529DFEC3.1050106@xenomai.org>
 <90F2A7A6-5B5E-4A25-8D9D-3D50D0EC0826@open.ac.uk>
 <529E2801.5060505@xenomai.org> <529EEB7C.4090308@xenomai.org>
 <529EED06.4010108@xenomai.org> <529EF58A.8030003@xenomai.org>
 <529EF680.1040108@xenomai.org> <529EF89E.6000302@xenomai.org>
 <529EFB3D.6090900@xenomai.org> <529F03FC.8040409@xenomai.org>
 <529F04DD.2070201@xenomai.org> <529F0C48.20705@xenomai.org>
 <529F0DBC.9080905@xenomai.org> <529F13A1.5070403@xenomai.org>
 <529F1913.4030604@xenomai.org> <529F1974.60900@xenomai.org>
 <529F2BED.2030403@xenomai.org> <529F5254.8060501@xenomai.org>
 <529F69AD.6060003@xenomai.org>
 <CE87D5F4-FE47-4310-A74F-7F8E4CCEC92B@open.ac.uk>
 <52A05ED2.9050003@xenomai.org>
Subject: Re: [Xenomai] latency spikes under load
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai@xenomai.org

Op 5-dec.-2013, om 11:09 heeft Gilles Chanteperdrix het volgende geschreven=
:

> On 12/05/2013 01:44 AM, Kurijn Buys wrote:
>>
>> Op 4-dec.-2013, om 17:43 heeft Philippe Gerum het volgende geschreven:
>>
>>> On 12/04/2013 05:03 PM, Gilles Chanteperdrix wrote:
>>>> On 12/04/2013 02:19 PM, Philippe Gerum wrote:
>>>>> On 12/04/2013 01:00 PM, Gilles Chanteperdrix wrote:
>>>>>> Ok, could you push the branch somewhere so that I can try it?
>>>>>>
>>>>>
>>>>> testing/ipipe-3.8-i915-fix
>>>>
>>>> I could test it, I no longer get high latencies while moving a large
>>>> opengl window. So, it looks good.
>>
>> I've it running as well (with the priority coupling option disabled this=
 time).
>
> The options I asked you to change were meant to eliminate any possible
> source for high latencies in case of bug. You can return to a normal
> configuration now: re-enable SMP or APIC if you prefer to remain in
> single processor mode, disable the I-pipe tracer if you want to avoid
> the overhead, and re-enable priority coupling if you prefer to use it.

Re-enabling SMP is fine, but doesn't necessarily seem to improve the latenc=
y.
While I'm still having some small pikes, they keep below 60us, so that is f=
ine to me.

However, now I move on to the next problem...:
trying to attach the 6052E NI card (which is mentioned in ni_pcimio.c), usi=
ng lspci and
/usr/xenomai/sbin/analogy_config analogy0 analogy_ni_pci 0x4,1
the system either:
-freezes more or less
-outputs the error "analogy_config: attach failed err=3D-22"
but mostly it's the former reaction...

I enabled Analogy drivers (as explained here http://www.lara.unb.br/wiki/in=
dex.php/Data_Acquisition_Xenomai_Analogy)
and disabled Comedi drivers (Data acquisition support (comedi) ).

I tried another PCI connection, even another PC.

The kernel boot log seems to have some output related to a IRQ problem, how=
ever I don't really understand... Maybe this has to do with an incompatibil=
ity of Ubuntu 10.04 with a 3.10 kernel...? (also, given the strange /proc/i=
pipe/Linux file, as I mentioned before.

I find this in dmesg:
[   21.793387] irq 9: nobody cared (try booting with the "irqpoll" option)
[   21.793451] CPU: 0 PID: 266 Comm: modprobe Not tainted 3.10.0-xenomai-2.=
6.3+ #1
[   21.793459] Hardware name: Viglen D945GTP/D945GTP, BIOS NT94510J.86A.330=
9.2006.0109.1312 01/09/2006
[   21.793466]  00000000 f5409f50 c06c6e81 f5409f70 c01b1fd0 c0853a28 00000=
009 00000000
[   21.793503]  f5407900 00000000 00000009 f5409f94 c01b2183 43578610 00000=
009 c0467dc6
[   21.793538]  00000000 f5407900 00000000 f5437b80 f5409fd4 c01afe86 c09f8=
fd8 00000200
[   21.793574] Call Trace:
[   21.793594]  [<c06c6e81>] dump_stack+0x16/0x1d
[   21.793609]  [<c01b1fd0>] __report_bad_irq+0x30/0xd0
[   21.793624]  [<c01b2183>] note_interrupt+0x113/0x1c0
[   21.793639]  [<c0467dc6>] ? acpi_os_read_port+0x24/0x4c
[   21.793653]  [<c01afe86>] handle_irq_event_percpu+0xd6/0x250
[   21.793670]  [<c01b003c>] handle_irq_event+0x3c/0x60
[   21.793682]  [<c01b2c10>] ? unmask_irq+0x70/0x70
[   21.793694]  [<c01b2c54>] handle_level_irq+0x44/0xa0
[   21.793702]  <IRQ>  [<c06d152a>] ? do_IRQ+0x4a/0xd0
[   21.793726]  [<c01400fa>] ? irq_exit+0x6a/0xd0
[   21.793739]  [<c06d15f5>] ? smp_apic_timer_interrupt+0x45/0x74
[   21.793752]  [<c06d14e0>] ? return_to_handler+0xf/0xf
[   21.793766]  [<c0121a0a>] ? __ipipe_do_IRQ+0x4a/0x60
[   21.793779]  [<c06d14e0>] ? return_to_handler+0xf/0xf
[   21.793793]  [<c01a007b>] ? cgroup_addrm_files+0x1db/0x2e0
[   21.793805]  [<c01b0033>] ? handle_irq_event+0x33/0x60
[   21.793818]  [<c0121a0f>] ? __ipipe_do_IRQ+0x4f/0x60
[   21.793833]  [<c01bbe62>] ? __ipipe_do_sync_stage+0x1c2/0x200
[   21.793849]  [<c01bd1cc>] ? ipipe_unstall_root+0x5c/0x90
[   21.793861]  [<c013fe4a>] ? __do_softirq+0x6a/0x260
[   21.793878]  [<c06cdbf3>] ? sub_preempt_count+0x13/0xd0
[   21.793891]  [<c06d15b0>] ? do_IRQ+0xd0/0xd0
[   21.793903]  [<c0140155>] ? irq_exit+0xc5/0xd0
[   21.793916]  [<c06d15f5>] ? smp_apic_timer_interrupt+0x45/0x74
[   21.793929]  [<c06d14e0>] ? return_to_handler+0xf/0xf
[   21.793941]  [<c0121a0a>] ? __ipipe_do_IRQ+0x4a/0x60
[   21.793954]  [<c06d15b0>] ? do_IRQ+0xd0/0xd0
[   21.793968]  [<c01a007b>] ? cgroup_addrm_files+0x1db/0x2e0
[   21.793980]  [<c01b0033>] ? handle_irq_event+0x33/0x60
[   21.793992]  [<c0121a0f>] ? __ipipe_do_IRQ+0x4f/0x60
[   21.794006]  [<c01bbe62>] ? __ipipe_do_sync_stage+0x1c2/0x200
[   21.794022]  [<c01bbf7d>] ? __ipipe_do_sync_pipeline+0xdd/0x1b0
[   21.794036]  [<c01bd48e>] ? __ipipe_dispatch_irq+0x24e/0x550
[   21.794051]  [<c02a857e>] ? T.1997+0xae/0x6d0
[   21.794065]  [<c0121c3d>] ? __ipipe_handle_irq+0x6d/0x230
[   21.794090]  [<f835c8b7>] ? snd_device_new+0x57/0xb0 [snd]
[   21.794105]  [<c06d1440>] ? common_interrupt+0x40/0x60
[   21.794122]  [<c01bce5a>] ? ipipe_root_only+0x8a/0x150
[   21.794137]  [<c06cdbf3>] ? sub_preempt_count+0x13/0xd0
[   21.794152]  [<c0426c2a>] ? delay_tsc+0x3a/0xb0
[   21.794166]  [<c0426beb>] ? __const_udelay+0x1b/0x20
[   21.794182]  [<f80ef03a>] ? azx_get_response+0x11a/0x290 [snd_hda_intel]
[   21.794202]  [<f80ef4b7>] ? azx_probe_continue+0x107/0x3c0 [snd_hda_inte=
l]
[   21.794216]  [<c0425d95>] ? vsnprintf+0xb5/0x430
[   21.794233]  [<f80ef1b0>] ? azx_get_response+0x290/0x290 [snd_hda_intel]
[   21.794248]  [<f80eef20>] ? azx_pcm_open+0x380/0x380 [snd_hda_intel]
[   21.794262]  [<f80ef830>] ? azx_halt+0x30/0x30 [snd_hda_intel]
[   21.794277]  [<f80edd90>] ? azx_resume+0x100/0x100 [snd_hda_intel]
[   21.794291]  [<f80ee200>] ? azx_dev_free+0x20/0x20 [snd_hda_intel]
[   21.794307]  [<f80f0955>] ? azx_probe+0x2c5/0xbe4 [snd_hda_intel]
[   21.794327]  [<c0443cf8>] ? local_pci_probe+0x38/0x70
[   21.794341]  [<c0444dc0>] ? pci_device_probe+0x60/0x80
[   21.794357]  [<c04d5138>] ? driver_probe_device+0x78/0x200
[   21.794371]  [<c04d5341>] ? __driver_attach+0x81/0x90
[   21.794384]  [<c04d3ab8>] ? bus_for_each_dev+0x68/0x90
[   21.794398]  [<c04d4fae>] ? driver_attach+0x1e/0x20
[   21.794410]  [<c04d52c0>] ? driver_probe_device+0x200/0x200
[   21.794422]  [<c04d4b0f>] ? bus_add_driver+0x1bf/0x220
[   21.794436]  [<c0444c80>] ? pci_dev_put+0x20/0x20
[   21.794449]  [<c0444c80>] ? pci_dev_put+0x20/0x20
[   21.794461]  [<c04d599a>] ? driver_register+0x6a/0x140
[   21.794474]  [<c01c2d01>] ? tracepoint_module_notify+0x121/0x180
[   21.794489]  [<c0444e83>] ? __pci_register_driver+0x33/0x40
[   21.794504]  [<f8300199>] ? azx_driver_init+0x17/0x19 [snd_hda_intel]
[   21.794517]  [<c0100111>] ? do_one_initcall+0x31/0x160
[   21.794534]  [<f8300182>] ? ftrace_define_fields_azx_get_position+0xdd/0=
xdd [snd_hda_intel]
[   21.794549]  [<c0198801>] ? load_module+0x1421/0x1700
[   21.794562]  [<c01953f0>] ? free_notes_attrs+0x50/0x50
[   21.794589]  [<c0198c13>] ? SyS_init_module+0xa3/0xc0
[   21.794613]  [<c06d0f4f>] ? sysenter_do_call+0x12/0x16
[   21.794625] handlers:
[   21.794649] [<c0467d74>] acpi_irq
[   21.794683] Disabling IRQ #9


>
> --
>                                           Gilles.

-- The Open University is incorporated by Royal Charter (RC 000391), an exe=
mpt charity in England & Wales and a charity registered in Scotland (SC 038=
302).

