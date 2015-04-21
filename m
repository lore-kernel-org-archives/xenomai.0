MIME-Version: 1.0
In-Reply-To: <55267832.7010804@siemens.com>
References: <20150313171211.GH1497@hermes.click-hack.org>
 <CAPRPZsD4503Yc92d=e0jqR8HtLiV8rXo_vA2e5ea5V_gyCTOzA@mail.gmail.com>
 <20150402191555.GK31175@hermes.click-hack.org>
 <CAPRPZsCcAQCYNbVXzB5yW+hNzhLcrDLETDteFLgDLnuzz6RCsA@mail.gmail.com>
 <20150402204139.GL31175@hermes.click-hack.org>
 <CAPRPZsDr__xN4EX8hXn8Wn+j67ip+eAzEOB4so9crCuz8_E+sA@mail.gmail.com>
 <55264097.2010203@siemens.com> <5526430E.8030808@siemens.com>
 <20150409124110.GY20752@hermes.click-hack.org>
 <55267547.7080206@siemens.com>
 <20150409125838.GA20752@hermes.click-hack.org>
 <55267832.7010804@siemens.com>
Date: Tue, 21 Apr 2015 23:14:26 +0200
Message-ID: <CAPRPZsAjhPeDboNL7fdzwjm2cYVx-rVURbFzATgWi11o5f2Meg@mail.gmail.com>
From: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Sorry to tell, but it happened again after 181 hours.

Of course, we can try to disable APEI (but not in BIOS AFAICT) but
maybe it's better to find the root cause. I double checked that the
patch is included in this kernel. The disassembly shows it's there
allright. Hope you can make more out of it.

...
    if (!pte)
        return -ENOMEM;
    do {
        BUG_ON(!pte_none(*pte));
  39efb0:   0f 0b                   ud2
  39efb2:   bb f4 ff ff ff          mov    $0xfffffff4,%ebx
 * We mask the PREEMPT_NEED_RESCHED bit so as not to confuse all current users
 * that think a non-zero value indicates we cannot preempt.
 */
static __always_inline int preempt_count(void)
{
    return raw_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
  39efb7:   65 8b 04 25 00 00 00    mov    %gs:0x0,%eax
  39efbe:   00
            break;
    } while (pgd++, addr = next, addr != end);

    /* APEI may invoke this for temporarily remapping pages in IRQ or NMI
     * context - nothing we can and need to propagate globally. */
    if (!(in_irq() || in_nmi())) {
  39efbf:   a9 00 00 0f 00          test   $0xf0000,%eax
  39efc4:   75 14                   jne    39efda <ioremap_page_range+0x21a>
  39efc6:   a9 00 00 10 00          test   $0x100000,%eax
  39efcb:   75 0d                   jne    39efda <ioremap_page_range+0x21a>
        __ipipe_pin_range_globally(start, end);
  39efcd:   48 8b 75 b0             mov    -0x50(%rbp),%rsi
  39efd1:   48 8b 7d a8             mov    -0x58(%rbp),%rdi
  39efd5:   e8 00 00 00 00          callq  39efda <ioremap_page_range+0x21a>
        flush_cache_vmap(start, end);
    }

    return err;
}
...


[655067.225172] Kernel panic - not syncing: Watchdog detected hard
LOCKUP on cpu 3
[655067.225199] CPU: 3 PID: 22233 Comm: dohell Not tainted 3.16.7-cobalt #2
[655067.225216] Hardware name: Supermicro X10SAE/X10SAE, BIOS 2.0a 05/09/2014
[655067.225233]  0000000000000000 ffff88021fb86c38 ffffffff8175761d
ffffffff81a8a1e8
[655067.225257]  ffff88021fb86cb0 ffffffff81752c0e 0000000000000010
ffff88021fb86cc0
[655067.225281]  ffff88021fb86c60 0000000000000000 0000000000000003
0000000000028012
[655067.225305] Call Trace:
[655067.225312]  <NMI>  [<ffffffff8175761d>] dump_stack+0x45/0x56
[655067.225334]  [<ffffffff81752c0e>] panic+0xd8/0x20a
[655067.225350]  [<ffffffff81103f02>] watchdog_overflow_callback+0xc2/0xd0
[655067.225367]  [<ffffffff8114257d>] __perf_event_overflow+0x8d/0x230
[655067.225383]  [<ffffffff81143024>] perf_event_overflow+0x14/0x20
[655067.225400]  [<ffffffff81020326>] intel_pmu_handle_irq+0x1e6/0x400
[655067.225417]  [<ffffffff811cb501>] ? unmap_kernel_range_noflush+0x11/0x20
[655067.225435]  [<ffffffff81017f2b>] perf_event_nmi_handler+0x2b/0x50
[655067.225452]  [<ffffffff81006f68>] nmi_handle+0x88/0x120
[655067.225466]  [<ffffffff810074d9>] default_do_nmi+0x49/0x130
[655067.225481]  [<ffffffff81007690>] do_nmi+0xd0/0xf0
[655067.225495]  [<ffffffff8176175a>] end_repeat_nmi+0x1e/0x2e
[655067.225510]  [<ffffffff8175ea4d>] ? _raw_spin_lock+0x2d/0x40
[655067.225525]  [<ffffffff8175ea4d>] ? _raw_spin_lock+0x2d/0x40
[655067.225539]  [<ffffffff8175ea4d>] ? _raw_spin_lock+0x2d/0x40
[655067.225553]  <<EOE>>  [<ffffffff81046bac>]
__ipipe_pin_range_globally+0x7c/0x2b0
[655067.225576]  [<ffffffff81107751>] ? ipipe_restore_root+0x31/0x40
[655067.225592]  [<ffffffff8119c023>] ? get_page_from_freelist+0x523/0x910
[655067.225609]  [<ffffffff8139efda>] ioremap_page_range+0x21a/0x300
[655067.225625]  [<ffffffff81093eb0>] ? update_curr+0x80/0x180
[655067.225640]  [<ffffffff81455e09>] ghes_copy_tofrom_phys+0x1e9/0x200
[655067.225657]  [<ffffffff81456b70>] ? ghes_irq_func+0x20/0x20
[655067.225672]  [<ffffffff81455ea0>] ghes_read_estatus+0x80/0x160
[655067.225687]  [<ffffffff81456a64>] ghes_proc+0x14/0x80
[655067.225803]  [<ffffffff81456b82>] ghes_poll_func+0x12/0x30
[655067.225869]  [<ffffffff81064f16>] call_timer_fn+0x36/0x100
[655067.225884]  [<ffffffff81456b70>] ? ghes_irq_func+0x20/0x20
[655067.225899]  [<ffffffff810652d8>] run_timer_softirq+0x208/0x2f0
[655067.225915]  [<ffffffff8105dc45>] __do_softirq+0xe5/0x290
[655067.225929]  [<ffffffff817623b0>] ? do_IRQ+0x100/0x100
[655067.225943]  [<ffffffff8105e0bd>] irq_exit+0xbd/0xd0
[655067.226006]  [<ffffffff817623e5>] smp_apic_timer_interrupt+0x35/0x50
[655067.226023]  [<ffffffff81032e39>] __ipipe_do_IRQ+0x79/0x90
[655067.226037]  [<ffffffff817623b0>] ? do_IRQ+0x100/0x100
[655067.226050]  [<ffffffff81032e3f>] ? __ipipe_do_IRQ+0x7f/0x90
[655067.226116]  [<ffffffff811076d9>] __ipipe_do_sync_stage+0x169/0x170
[655067.226132]  [<ffffffff811077fd>] __ipipe_do_sync_pipeline+0x9d/0xa0
[655067.226147]  [<ffffffff81107bb8>] __ipipe_dispatch_irq+0x188/0x2a0
[655067.226163]  [<ffffffff81033415>] __ipipe_handle_irq+0x65/0x180
[655067.226179]  [<ffffffff81760020>] apic_timer_interrupt+0x60/0x90
[655067.226194]  [<ffffffff8175ea32>] ? _raw_spin_lock+0x12/0x40
[655067.226210]  [<ffffffff8119732e>] ? __get_free_pages+0xe/0x50
[655067.226225]  [<ffffffff8104b6d8>] pgd_alloc+0x38/0x1c0
[655067.226239]  [<ffffffff8105550a>] mm_init+0xfa/0x150
[655067.226304]  [<ffffffff81055b20>] mm_alloc+0x70/0xf0
[655067.226318]  [<ffffffff812040ce>] do_execve_common.isra.24+0x1ce/0x650
[655067.226334]  [<ffffffff81207900>] ? getname_flags+0x50/0x1a0
[655067.226349]  [<ffffffff81204799>] SyS_execve+0x29/0x30
[655067.226362]  [<ffffffff8175f5d9>] stub_execve+0x69/0xa0
[655067.226378] Kernel Offset: 0x0 from 0xffffffff81000000 (relocation
range: 0xffffffff80000000-0xffffffff9fffffff)
[655067.226402] drm_kms_helper: panic occurred, switching back to text console


Jeroen.


2015-04-09 15:01 GMT+02:00 Jan Kiszka <jan.kiszka@siemens.com>:
> On 2015-04-09 14:58, Gilles Chanteperdrix wrote:
>> On Thu, Apr 09, 2015 at 02:49:11PM +0200, Jan Kiszka wrote:
>>> On 2015-04-09 14:41, Gilles Chanteperdrix wrote:
>>>> On Thu, Apr 09, 2015 at 11:14:54AM +0200, Jan Kiszka wrote:
>>>>> On 2015-04-09 11:04, Jan Kiszka wrote:
>>>>>> On 2015-04-08 23:02, Jeroen Van den Keybus wrote:
>>>>>>> It took a while, but a hard lockup occurred on Xenomai 3.0-rc4 with
>>>>>>> Linux 3.16.7 running dohell. This time, I believe I have a trace of
>>>>>>> the locked up CPU. It's listed below and for completeness, the first
>>>>>>> part of the dmesg log is attached as well.
>>>>>>>
>>>>>>> [419215.683857] Kernel panic - not syncing: Watchdog detected hard
>>>>>>> LOCKUP on cpu 3
>>>>>>> [419215.683886] CPU: 3 PID: 18835 Comm: dohell Not tainted 3.16.7-cobalt #1
>>>>>>> [419215.683903] Hardware name: Supermicro X10SAE/X10SAE, BIOS 2.0a 05/09/2014
>>>>>>> [419215.683920]  0000000000000000 ffff88021fb86c38 ffffffff8175761d
>>>>>>> ffffffff81a8a1e8
>>>>>>> [419215.683945]  ffff88021fb86cb0 ffffffff81752c0e 0000000000000010
>>>>>>> ffff88021fb86cc0
>>>>>>> [419215.683968]  ffff88021fb86c60 0000000000000000 0000000000000003
>>>>>>> 000000000001999e
>>>>>>> [419215.684095] Call Trace:
>>>>>>> [419215.684103]  <NMI>  [<ffffffff8175761d>] dump_stack+0x45/0x56
>>>>>>> [419215.684125]  [<ffffffff81752c0e>] panic+0xd8/0x20a
>>>>>>> [419215.684141]  [<ffffffff81103f02>] watchdog_overflow_callback+0xc2/0xd0
>>>>>>> [419215.684158]  [<ffffffff8114257d>] __perf_event_overflow+0x8d/0x230
>>>>>>> [419215.684174]  [<ffffffff81143024>] perf_event_overflow+0x14/0x20
>>>>>>> [419215.684190]  [<ffffffff81020326>] intel_pmu_handle_irq+0x1e6/0x400
>>>>>>> [419215.684259]  [<ffffffff811cb501>] ? unmap_kernel_range_noflush+0x11/0x20
>>>>>>> [419215.684277]  [<ffffffff81017f2b>] perf_event_nmi_handler+0x2b/0x50
>>>>>>> [419215.684293]  [<ffffffff81006f68>] nmi_handle+0x88/0x120
>>>>>>> [419215.684308]  [<ffffffff8100755e>] default_do_nmi+0xce/0x130
>>>>>>> [419215.684373]  [<ffffffff81007690>] do_nmi+0xd0/0xf0
>>>>>>> [419215.684387]  [<ffffffff8176175a>] end_repeat_nmi+0x1e/0x2e
>>>>>>> [419215.684402]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
>>>>>>> [419215.684417]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
>>>>>>> [419215.684431]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
>>>>>>> [419215.684445]  <<EOE>>  [<ffffffff81046bac>]
>>>>>>> __ipipe_pin_range_globally+0x7c/0x2b0
>>>>>>> [419215.684468]  [<ffffffff8139efe6>] ioremap_page_range+0x226/0x300
>>>>>>> [419215.684485]  [<ffffffff8114e90a>] ? xnintr_core_clock_handler+0x2ea/0x310
>>>>>>> [419215.684553]  [<ffffffff81093eb0>] ? update_curr+0x80/0x180
>>>>>>> [419215.684568]  [<ffffffff81455e09>] ghes_copy_tofrom_phys+0x1e9/0x200
>>>>>>
>>>>>> OK, maybe it is related to ACPI APEI, maybe that is just triggering an
>>>>>> I-pipe bug. But could you try to disable that feature and see if the
>>>>>> issue still appears?
>>>>>>
>>>>>> I'll meanwhile dig deeper and try to understand what could cause a lockup.
>>>>>
>>>>> Oh, the bug is obvious (and would have been reported when turning on
>>>>> CONFIG_PROVE_LOCKING): We are calling __ipipe_pin_range_globally from
>>>>> IRQ context here, but that only uses spin_lock.
>>>>
>>>> ipipe_pin_range_globally is called in case of vmalloc or ioremap. Is
>>>> there really any code which calls vmalloc or ioremap from irq
>>>> context ? I doubt that very much.
>>>
>>> Just need to look at the backtrace.
>>
>> Is the mapping done this way permanent, or just temporary, for the
>> duration of the irq ? Because if done temporarily, we might as
>> well just skip ipipe_pin_range_globally in this case: the mm context
>> is not going to change under an irq handler's feet.
>
> I strongly suspect it is the same kind of mapping we already exclude
> with the NMI test: temporary. But I still need to look at the details.
>
> Converting all pgd_lock into irqsave would also mean including all
> pgt_lock sites, and I have a bad feeling about potential side effects of
> such changes, at least on the long-term.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RTC ITP SES-DE
> Corporate Competence Center Embedded Linux

