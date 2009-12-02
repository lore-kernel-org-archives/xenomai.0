Message-ID: <4B169932.9080901@domain.hid>
Date: Wed, 02 Dec 2009 17:43:30 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4B15AFC0.6020805@domain.hid> <4B1627DC.30300@domain.hid>
	<4B16310E.1080306@domain.hid> <4B16939E.8040505@domain.hid>
	<4B169719.3020303@domain.hid>
In-Reply-To: <4B169719.3020303@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [pull request] Signals support.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Hi,
>>>>>
>>>>> here come the pull request for user-space signals support. The simple 
>>>>> solution; handling signals upon system call return, has been implemented
>>>>> since the other solution (handling signals upon any return to 
>>>>> user-space) required to change the I-pipe patch, and so made the 
>>>>> upcoming 2.5 only compatible with newer patches.
>>>>>
>>>>> We pass to kernel-space a sixth argument which is a pointer where 
>>>>> information about received signals is stored by kernel.
>>>>>
>>>>> The only architecture for which the implementation is peculiar is 
>>>>> x86_32, because the register used as sixth argument is ebp, also used 
>>>>> for the libc backtrace function implementation, so I tried to find a 
>>>>> solution which makes backtracing still possible (otherwise we would have
>>>>> said bye-bye to involuntary mode changes chasing with SIGXCPU) without 
>>>>> breaking too many things.
>>>> I'm still digging through the code. A few minor remarks regarding the
>>>> user space side so far:
>>>>
>>>> XENOMAI_DO_SYSCALL becomes quite "bloated" now, and it's inlined. Did
>>>> you check that the fast path (ie. no signal) only contains one
>>>> conditional branch when the compiler is done with optimizing? If not (I
>>>> suspect so), the code should be refactored to look more like
>>>>
>>>> restart:
>>>> 	do_syscall
>>>> 	if unlikely(sigs.nsigs)
>>>> 		res = handle_signals
>>>> 		if res == -ERESTART
>>>> 			goto restart
>>>>
>>>> Moreover, the inner while loop over sigs.remaining should be moved into
>>>> a shared function as well. I don't see why it should be instantiated at
>>>> each and every syscall invocation site.
>> Ok. The second syscall is now done in the out-of-line signal handling
>> function. Do you prefer this?
> 
> The smaller the inlined code gets, the better.
> 
>> It is only implemented for x86_32 since it is the problematic
>> architecture, but if you are ok with it, I will change the other
>> architectures.
> 
> Will check, thanks.
> 
>>>> Am I right, there is no skin (except the test skin) using this feature
>>>> so far?
>>> Next question: The signal delivery latency is naturally affected by the
>>> syscall invocation frequency of the target thread, right? Ie. no
>>> syscall, no signal. Once we offer "RT" signals via the skin, this
>>> limitation should be prominently documented.
>> Well, if you make no syscall, your box is basically a brick. We need
>> suspensions from time to time to get Linux running anyway.
>>
> 
> For sure.
> 
> My point is that people may get the idea to build time-critical event
> delivery based on signals. In such cases it would make a big difference
> how often the destination thread issues a syscall. Also forced
> preemptions can extend the delivery latency, only the user space
> workload counts.
> 
> I would not recommend such application designs, but people may get that
> idea when they once read "RT-safe signals". :)

Ok. But if the thread receiving the syscall is suspended in primary
mode, it will wake up ASAP to handle the signal, so the latency is not
that great. Of course it will work if the target thread is suspended
most of the time.

-- 
                                          Gilles


