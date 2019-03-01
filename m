Subject: Re: Periodic timing varies across boots
References: <CA+K1mPFRVPqD_Gg2_7_PqcpegJ+ADJm3hea2AHxiHzwwBBG_iw@mail.gmail.com>
 <3d5044db-0b5c-fe4a-480c-b50943d440e5@siemens.com>
 <CA+K1mPEfLdrvGOqnX+1F6omFQq-CT75v2-5qTXF8Rj8NY=mHrQ@mail.gmail.com>
 <e557148a-392d-3c8e-615e-58c60c03e6e1@xenomai.org>
 <CA+K1mPENXX69Y+fF39dDXR1+pikeakcqKYkVfow-mD-QJcDJmw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <056086d0-c53a-4494-7db5-224dcc325071@xenomai.org>
Date: Fri, 1 Mar 2019 09:05:30 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPENXX69Y+fF39dDXR1+pikeakcqKYkVfow-mD-QJcDJmw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: C Smith <csmithquestions@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 3/1/19 8:30 AM, C Smith wrote:
> On Wed, Feb 27, 2019 at 11:30 PM Philippe Gerum <rpm@xenomai.org
> <mailto:rpm@xenomai.org>> wrote:
> 
>     On 2/28/19 6:56 AM, C Smith via Xenomai wrote:
>     > On Mon, Feb 25, 2019 at 12:09 AM Jan Kiszka
>     <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>> wrote:
>     >
>     >> On 24.02.19 07:57, C Smith via Xenomai wrote:
>     >>> I am using Xenomai 2.6.5, x86 32bit SMP kernel 3.18.20, Intel Core
>     >>> i5-4460,  and I have found a periodic timing problem on one
>     particular
>     >> type
>     >>> of motherboard.
>     >>>
>     >>> I have a Xenomai RT periodic task which outputs a pulse to the PC
>     >> parallel
>     >>> port, and this pulse is measured on a frequency counter. This
>     has been
>     >>> working fine for years on several motherboards. I am able to
>     adjust the
>     >>> period of my task to within +/-10nsec, according to the frequency
>     >> counter.
>     >>> I can calibrate the periodic timing down to a period +/-10nsec
>     on this
>     >>> motherboard, and I cna restart my xenomai process many times and the
>     >> timing
>     >>> is fine. But if I cold-reboot the machine the measured period is
>     wrong by
>     >>> up to  +/-300nsec. Thus I cannot get consistent periodic timing
>     from day
>     >> to
>     >>> day without recalibrating, which is unacceptable in my application.
>     >>>
>     >>> In my kernel config, I am using the TSC: CONFIG_X86_TSC=y
>     >>> I use rt_timer_read() to determine what time it is, and my
>     periodic task
>     >>> sleeps in a while loop, like this:
>     >>>        next += period_ns + adjust_ns;
>     >>>        rt_task_sleep_until(next);
>     >>>
>     >>> I don't know what to test. Can you suggest anything?
>     >> Stéphane Ancelot said:
>     >> Your problem seems being related to SMI interrupts rising.
>     >> According to your chipset , Program xenomai  kernel SMI registers in
>     >> boot options ,  in order to avoid this problem.
>     >> Regards,
>     >> S.Ancelot
>     >>
>     >
>     >> Can you reproduce the issue with a supported Xenomai and kernel
>     version?
>     >>
>     >> Jan
>     >>
>     >>
>     > We have tens of thousands of legacy code so I must use Xenomai
>     2.6.5 - we
>     > will endeavor to got to Xenomai 3.x next year.
>     > Per your suggestion I could try writing a stripped-down periodic
>     app and
>     > booting into Xenomai 3 for a test though... I'll do that soon and
>     let you
>     > know how it goes.
>     > I doubt there is anything wrong with Xenomai 2.6.5 though. My periodic
>     > timing worked fine with 3 other motherboards and this same
>     > Xeno kernel, but I must use this motherboard because of its form
>     factor
>     > (and we spent months qualifying it).
>     >
>     > First, I am exploring what Stephane A. said above, where he
>     suspects SMI
>     > interference.
>     > I did try adding xeno_hal.smi=1 to my kernel boot options, but I
>     get this
>     > in dmesg at boot:
>     >   Xenomai: SMI-enabled chipset found
>     >   Xenomai: SMI workaround failed!
>     > So I guess I can't solve the problem that way.
> 
>     It looks so. At the very least, this motherboard denied global disabling
>     of SMIs to the Xenomai core (which current motherboards do anyway).
>     Maybe disabling of specific SMI sources could be achieved, but finding
>     which ones should and could be masked would be required.
> 
>     > My periodic timing is not fixed by this attempt either.
>     > Note that during boot I see: "CPU0: Thermal monitoring handled by SMI"
>     >
> 
>     This may be a hint. Thermal monitoring in BIOS is a known source of
>     latency on x86.
> 
>     > I also ran the 'latency' regression test and it does not show large
>     > latencies, they are <= 2.6 usec.
>     > * Does that indicate SMI is not interrupting my process?
> 
>     How long did it run? You may need to run this test for an hour to be
>     sure, while the system is stressed by some other workload. switchtest -s
>     200 for instance. And/or a kernel build on all of your 4 cores if
>     possible, to lower the odds of involving thermal events.
> 
>     If there is no sign of latency, then you might rule out some SMI sources
>     like thermal monitoring. However, this would not exclude other sources
>     like USB for instance.
> 
>     > * Is there anything I should disable in the BIOS or kernel, like
>     ACPI ?
>     >
> 
>     ACPI is required with SMP at the very least. There could be other
>     issues, such as NMI-based perf sampling. The NMI handler attached to
>     this event may have to run through pretty heavyweight ACPI code in the
>     kernel causing such latency (300 us clearly is in the ballpark for such
>     events). You can't disable perf event monitoring in the x86 kernel, but
>     you can prevent NMI-based sampling by passing nmi_watchdog=0 on its
>     command line.
> 
>     If the latency test reports high latency eventually, then we may use the
>     I-pipe tracer to debug this. Otherwise, could that be an issue with the
>     application code? I understand this is likely proven stuff, but maybe a
>     new runtime condition triggers a sleeping bug, leading to an unexpected
>     transition to secondary mode for instance. If the test app can run
>     continuously for a while, you may want to rule out any of those issues
>     by looking at /proc/xenomai/sched/stat, MSW column, just to make sure it
>     does not increase over time.
> 
>     If the application code does not suffer unwanted mode switches, then
>     instrumenting it with I-pipe trace points may be the last resort to find
>     out what happens (see [1]).
> 
>     [1] https://gitlab.denx.de/Xenomai/xenomai/wikis/Using_The_I_Pipe_Tracer
>     -- 
>     Philippe.
> 
> 
> Thanks for your advice, Philippe. No, the code is not switching to
> secondary mode - I have a handler to check for that. Yes this is very
> old stable code.
> I am working on compiling a xenomai 3.x kernel, but that is not ready
> yet.  I did run the 'latency' regression test while compiling a kernel
> on all (4) cores and the worst case latency was 115usec. That is not
> very good, but it is acceptable in this test case.
> 
> I may not have explained well, but I am not concerned with jitter in
> this periodic thread, rather the problem is the mean period. When I
> effectively do this in the periodic routine:
> 
> while(1) {
>   next += period_ns + adjust_ns;
>   rt_task_sleep_until(next);
>   /* Generate DIO pulse here */
>   /* do Work */
>   /* use rt_timer_read() to subtract out the Work execution time from
> period_ns */
> }
> 
> I can tune the mean period with adjust_ns so that the standard deviation
> of the period is +/-10nsec of ideal, measured on a real-world frequency
> counter reading pulses on a DIO port.
> (Note that is 10 nanoseconds, not microseconds).  When I cold boot the
> computer though, and this same periodic app is restarted, the standard
> deviation is still +/-10nsec, BUT the mean period is wrong by over 300
> nanoseconds.  It's the same hardware and the same periodic app, so how
> could this happen? I can run this same code on another motherboard and I
> do not have this problem.  (I don't ask the easy questions of you, only
> the hard ones!)

Ok, so I assumed that was a typo, and that you actually meant 300 us,
not ns. I believe that 300 ns is within the noise when you have two
competing kernels and caches, even if fast ones like on x86.

You could try to run a warmup loop in order not to measure the initial
TLB and/or cache misses for instance, but as long as the loop is going
to relinquish the CPU potentially to a non-rt context by calling
rt_task_sleep_until(), some of the rt code/data may be evicted from L1
at least, which means additional latency when it resumes for cache
refills. In order to mitigate this issue, you could try to isolate the
CPU used by the rt work loop using isolcpus, even if this can't block
any non-rt activity on that CPU, that would at least prevent the kernel
from using it in its load balancing strategy, adding more perturbations.

You may also want to check the timer calibration, having a look at the
so-called gravity value of Xenomai's core timer in
/proc/xenomai/latency. Since you are running 2.x, you will have a single
tunable affecting user-space wakeups only there, but you can still try
to tweak it in order to have Xenomai anticipate a bit more on each timer
shot, without triggering early shots though. Depending on the hardware,
the time required to program the timer chip for the next shot could be
different as well, so a different calibration might be needed. You may
want to compare /proc/xenomai/timer for setup, timerdev and clockdev
values, to find out any difference in this respect.

At any rate, a 300 ns jitter does not denote a SMI issue. The later
would rather be in the hundreds of micro-seconds range.

-- 
Philippe.

