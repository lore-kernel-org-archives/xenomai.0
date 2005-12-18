Message-ID: <43A5AACF.6050505@domain.hid>
Date: Sun, 18 Dec 2005 19:30:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug] don't try this at home...
References: <438DD4E2.9080208@domain.hid>	<438DE166.5090303@domain.hid>	<438DE551.7080708@domain.hid>
	<43A32305.8030004@domain.hid> <43A329E6.3080505@domain.hid>
	<43A34F6C.6020904@domain.hid> <43A56A44.6020308@domain.hid>
In-Reply-To: <43A56A44.6020308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Philippe Gerum wrote:
> 
>>>>...
>>>>Fixed. The cause was related to the thread migration routine to
>>>>primary mode (xnshadow_harden), which would spuriously call the Linux
>>>>rescheduling procedure from the primary domain under certain
>>>>circumstances. This bug only triggers on preemptible kernels. This
>>>>also fixes the spinlock recursion issue which is sometimes triggered
>>>>when the spinlock debug option is active.
>>>>
>>>
>>>Gasp. I've found a severe regression with this fix, so more work is
>>>needed. More later.
>>>
>>
>>End of alert. Should be ok now.
>>
> 
> 
> No crashes so far, looks good. But the final test, a box which always
> went to hell very quickly, is still waiting in my office - more on Monday.
> 
> Anyway, there seems to be some latency issues pending. I discovered this
> again with my migration test. Please give it a try on a mid- (800 MHz
> Athlon in my case) to low-end box. On that Athlon I got peaks of over
> 100 us in the userspace latency test right on starting migration. The
> Athlon does not support the NMI watchdog, but on my 1.4 GHz Notebook
> there were alarms (>30 us) hitting in the native registry during
> rt_task_create. I have no clue yet if anything is broken there.

I suspect that rt_registry_enter() is inherently a long operation when 
considered as a non-preemptible sum of reasonably short ones. Since it 
is always called with interrupts enabled, we should split the work in 
there, releasing interrupts in the middle. The tricky thing is that we 
must ensure that the new registration slot is not exposed in a 
half-baked state during the preemptible section.

> We need
> that back-tracer soon - did I mentioned this before? ;)

Well, we have a backtrace support for detecting latency peaks, but it's 
dependent on NMI availability. The thing is that not every platform 
provides a programmable NMI support. A possible option would be to 
overload the existing LTT tracepoints in order to keep an execution 
backtrace, so that we would not have to rely on any hw support.

> 
> BTW, a kernel timer latency test based on a RTDM device is half-done.
> I'm able to dump kernel-based timed-task latencies via a patched
> testsuite latency. Histograms need to be added as well as a timer
> handler latency test. Will keep you posted.
> 

Ack. This would also cleanly solve the 
"where-am-i-going-to-put-that-stuff" issue wrt the latency kernel module 
the user-space section cannot/should not have to compile anymore in 2.1. 
I guess that moving it to the ksrc/drivers/ section would then be the 
most natural thing to do.

> Jan


-- 

Philippe.

