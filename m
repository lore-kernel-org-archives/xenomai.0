Message-ID: <fd6a47a90711120739n11b803cfy8bc4b8b09a995fef@domain.hid>
Date: Mon, 12 Nov 2007 16:39:37 +0100
From: "Jeroen Van den Keybus" <jeroen.vandenkeybus@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_24428_2088178.1194881978004"
Subject: [Xenomai-core] Long execution time inside
	__ipipe_unstall_iret_root()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

------=_Part_24428_2088178.1194881978004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have a setup which apparently suffers from long interrupt-disabled
sections during heavy load (make -j16 of a kernel). I have instrumented the
__ipipe_unstall_iret_root() function with the tracer as follows:


asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)
{
    ipipe_trace_special(0x20, 0);
    ipipe_declare_cpuid;

    /* Emulate IRET's handling of the interrupt flag. */

    ipipe_trace_special(0x21, 0);
    local_irq_disable_hw();

    ipipe_trace_special(0x22, 0);
    ipipe_load_cpuid();

    /* Restore the software state as it used to be on kernel
       entry. CAUTION: NMIs must *not* return through this
       emulation. */

    ipipe_trace_special(0x23, 0);
    if (!(regs.eflags & X86_EFLAGS_IF)) {
        ipipe_trace_special(0x24, 0);
        if (!__test_and_set_bit(IPIPE_STALL_FLAG,
                    &ipipe_root_domain->cpudata[cpuid].status))
            trace_hardirqs_off();
        regs.eflags |= X86_EFLAGS_IF;
        ipipe_trace_special(0x25, 0);
    } else {
        ipipe_trace_special(0x26, 0);
        if (test_bit(IPIPE_STALL_FLAG,
                 &ipipe_root_domain->cpudata[cpuid].status)) {
            trace_hardirqs_on();
            __clear_bit(IPIPE_STALL_FLAG,
                    &ipipe_root_domain->cpudata[cpuid].status);
        }
        ipipe_trace_special(0x27, 0);

        /* Only sync virtual IRQs here, so that we don't recurse
           indefinitely in case of an external interrupt flood. */

        if ((ipipe_root_domain->cpudata[cpuid].
             irq_pending_hi & IPIPE_IRQMASK_VIRT) != 0) {
            ipipe_trace_special(0x28, 0);
            __ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
        }
        ipipe_trace_special(0x29, 0);
    }
#ifdef CONFIG_IPIPE_TRACE_IRQSOFF
    ipipe_trace_end(0x8000000D);
#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */
}

While under heavy load, the following trace log is produced:

...



   + func                -116    0.124  xnarch_get_cpu_time+0x8
(rtdm_toseq_init+0x21)
    + func                -116    0.169  xnarch_tsc_to_ns+0x12
(xnarch_get_cpu_time+0xf)
    + func                -116    0.284  rtdm_event_timedwait+0xe
(rt_e1000_read+0xf5 [rt_e1000])
 |  # func                -115    0.189  xnsynch_sleep_on+0xe
(rtdm_event_timedwait+0x141)
 |  # func                -115    0.184  xnpod_suspend_thread+0xe
(xnsynch_sleep_on+0x3bf)
 |  # func                -115    0.194  xntimer_migrate+0xe
(xnpod_suspend_thread+0xa2)
 |  # func                -115    0.144  xntimer_start_aperiodic+0xe
(xnpod_suspend_thread+0xc5)
 |  # func                -115    0.334  xnarch_ns_to_tsc+0x14
(xntimer_start_aperiodic+0x63)
 |  # func                -114    0.199  xnpod_schedule+0xe
(xnpod_suspend_thread+0x237)
 |  # [18006] -<?>-   99  -114    0.814  xnpod_schedule+0x176
(xnpod_suspend_thread+0x237)
 |  # func                -113    0.874  __switch_to+0xe
(xnpod_schedule+0x77c)
 |  # [18019] -<?>-   -1  -112    0.799  xnpod_schedule+0x887
(xnintr_irq_handler+0x18e)
 |   +func                -112    0.319  __ipipe_walk_pipeline+0xb
(__ipipe_handle_irq+0x87)
 |   #func                -111    0.204  __ipipe_stall_root+0x8
(resume_userspace+0x5)
     #func                -111    0.134  __ipipe_unstall_iret_root+0xa
(restore_nocheck_notrace+0x0)
     #(0x20)  0x00000000  -111    0.119  __ipipe_unstall_iret_root+0x19
(restore_nocheck_notrace+0x0)
     #(0x21)  0x00000000  -111    0.124  __ipipe_unstall_iret_root+0x25
(restore_nocheck_notrace+0x0)
 |   #(0x22)  0x00000000  -111    0.119  __ipipe_unstall_iret_root+0x32
(restore_nocheck_notrace+0x0)
 |   #(0x23)  0x00000000  -111    0.119  __ipipe_unstall_iret_root+0x45
(restore_nocheck_notrace+0x0)
 |   #(0x26)  0x00000000  -110    0.134  __ipipe_unstall_iret_root+0x88
(restore_nocheck_notrace+0x0)
 |   +(0x27)  0x00000000  -110    0.109  __ipipe_unstall_iret_root+0x9e
(restore_nocheck_notrace+0x0)
 |   +(0x29)  0x00000000  -110   57.850  __ipipe_unstall_iret_root+0xb6
(restore_nocheck_notrace+0x0)
 |   +func                 -52    0.289  __ipipe_handle_irq+0xe
(ipipe_ipi3+0x26)
 |   +func                 -52    0.169  __ipipe_ack_apic+0x8
(__ipipe_handle_irq+0xbf)
 |   +func                 -52    0.154  __ipipe_dispatch_wired+0x14
(__ipipe_handle_irq+0x5f)
 |  # func                 -52    0.309  xnintr_clock_handler+0xe
(__ipipe_dispatch_wired+0xbe)
 |  # func                 -51    0.494  xntimer_tick_aperiodic+0xe
(xnintr_clock_handler+0x72)
 |  # func                 -51    0.459  xntimer_next_local_shot+0x16
(xntimer_tick_aperiodic+0x170)
 |  # func                 -50    0.154  rthal_irq_host_pend+0x8
(xnintr_clock_handler+0x131)
 |  # func                 -50    0.684  __ipipe_schedule_irq+0xb
(rthal_irq_host_pend+0x29)
 |   +func                 -50    0.294  __ipipe_walk_pipeline+0xb
(__ipipe_handle_irq+0x87)
 |   +func                 -49    0.309  __ipipe_sync_stage+0xe
(__ipipe_walk_pipeline+0xcb)
     #func                 -49    0.299  smp_apic_timer_interrupt+0x11
(__ipipe_sync_stage+0x17b)

This system apparently has an irq-free section of 62 us. Strangely,
ipipe_special_trace(0x28) is not executed, so the delay is incurred only in
the evaluation of

(ipipe_root_domain->cpudata[cpuid].irq_pending_hi & IPIPE_IRQMASK_VIRT) != 0

I don't quite understand this. What could be going on here ?



Jeroen.

------=_Part_24428_2088178.1194881978004
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I have a setup which apparently suffers from long interrupt-disabled sections during heavy load (make -j16 of a kernel). I have instrumented the __ipipe_unstall_iret_root() function with the tracer as follows:</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>asmlinkage void __ipipe_unstall_iret_root(struct pt_regs regs)<br>{<br>&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x20, 0);<br>&nbsp;&nbsp;&nbsp; ipipe_declare_cpuid;</div>
<div>
<p>&nbsp;&nbsp;&nbsp; /* Emulate IRET&#39;s handling of the interrupt flag. */</p>
<p>&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x21, 0);<br>&nbsp;&nbsp;&nbsp; local_irq_disable_hw();</p>
<p>&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x22, 0);<br>&nbsp;&nbsp;&nbsp; ipipe_load_cpuid();</p>
<p>&nbsp;&nbsp;&nbsp; /* Restore the software state as it used to be on kernel<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry. CAUTION: NMIs must *not* return through this<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; emulation. */</p>
<p>&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x23, 0);<br>&nbsp;&nbsp;&nbsp; if (!(regs.eflags &amp; X86_EFLAGS_IF)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x24, 0);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!__test_and_set_bit(IPIPE_STALL_FLAG,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ipipe_root_domain-&gt;cpudata[cpuid].status))
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_hardirqs_off();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs.eflags |= X86_EFLAGS_IF;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x25, 0);<br>&nbsp;&nbsp;&nbsp; } else {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x26, 0);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (test_bit(IPIPE_STALL_FLAG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ipipe_root_domain-&gt;cpudata[cpuid].status)) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_hardirqs_on();<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __clear_bit(IPIPE_STALL_FLAG,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ipipe_root_domain-&gt;cpudata[cpuid].status);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x27, 0);</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only sync virtual IRQs here, so that we don&#39;t recurse<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indefinitely in case of an external interrupt flood. */</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ipipe_root_domain-&gt;cpudata[cpuid].<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_pending_hi &amp; IPIPE_IRQMASK_VIRT) != 0) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x28, 0);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __ipipe_sync_pipeline(IPIPE_IRQMASK_VIRT);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ipipe_trace_special(0x29, 0);<br>&nbsp;&nbsp;&nbsp; }<br>#ifdef CONFIG_IPIPE_TRACE_IRQSOFF<br>&nbsp;&nbsp;&nbsp; ipipe_trace_end(0x8000000D);<br>#endif /* CONFIG_IPIPE_TRACE_IRQSOFF */<br>}<br></p>
<p>While under heavy load, the following trace log is produced:</p>
<p>...</p>
<p>&nbsp;</p>
<p>&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -116&nbsp;&nbsp;&nbsp; 0.124&nbsp; xnarch_get_cpu_time+0x8 (rtdm_toseq_init+0x21)<br>&nbsp;&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -116&nbsp;&nbsp;&nbsp; 0.169&nbsp; xnarch_tsc_to_ns+0x12 (xnarch_get_cpu_time+0xf)<br>&nbsp;&nbsp;&nbsp; + func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -116&nbsp;&nbsp;&nbsp; 0.284
&nbsp; rtdm_event_timedwait+0xe (rt_e1000_read+0xf5 [rt_e1000])<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -115&nbsp;&nbsp;&nbsp; 0.189&nbsp; xnsynch_sleep_on+0xe (rtdm_event_timedwait+0x141)<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -115&nbsp;&nbsp;&nbsp; 0.184&nbsp; xnpod_suspend_thread+0xe (xnsynch_sleep_on+0x3bf)
<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -115&nbsp;&nbsp;&nbsp; 0.194&nbsp; xntimer_migrate+0xe (xnpod_suspend_thread+0xa2)<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -115&nbsp;&nbsp;&nbsp; 0.144&nbsp; xntimer_start_aperiodic+0xe (xnpod_suspend_thread+0xc5)<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -115&nbsp;&nbsp;&nbsp; 
0.334&nbsp; xnarch_ns_to_tsc+0x14 (xntimer_start_aperiodic+0x63)<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -114&nbsp;&nbsp;&nbsp; 0.199&nbsp; xnpod_schedule+0xe (xnpod_suspend_thread+0x237)<br>&nbsp;|&nbsp; # [18006] -&lt;?&gt;-&nbsp;&nbsp; 99&nbsp; -114&nbsp;&nbsp;&nbsp; 0.814&nbsp; xnpod_schedule+0x176 (xnpod_suspend_thread+0x237)
<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -113&nbsp;&nbsp;&nbsp; 0.874&nbsp; __switch_to+0xe (xnpod_schedule+0x77c)<br>&nbsp;|&nbsp; # [18019] -&lt;?&gt;-&nbsp;&nbsp; -1&nbsp; -112&nbsp;&nbsp;&nbsp; 0.799&nbsp; xnpod_schedule+0x887 (xnintr_irq_handler+0x18e)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -112&nbsp;&nbsp;&nbsp; 0.319
&nbsp; __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x87)<br>&nbsp;|&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -111&nbsp;&nbsp;&nbsp; 0.204&nbsp; __ipipe_stall_root+0x8 (resume_userspace+0x5)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -111&nbsp;&nbsp;&nbsp; 0.134&nbsp; __ipipe_unstall_iret_root+0xa (restore_nocheck_notrace+0x0)
<br>&nbsp;&nbsp;&nbsp;&nbsp; #(0x20)&nbsp; 0x00000000&nbsp; -111&nbsp;&nbsp;&nbsp; 0.119&nbsp; __ipipe_unstall_iret_root+0x19 (restore_nocheck_notrace+0x0)<br>&nbsp;&nbsp;&nbsp;&nbsp; #(0x21)&nbsp; 0x00000000&nbsp; -111&nbsp;&nbsp;&nbsp; 0.124&nbsp; __ipipe_unstall_iret_root+0x25 (restore_nocheck_notrace+0x0)<br>&nbsp;|&nbsp;&nbsp; #(0x22)&nbsp; 0x00000000&nbsp; -111&nbsp;&nbsp;&nbsp; 
0.119&nbsp; __ipipe_unstall_iret_root+0x32 (restore_nocheck_notrace+0x0)<br>&nbsp;|&nbsp;&nbsp; #(0x23)&nbsp; 0x00000000&nbsp; -111&nbsp;&nbsp;&nbsp; 0.119&nbsp; __ipipe_unstall_iret_root+0x45 (restore_nocheck_notrace+0x0)<br>&nbsp;|&nbsp;&nbsp; #(0x26)&nbsp; 0x00000000&nbsp; -110&nbsp;&nbsp;&nbsp; 0.134&nbsp; __ipipe_unstall_iret_root+0x88 (restore_nocheck_notrace+0x0)
<br>&nbsp;|&nbsp;&nbsp; +(0x27)&nbsp; 0x00000000&nbsp; -110&nbsp;&nbsp;&nbsp; 0.109&nbsp; __ipipe_unstall_iret_root+0x9e (restore_nocheck_notrace+0x0)<br>&nbsp;|&nbsp;&nbsp; +(0x29)&nbsp; 0x00000000&nbsp; -110&nbsp;&nbsp; 57.850&nbsp; __ipipe_unstall_iret_root+0xb6 (restore_nocheck_notrace+0x0)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nbsp;&nbsp; 
0.289&nbsp; __ipipe_handle_irq+0xe (ipipe_ipi3+0x26)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nbsp;&nbsp; 0.169&nbsp; __ipipe_ack_apic+0x8 (__ipipe_handle_irq+0xbf)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nbsp;&nbsp; 0.154&nbsp; __ipipe_dispatch_wired+0x14 (__ipipe_handle_irq+0x5f)
<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -52&nbsp;&nbsp;&nbsp; 0.309&nbsp; xnintr_clock_handler+0xe (__ipipe_dispatch_wired+0xbe)<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -51&nbsp;&nbsp;&nbsp; 0.494&nbsp; xntimer_tick_aperiodic+0xe (xnintr_clock_handler+0x72)<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -51&nbsp;&nbsp;&nbsp; 
0.459&nbsp; xntimer_next_local_shot+0x16 (xntimer_tick_aperiodic+0x170)<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -50&nbsp;&nbsp;&nbsp; 0.154&nbsp; rthal_irq_host_pend+0x8 (xnintr_clock_handler+0x131)<br>&nbsp;|&nbsp; # func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -50&nbsp;&nbsp;&nbsp; 0.684&nbsp; __ipipe_schedule_irq+0xb (rthal_irq_host_pend+0x29)
<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -50&nbsp;&nbsp;&nbsp; 0.294&nbsp; __ipipe_walk_pipeline+0xb (__ipipe_handle_irq+0x87)<br>&nbsp;|&nbsp;&nbsp; +func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -49&nbsp;&nbsp;&nbsp; 0.309&nbsp; __ipipe_sync_stage+0xe (__ipipe_walk_pipeline+0xcb)<br>&nbsp;&nbsp;&nbsp;&nbsp; #func&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -49&nbsp;&nbsp;&nbsp; 
0.299&nbsp; smp_apic_timer_interrupt+0x11 (__ipipe_sync_stage+0x17b)<br></p>
<p>This system apparently has an irq-free section of 62 us. Strangely, ipipe_special_trace(0x28) is not executed, so the delay is incurred only in the evaluation of </p>
<p>(ipipe_root_domain-&gt;cpudata[cpuid].irq_pending_hi &amp; IPIPE_IRQMASK_VIRT) != 0</p>
<p>I don&#39;t quite understand this. What&nbsp;could be&nbsp;going on here ?</p>
<p>&nbsp;</p>
<p>Jeroen.</p></div>

------=_Part_24428_2088178.1194881978004--

