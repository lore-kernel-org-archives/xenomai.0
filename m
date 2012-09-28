Message-ID: <5065846C.1050204@knapp.com>
Date: Fri, 28 Sep 2012 13:05:16 +0200
From: Christoph Permes <christoph.permes@knapp.com>
MIME-Version: 1.0
References: <5062CCB0.7060205@knapp.com> <506321EE.5040907@knapp.com>
	<5063727D.1070801@xenomai.org> <5063F0E6.4070506@knapp.com>
	<5064A0D0.4080707@xenomai.org>
In-Reply-To: <5064A0D0.4080707@xenomai.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai: native skin init failed, code -19.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 09/27/2012 08:54 PM, Gilles Chanteperdrix wrote:
> On 09/27/2012 08:23 AM, Christoph Permes wrote:
> 
>> Hi,
>>
>> here is the output of /proc/timer_list when Xenomai initialization fails (X86_PM_TIMER is disabled in kernel config):
>> -------------------------------------------------
>> Timer List Version: v0.4
>> HRTIMER_MAX_CLOCK_BASES: 2
>> now at 80944922880 nsecs
>>
>> Tick Device: mode:     0
>> Broadcast device
>> Clock Event Device: hpet
> 
>>
>> Tick Device: mode:     0
> 
>> Per CPU device: 0
>> Clock Event Device: lapic
>>  mode:           1
> 
>> Tick Device: mode:     0
> 
>> Per CPU device: 1
>> Clock Event Device: lapic
>>  mode:           1
> 
> mode 1 is shutdown, that is the reason why Xenomai will not start.
> 
> 
> 
>> When Xenomai initialization succeeds (same kernel config, X86_PM_TIMER disabled):
>> -------------------------------------------------
> 
> 
>> Tick Device: mode:     1
>> Broadcast device
>> Clock Event Device: hpet
>>
>> Tick Device: mode:     1
>> Per CPU device: 0
>> Clock Event Device: lapic
>>  mode:           3
>>
>> Tick Device: mode:     1
>> Per CPU device: 1
>> Clock Event Device: lapic
>>  mode:           3
> 
> 
> mode 3 means that the timer is running (in one-shot mode, but that is
> not really important), in that case Xenomai can work.
> 
>> And finally with X86_PM_TIMER enabled (Xenomai works always here):
>> -------------------------------------------------
> 
> 
>> Tick Device: mode:     1
> 
>> Broadcast device
>> Clock Event Device: hpet
>>  mode:           3
>>
>> Tick Device: mode:     1
>> Per CPU device: 0
>> Clock Event Device: lapic
>>  mode:           3
>>
>> Tick Device: mode:     1
>> Per CPU device: 1
>> Clock Event Device: lapic
>>  mode:           3
> 
> 
> Same here.
> 
> 
>> I have also turned on APIC debugging with apic=debug to see whats going on:
>>
>> Thats the output where everything is fine:
>> [    0.026300] CPU0: Intel Celeron(R) Dual-Core CPU       T3100  @ 1.90GHz stepping 0a
>> [    0.026466] Using local APIC timer interrupts.
>> [    0.026467] calibrating APIC timer ...
>> [    0.026995] ... lapic delta = 1249983
>> [    0.026995] ..... delta 1249983
>> [    0.026995] ..... mult: 53694522
>> [    0.026995] ..... calibration result: 199997
>> [    0.026995] ..... CPU clock speed is 1899.0974 MHz.
>> [    0.026995] ..... host bus clock speed is 199.0997 MHz.
>> [    0.026995] ... verify APIC timer
>> [    0.128395] ... jiffies delta = 100
>> [    0.128454] ... jiffies result ok
>> [    0.128602] Booting processor 1 APIC 0x1 ip 0x6000
>>
>> And here is the output where Xenomai fails to initialize (note the value of jiffies delta):
>> [    0.026300] CPU0: Intel Celeron(R) Dual-Core CPU       T3100  @ 1.90GHz stepping 0a
>> [    0.026466] Using local APIC timer interrupts.
>> [    0.026467] calibrating APIC timer ...
>> [    0.026995] ... lapic delta = 20124747
>> [    0.026995] ..... delta 20124747
>> [    0.026995] ..... mult: 864482703
>> [    0.026995] ..... calibration result: 3219959
>> [    0.026995] ..... CPU clock speed is -12360.-057 MHz.
> 
> 
>> [    0.026995] ..... host bus clock speed is 3219.0959 MHz.
>> [    0.026995] ... verify APIC timer
>> [    1.668621] ... jiffies delta = 1610
> 
> 
> Well the clock speed is weird too... So, it would be interesting to find
> out what happens during the APIC timer verification. Though you may
> spend some time figuring out something which was fixed in later
> revisions, so, I would advise to do a quick test of Xenomai 2.6.1 to see
> if it still has the problem.

Hi,

I tried out Xenomai 2.6.1 with both Linux 2.6.38.8 and 3.2.21 and CONFIG_X86_PM_TIMER disabled,
the problem still exists with these versions.

[    0.021152] CPU0: Intel Celeron(R) Dual-Core CPU       T3100  @ 1.90GHz stepping 0a
[    0.021391] Using local APIC timer interrupts.
[    0.021392] calibrating APIC timer ...
[    0.021998] ... lapic delta = 20112246
[    0.021998] ..... delta 20112246
[    0.021998] ..... mult: 863945707
[    0.021998] ..... calibration result: 3217959
[    0.021998] ..... CPU clock speed is -12379.-059 MHz.
[    0.021998] ..... host bus clock speed is 3217.0959 MHz.
[    0.021998] ... verify APIC timer
[    1.662609] ... jiffies delta = 1609
[    1.662705] APIC timer disabled due to verification failure


Also, enabling CONFIG_X86_PM_TIMER seems to solve the problem in these newer versions.


Best regards,
  Christoph

