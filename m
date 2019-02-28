Subject: Re: Periodic timing varies across boots
References: <CA+K1mPFRVPqD_Gg2_7_PqcpegJ+ADJm3hea2AHxiHzwwBBG_iw@mail.gmail.com>
 <3d5044db-0b5c-fe4a-480c-b50943d440e5@siemens.com>
 <CA+K1mPEfLdrvGOqnX+1F6omFQq-CT75v2-5qTXF8Rj8NY=mHrQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e557148a-392d-3c8e-615e-58c60c03e6e1@xenomai.org>
Date: Thu, 28 Feb 2019 08:30:30 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPEfLdrvGOqnX+1F6omFQq-CT75v2-5qTXF8Rj8NY=mHrQ@mail.gmail.com>
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
To: C Smith <csmithquestions@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 2/28/19 6:56 AM, C Smith via Xenomai wrote:
> On Mon, Feb 25, 2019 at 12:09 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> On 24.02.19 07:57, C Smith via Xenomai wrote:
>>> I am using Xenomai 2.6.5, x86 32bit SMP kernel 3.18.20, Intel Core
>>> i5-4460,  and I have found a periodic timing problem on one particular
>> type
>>> of motherboard.
>>>
>>> I have a Xenomai RT periodic task which outputs a pulse to the PC
>> parallel
>>> port, and this pulse is measured on a frequency counter. This has been
>>> working fine for years on several motherboards. I am able to adjust the
>>> period of my task to within +/-10nsec, according to the frequency
>> counter.
>>> I can calibrate the periodic timing down to a period +/-10nsec on this
>>> motherboard, and I cna restart my xenomai process many times and the
>> timing
>>> is fine. But if I cold-reboot the machine the measured period is wrong by
>>> up to  +/-300nsec. Thus I cannot get consistent periodic timing from day
>> to
>>> day without recalibrating, which is unacceptable in my application.
>>>
>>> In my kernel config, I am using the TSC: CONFIG_X86_TSC=y
>>> I use rt_timer_read() to determine what time it is, and my periodic task
>>> sleeps in a while loop, like this:
>>>        next += period_ns + adjust_ns;
>>>        rt_task_sleep_until(next);
>>>
>>> I don't know what to test. Can you suggest anything?
>> Stéphane Ancelot said:
>> Your problem seems being related to SMI interrupts rising.
>> According to your chipset , Program xenomai  kernel SMI registers in
>> boot options ,  in order to avoid this problem.
>> Regards,
>> S.Ancelot
>>
> 
> 
>> Can you reproduce the issue with a supported Xenomai and kernel version?
>>
>> Jan
>>
>>
> We have tens of thousands of legacy code so I must use Xenomai 2.6.5 - we
> will endeavor to got to Xenomai 3.x next year.
> Per your suggestion I could try writing a stripped-down periodic app and
> booting into Xenomai 3 for a test though... I'll do that soon and let you
> know how it goes.
> I doubt there is anything wrong with Xenomai 2.6.5 though. My periodic
> timing worked fine with 3 other motherboards and this same
> Xeno kernel, but I must use this motherboard because of its form factor
> (and we spent months qualifying it).
> 
> First, I am exploring what Stephane A. said above, where he suspects SMI
> interference.
> I did try adding xeno_hal.smi=1 to my kernel boot options, but I get this
> in dmesg at boot:
>   Xenomai: SMI-enabled chipset found
>   Xenomai: SMI workaround failed!
> So I guess I can't solve the problem that way.

It looks so. At the very least, this motherboard denied global disabling
of SMIs to the Xenomai core (which current motherboards do anyway).
Maybe disabling of specific SMI sources could be achieved, but finding
which ones should and could be masked would be required.

> My periodic timing is not fixed by this attempt either.
> Note that during boot I see: "CPU0: Thermal monitoring handled by SMI"
> 

This may be a hint. Thermal monitoring in BIOS is a known source of
latency on x86.

> I also ran the 'latency' regression test and it does not show large
> latencies, they are <= 2.6 usec.
> * Does that indicate SMI is not interrupting my process?

How long did it run? You may need to run this test for an hour to be
sure, while the system is stressed by some other workload. switchtest -s
200 for instance. And/or a kernel build on all of your 4 cores if
possible, to lower the odds of involving thermal events.

If there is no sign of latency, then you might rule out some SMI sources
like thermal monitoring. However, this would not exclude other sources
like USB for instance.

> * Is there anything I should disable in the BIOS or kernel, like ACPI ?
> 

ACPI is required with SMP at the very least. There could be other
issues, such as NMI-based perf sampling. The NMI handler attached to
this event may have to run through pretty heavyweight ACPI code in the
kernel causing such latency (300 us clearly is in the ballpark for such
events). You can't disable perf event monitoring in the x86 kernel, but
you can prevent NMI-based sampling by passing nmi_watchdog=0 on its
command line.

If the latency test reports high latency eventually, then we may use the
I-pipe tracer to debug this. Otherwise, could that be an issue with the
application code? I understand this is likely proven stuff, but maybe a
new runtime condition triggers a sleeping bug, leading to an unexpected
transition to secondary mode for instance. If the test app can run
continuously for a while, you may want to rule out any of those issues
by looking at /proc/xenomai/sched/stat, MSW column, just to make sure it
does not increase over time.

If the application code does not suffer unwanted mode switches, then
instrumenting it with I-pipe trace points may be the last resort to find
out what happens (see [1]).

[1] https://gitlab.denx.de/Xenomai/xenomai/wikis/Using_The_I_Pipe_Tracer

-- 
Philippe.

