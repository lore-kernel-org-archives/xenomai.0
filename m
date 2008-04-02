Message-ID: <47F3A600.2050308@domain.hid>
Date: Wed, 02 Apr 2008 17:28:00 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <20080402012645.506e53ef.Cornelius.Koepp@domain.hid>		<47F34C0D.6090809@domain.hid>
	<47F37579.7080601@domain.hid>		<47F37BF8.6000401@domain.hid>	<2ff1a98a0804020546v5eaa8ff4q100ad4820d4ad015@domain.hid>
	<47F38365.8070008@domain.hid>
In-Reply-To: <47F38365.8070008@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] latencys drifting into negative
	(Xenomai	2.4.2/2.4.3)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>, =?ISO-8859-1?Q?Cornelius_K=F6pp?= <Cornelius.Koepp@domain.hid>

Sebastian Smolorz wrote:
> Gilles Chanteperdrix wrote:
>> On Wed, Apr 2, 2008 at 2:28 PM, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>> Sebastian Smolorz wrote:
>>>  > Jan Kiszka wrote:
>>>  >>
>>>  >> 2.3.x did not incorporate the new TSC-to-ns conversion. Maybe it is
>>>  >> not a PIC vs. APIC thing, but rather a rounding problem of larger TSC
>>>  >> values (that naturally show up when the system runs for a longer time).
>>>  >
>>>  > This hint seems to point into the right direction. I tried out a
>>>  > modified pod_32.h (xnarch_tsc_to_ns() commented out) so that the old
>>>  > implementation in include/asm-generic/bits/pod.h was used. The drifting
>>>  > bug disappeared. So there seems so be a buggy x86-specific
>>>  > implementation of this routine.
>>>
>>>  Hmm, maybe even a conceptional issue: the multiply-shift-based
>>>  xnarch_tsc_to_ns is not as precise as the still multiply-divide-based
>>>  xnarch_ns_to_tsc. So when converting from tsc over ns back to tsc, we
>>>  may loose some bits, maybe too many bits...
>> If you want to know whether llmulshft implementation is broken on x86
>> or if there is a design issue, you can attempt to use the generic
>> implementation on x86.
>>
> 
> You mean not using rthal_llmulshft() in arith_32.h and instead using 
> __rthal_generic_llmulshft()? I tried this and it's also suffering from 
> the drift although it seems that the drift per time unit is smaller in 
> the generic case.

This was a subjective impression, the drift caused by rthal_llmulshft() 
and __rthal_generic_llmulshft() is the same.

> I will try to get some numbers to compare the values 
> returned from rthal_llmulshft(), __rthal_generic_llmulshft() and 
> __rthal_generic_ullimd().
> 

Here are some results. The latency test run one hour and 46 minutes 
(kernel mode). I measured the difference between the return value of the 
routine __rthal_generic_ullimd() which I considered as right and the 
return value of rthal_llmulshft(). This difference increases over time.

At start: 21 ns
After 1 minute: 50 ns
After 4 minutes: 132 ns
After 8 minutes: 238 ns
After 86 minutes: 2342 ns

The higher the TSC value the bigger the error during the conversion of 
the TSC value to nanoseconds. The converted value is too small. This all 
explains why latency reports decreasing values over time.

Houston, we have a problem.

-- 
Sebastian

