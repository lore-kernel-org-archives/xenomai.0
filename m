Message-ID: <4BC5F7D4.8010806@domain.hid>
Date: Wed, 14 Apr 2010 19:13:56 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B97BA0C.9000702@domain.hid> <4B9BB9B1.5050003@domain.hid>	
	<1268498034.27899.167.camel@domain.hid>	
	<4B9C2100.6090806@domain.hid>	
	<1268584465.27899.197.camel@domain.hid>	
	<4BB4F857.5020906@domain.hid> <4BB50C8B.2000405@domain.hid>	
	<1270156940.2418.403.camel@domain.hid>
	<4BB50F7C.1020102@domain.hid>	
	<1270157507.2418.409.camel@domain.hid>
	<4BB511C7.1050507@domain.hid>	
	<1270158532.2418.420.camel@domain.hid>
	<4BB51631.5030609@domain.hid>	
	<1270159246.2418.432.camel@domain.hid>
	<4BB51931.3080307@domain.hid>	 <4BB523E8.705@domain.hid>
	<4BB5250F.1040409@domain.hid>	 <4BB52769.4080702@domain.hid>
	<4BB5348B.2070805@domain.hid>	 <4BB5C95E.9060502@domain.hid>
	<4BB5D0D4.40908@domain.hid>	 <4BB5D1A0.8030007@domain.hid>
	<4BB5D4FB.4010901@domain.hid>	
	<1271191271.2365.436.camel@domain.hid>
	<4BC4F8CA.4080202@domain.hid>	
	<1271229750.2365.444.camel@domain.hid. org>
	<4BC570A4.1090203@domain.hid>
	<1271235874.2365.483.camel@domain.hid>
In-Reply-To: <1271235874.2365.483.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-help] Analogy cmd_write example
	explanation
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Alexis Berlemont <berlemont.hauw@domain.hid>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> On Wed, 2010-04-14 at 09:37 +0200, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Wed, 2010-04-14 at 01:05 +0200, Jan Kiszka wrote:
>>>> Philippe Gerum wrote:
>>>>> The steps now:
>>>>>
>>>>> - we implement the automatic switchback of shadow nrt threads to
>>>>> secondary mode, upon return from Xenomai (primary) syscalls. I am
>>>>> working on this. The most significant impact is on userland, due to the
>>>>> fastsynch support, actually. Kernel-wise, it's rather straightforward.
>>>>> The only exception to this would be when the caller owns an exclusive
>>>>> resource (like a mutex), in which case the mode downgrade should be
>>>>> postponed until the syscall releasing the last resource held returns.
>>>> Kernel is clear, but user space sounds indeed interesting. I guess we
>>>> need an out-of-band channel to tell the kernel about pending
>>>> user-space-only lock ownerships when calling some unrelated syscall. How
>>>> does your current approach look like?
>>> I want to keep things simple: shadow nrt will go through the syscalls
>>> for acquisition/release of owned resources, instead of fastsynchs.
>> Then I'll have to pick this up as that will very likely create unhappy
>> customers. In fact, the majority of our Xenomai threads are nrt (yeah,
>> that happens if you convert existing applications).
> 
> I would understand that people do not want to bother that much with
> using the right kind of threads between shadow nrt and plain linux
> within the context of an initial port, but at some point, the code
> should be made consistent with respect to the real use.
> 
> If there is a problem with auto-shadowing in the POSIX skin, or
> sched_setscheduler() or whatever, then it should be addressed, but we
> just can't pile up code only to satisfy such a corner case, i.e.
> situations where applications create Xenomai nrt threads without actual
> need for this, to make them run in secondary mode only, without
> requiring a single primary-mode service (hence wanting hard to keep
> __xn_exec_current for RTDM).
> 
> So, I will merge the bits I have in mind as a first step, because they
> satisfy the normal usage of Xenomai threads. I will certainly ACK any
> improvement to this code which keeps the original fastsynch optimization
> for nrt threads, provided the feature/code overhead ratio seems correct.

I agree. Let us have your solution merged first, to get to a less
troublesome situation (my concern is about switchtest, I am a bit
selfish, but switchtest just helped me again solving FPU issues).

Optimizations can be taken care of later, especially when we are talking
about optimization of shadowed non real-time threads, good performances
for them is a nice-to-have, not our primary concern.

-- 
					    Gilles.

