References: <8cb23a1388df4237bd2b132fe0addd83@ocnapvsw3301.ocr.priv>
 <988_1524033866_5AD6E94A_988_16165_1_c7507d3b-9477-e834-e0e4-f8f7dee397c1@siemens.com>
 <58a11549a6554c2580f9977b05ae8c13@ocnapvsw3301.ocr.priv>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d6f7f5ce-acf9-a4c7-58d7-60980b51fcbc@siemens.com>
Date: Wed, 18 Apr 2018 18:02:42 +0200
MIME-Version: 1.0
In-Reply-To: <58a11549a6554c2580f9977b05ae8c13@ocnapvsw3301.ocr.priv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] R: kernel panic - xenomai3.0.6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-04-18 17:46, Fazio Maurizio wrote:
> Hello Jan,
> Thanks for the reply but at the moment I cannot upgrade the kernel version of the system :(
> 
> I executed the application with kdump service enabled. I attached the vmcore-dmesg file.
> Comparing the vmcore-dmesg call trace at the end of the file with the call trace I see on the screen, there are other lines I don't see into the file.
> The following is the complete call trace :
> [  368.501209] Kernel panic - not syncing: Watchdog detected hard LOCKUP on cpu 2
> [  368.501264] CPU: 2 PID: 14486 Comm: EXE_milbus Tainted: P           OE  3.18.20-xenomai #1
> [  368.501316] Hardware name: Concurrent Technologies VME SBC/VP B1x/msd, BIOS 3.11.01 09/19/2016 [  368.501371]  0000000000000000 00000000ab624b87 ffff88041f705c08 ffffffff815e856f [  368.501425]  0000000000000000 ffffffff817e12f8 ffff88041f705c88 ffffffff815e24ff [  368.501479]  0000000000000010 ffff88041f705c98 ffff88041f705c38 00000000ab624b87 [  368.501532] Call Trace:
> [  368.501549]  <NMI>  [<ffffffff815e856f>] dump_stack+0x46/0x58 [  368.501597]  [<ffffffff815e24ff>] panic+0xdb/0x20d [  368.501631]  [<ffffffff8110aca0>] ? restart_watchdog_hrtimer+0x50/0x50
> [  368.501675]  [<ffffffff8110ad5a>] watchdog_overflow_callback+0xba/0xc0
> [  368.501718]  [<ffffffff8112038d>] __perf_event_overflow+0x9d/0x250 [  368.501759]  [<ffffffff81120cc4>] perf_event_overflow+0x14/0x20 [  368.501798]  [<ffffffff8101fc09>] intel_pmu_handle_irq+0x1f9/0x420 [  368.501840]  [<ffffffff81017bab>] perf_event_nmi_handler+0x2b/0x50 [  368.501881]  [<ffffffff81006b9b>] nmi_handle+0x7b/0xe0 [  368.501916]  [<ffffffff810070c4>] default_do_nmi+0x44/0x130 [  368.501953]  [<ffffffff81007280>] do_nmi+0xd0/0xf0 [  368.501986]  [<ffffffff815f13ca>] end_repeat_nmi+0x1e/0x2e ? ktime_get ? ktime_get ? ktime_get
> <<EOE>>   tick_irq_enter
> irq_enter
> __ipipe_do_sync_stage
> __ipipe_do_sync_pipeline
> dispatch_irq_head
> __ipipe_dispatch_irq
> __ipipe_handle_irq
> apic_timer_interrupt
> ? __ipipe_halt_root
> ? mwait_idle
> arch_cpu_idle
> cpu_startup_entry
> start_secondary
> 

OK, is the system actually locked up at that point - or is the Linux
watchdog just upset that your real-time application is stealing too much
time from Linux?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

