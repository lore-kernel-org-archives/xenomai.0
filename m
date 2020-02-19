Subject: Re: Towards Xenomai on Dovetail
References: <97687b86-9c39-e808-d49c-04b0178d8c31@siemens.com>
 <3a0bab49-a40f-75d3-9abb-26a7a2e2341c@gmail.com>
 <ad9db5ea-1f12-8022-6593-bf451da9aa2d@siemens.com>
 <ae9c2c3b-ba95-6cf2-ce02-945cb63f75a7@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4f93c8e7-bb3c-6c95-409c-0ecac2e6bc2d@siemens.com>
Date: Wed, 19 Feb 2020 16:26:36 +0100
MIME-Version: 1.0
In-Reply-To: <ae9c2c3b-ba95-6cf2-ce02-945cb63f75a7@xenomai.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Philippe Gerum <philippe.gerum@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 19.02.20 15:58, Philippe Gerum wrote:
> On 2/19/20 1:48 PM, Jan Kiszka via Xenomai wrote:
>> On 18.02.20 18:36, Philippe Gerum wrote:
>>> On 2/10/20 7:57 PM, Jan Kiszka wrote:
>>>> Hi Philippe,
>>>>
>>>> could you give a rough overview what areas would be just mapping API
>>>> calls, what would be more different and what is simply missing in
>>>> Dovetail in order to place Xenomai on top of it?
>>>
>>> By order of trickiness:
>>>
>>> - Dovetail assumes the companion core shares the same timekeeping bases
>>> and unit with the common kernel, providing some help in doing so. The
>>> core should switch to nanosecs, ktime_t internally. Typically, MMIO
>>> clock sources which are not architected can be exported directly by the
>>> vDSO (e.g. ARM with its truckload of different clock sources). IOW, no
>>> more tsc-based timekeeping, CLOCK_HOST_REALTIME becomes useless as
>>> clock_gettime() is usable from any context. This deeply affects the
>>> Xenomai timer framework, and the way libcobalt reads time (no need for
>>> tsc->ns conversion, the vDSO delivers nanosecs via clock_gettime()). In
>>> the wake of such change, there would be no reason to keep the arith
>>> support in Xenomai.
>>>
>>> - kernel/cobalt/irq.c and related can go. Dovetail integrates the
>>> so-called "out-of-band" IRQ management directly into the mainline genirq
>>> logic. This means Xenomai can switch to the request/free_irq() interface
>>> or related.
>>>
>>> - kernel/cobalt/arch/*/ and related can go, almost entirely. There is
>>> direct support for context switching including fpu management for
>>> threads controlled by the companion (e.g. real-time) core. This means
>>> that Xenomai's scheduler core should be adapted to use the available
>>> dovetail interface for this. The workings are explained in the
>>> description of the so-called "alternate scheduling" Dovetail
>>> implements [3].
>>>
>>> - support for synchronous breakpoints would need to be reworked a bit,
>>> around the ptrace()-related events Dovetail triggers (TASK_PTSTOP,
>>> PTSTEP, PTCONT). As a consequence, the most ugly KEVT_SCHEDULE event is
>>> gone.
>>>
>>> - although this would not be a requirement for a port, you could reuse
>>> the native VFS support for out-of-band I/O handling in character drivers
>>> Dovetail brings, in order to drop the RTDM-specific file descriptor
>>> management [2], simplifying things even further.
>>
>> One after the other, indeed. For RTDM, I will have to look into more
>> details to asses the user-visible impact. Currently, your approach is
>> not yet up-to-speed with RTDM, specifically due to a missing socket
>> interface (RTnet, RT-CAN, ...).
>>
> 
> RTDM sockets are fundamentally a user-space layer aimed at presenting a
> POSIX-like API to application; the way this layer talks to Cobalt could
> be implemented fully using a chardev interface internally. Actually,
> more than 2/3 of the services exposed by a RTDM protocol driver are
> currently attached to the Cobalt core via a chardev interface
> (connect(), bind(), set/getsockopt(), etc).
> 
> The fact that EVL does not aim at POSIX compliance explains why there is
> no pressure in having this. Dovetail may extend the net_device
> abstraction with support for out-of-band I/O, whether this should go up
> to the socket layer as a service access point is undecided. I just don't
> know yet. Still musing with the idea. Bottom line for me is keep it simple.
> 

Having been there already with RTDM, hmm, 15 years ago, I will predict 
that this approach won't be the final one. That said, it may indeed be a 
good idea to stay at that simple level while trying to sell things upstream.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

