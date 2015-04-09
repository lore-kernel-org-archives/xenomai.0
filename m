Message-ID: <552645CA.6070601@siemens.com>
Date: Thu, 09 Apr 2015 11:26:34 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54F56C9C.6080507@siemens.com>	<CAPRPZsC9mPitPUmXXR6QQfAGN3UMa2u6hkVwjtO4Eoh-NzC7wA@mail.gmail.com>	<54FDB495.3060303@triphase.com>	<5501FC89.2040205@siemens.com>	<20150313163431.GE1497@hermes.click-hack.org>	<550319B3.1050902@siemens.com>	<20150313171211.GH1497@hermes.click-hack.org>	<CAPRPZsD4503Yc92d=e0jqR8HtLiV8rXo_vA2e5ea5V_gyCTOzA@mail.gmail.com>	<20150402191555.GK31175@hermes.click-hack.org>	<CAPRPZsCcAQCYNbVXzB5yW+hNzhLcrDLETDteFLgDLnuzz6RCsA@mail.gmail.com>	<20150402204139.GL31175@hermes.click-hack.org>
 <CAPRPZsDr__xN4EX8hXn8Wn+j67ip+eAzEOB4so9crCuz8_E+sA@mail.gmail.com>
 <55264097.2010203@siemens.com> <5526430E.8030808@siemens.com>
In-Reply-To: <5526430E.8030808@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xeno3_rc3 - Watchdog detected hard LOCKUP
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-04-09 11:14, Jan Kiszka wrote:
> On 2015-04-09 11:04, Jan Kiszka wrote:
>> On 2015-04-08 23:02, Jeroen Van den Keybus wrote:
>>> It took a while, but a hard lockup occurred on Xenomai 3.0-rc4 with
>>> Linux 3.16.7 running dohell. This time, I believe I have a trace of
>>> the locked up CPU. It's listed below and for completeness, the first
>>> part of the dmesg log is attached as well.
>>>
>>> [419215.683857] Kernel panic - not syncing: Watchdog detected hard
>>> LOCKUP on cpu 3
>>> [419215.683886] CPU: 3 PID: 18835 Comm: dohell Not tainted 3.16.7-cobalt #1
>>> [419215.683903] Hardware name: Supermicro X10SAE/X10SAE, BIOS 2.0a 05/09/2014
>>> [419215.683920]  0000000000000000 ffff88021fb86c38 ffffffff8175761d
>>> ffffffff81a8a1e8
>>> [419215.683945]  ffff88021fb86cb0 ffffffff81752c0e 0000000000000010
>>> ffff88021fb86cc0
>>> [419215.683968]  ffff88021fb86c60 0000000000000000 0000000000000003
>>> 000000000001999e
>>> [419215.684095] Call Trace:
>>> [419215.684103]  <NMI>  [<ffffffff8175761d>] dump_stack+0x45/0x56
>>> [419215.684125]  [<ffffffff81752c0e>] panic+0xd8/0x20a
>>> [419215.684141]  [<ffffffff81103f02>] watchdog_overflow_callback+0xc2/0xd0
>>> [419215.684158]  [<ffffffff8114257d>] __perf_event_overflow+0x8d/0x230
>>> [419215.684174]  [<ffffffff81143024>] perf_event_overflow+0x14/0x20
>>> [419215.684190]  [<ffffffff81020326>] intel_pmu_handle_irq+0x1e6/0x400
>>> [419215.684259]  [<ffffffff811cb501>] ? unmap_kernel_range_noflush+0x11/0x20
>>> [419215.684277]  [<ffffffff81017f2b>] perf_event_nmi_handler+0x2b/0x50
>>> [419215.684293]  [<ffffffff81006f68>] nmi_handle+0x88/0x120
>>> [419215.684308]  [<ffffffff8100755e>] default_do_nmi+0xce/0x130
>>> [419215.684373]  [<ffffffff81007690>] do_nmi+0xd0/0xf0
>>> [419215.684387]  [<ffffffff8176175a>] end_repeat_nmi+0x1e/0x2e
>>> [419215.684402]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
>>> [419215.684417]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
>>> [419215.684431]  [<ffffffff8175ea4a>] ? _raw_spin_lock+0x2a/0x40
>>> [419215.684445]  <<EOE>>  [<ffffffff81046bac>]
>>> __ipipe_pin_range_globally+0x7c/0x2b0
>>> [419215.684468]  [<ffffffff8139efe6>] ioremap_page_range+0x226/0x300
>>> [419215.684485]  [<ffffffff8114e90a>] ? xnintr_core_clock_handler+0x2ea/0x310
>>> [419215.684553]  [<ffffffff81093eb0>] ? update_curr+0x80/0x180
>>> [419215.684568]  [<ffffffff81455e09>] ghes_copy_tofrom_phys+0x1e9/0x200
>>
>> OK, maybe it is related to ACPI APEI, maybe that is just triggering an
>> I-pipe bug. But could you try to disable that feature and see if the
>> issue still appears?
>>
>> I'll meanwhile dig deeper and try to understand what could cause a lockup.
> 
> Oh, the bug is obvious (and would have been reported when turning on
> CONFIG_PROVE_LOCKING): We are calling __ipipe_pin_range_globally from
> IRQ context here, but that only uses spin_lock.
> 
> Here is a quick fix for testing purposes (the function requires some
> consolidating cleanup):
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 10abc67..0aba29c 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1318,10 +1318,11 @@ void __ipipe_pin_range_globally(unsigned long start, unsigned long end)
>  	int ret = 0;
>  
>  	do {
> +		unsigned long flags;
>  		struct page *page;
>  
>  		next = pgd_addr_end(addr, end);
> -		spin_lock(&pgd_lock);
> +		spin_lock_irqsave(&pgd_lock, flags);
>  		list_for_each_entry(page, &pgd_list, lru) {
>  			pgd_t *pgd;
>  			pgd = (pgd_t *)page_address(page) + pgd_index(addr);
> @@ -1329,7 +1330,7 @@ void __ipipe_pin_range_globally(unsigned long start, unsigned long end)
>  			if (ret)
>  				break;
>  		}
> -		spin_unlock(&pgd_lock);
> +		spin_unlock_irqrestore(&pgd_lock, flags);
>  		addr = next;
>  	} while (!ret && addr != end);
>  #endif
> 
> Interestingly, legacy X86_32 was already using irqsave/restore.

But all this doesn't help (also on 32-bit) as long as pgd_lock is not
consistently taken with irq protection. So my quick patch is incomplete
or even not applicable at all, but my workaround suggest (APEI
disabling) remains valid.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

