Subject: Re: urcu/lttng (Userspace) and Xenomai
References: <VI1PR05MB5917D0B45F7CB253F10197B5F64E0@VI1PR05MB5917.eurprd05.prod.outlook.com>
 <5718dcc6-9af6-03f8-3e44-b91805f403e2@siemens.com>
 <VI1PR05MB5917144A022B93E3DBA32FE0F64E0@VI1PR05MB5917.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4544332f-e10b-8f3a-64f4-4dd47996ab91@siemens.com>
Date: Thu, 21 Nov 2019 17:19:14 +0100
MIME-Version: 1.0
In-Reply-To: <VI1PR05MB5917144A022B93E3DBA32FE0F64E0@VI1PR05MB5917.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

On 21.11.19 15:15, Lange Norbert wrote:
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Donnerstag, 21. November 2019 14:46
>> To: Lange Norbert <norbert.lange@andritz.com>; Xenomai
>> (xenomai@xenomai.org) <xenomai@xenomai.org>
>> Subject: Re: urcu/lttng (Userspace) and Xenomai
>>
>> NON-ANDRITZ SOURCE: BE CAUTIOUS WITH CONTENT, LINKS OR
>> ATTACHMENTS.
>>
>>
>> On 21.11.19 11:26, Lange Norbert via Xenomai wrote:
>>> Hello,
>>>
>>> I am trying to figure out if Xenomai would work correctly with Lttng.
>>> Currently I haven’t figured out how the system manages buffers, but I am
>> checking if this would be generally applicable to Xenomai.
>>>
>>> I’d like to know if anyone has already used Lttng UST with xenomai
>>> threads, and if there is any need to compile lttng/liburcu for xenomai or
>> using some patches.
>>> (I haven’t seen anything that indicates it would not work).
>>>
>>> ## urcu flavours
>>> This has a few variants, lttng uses the bulletproof one. Most others
>>> should be faster on average – but all of them might unlock a futex with a
>> raw syscall.
>>>
>>> Other flavours like qsbr could likely be faster if the futex sycall
>>> would be replaced with a cobalt mutex (it’s very unlikely this path is
>> executed). Would need some work to get this done (and lttng to use it).
>>>
>>> ## sys_membarrier
>>> recent kernels and liburcu versions support this syscall, which
>>> supposedly allows removal of reader memory barriers.
>>> The syscall will somehow interrupt the threads (all *running threads* of
>> the process), which implicitly causes a barrier for readers.
>>>
>>> Q: I guess this will *not* interrupt xenomai threads, as their shadow linux
>> thread is not *running*?
>>> Q: x86_64 accesses are strictly ordered, do you actually need membarriers
>> at all?
>>>
>>
>> I didn't look into details of enabling userspace lttng yet, but I had a chat with
>> Mathieu about this, maybe a year ago. He said back then that there is also a
>> polling mode where a data collection thread is simply trying to obtain the
>> trace output time-driven.
> 
> I believe that’s the "bulletproof" rcu mode that lttng uses. I don’t see any OS-level
> synchronization in the readers, only some atomic variables.
> Mathieu is a lttng dev?

Mathieu Desnoyers is the creator of lttng. And of those nice urcu 
services and syscalls. Let's try to pull him in... :)

You could also try to place your questions on some lttng channel, I guess.

> 
>> Then the producer (including cobalt threads) would
>> not need any syscall at all.
> 
> In the context of lttng those are readers (of the shared rcu structures),
> writes would only happen if tracepoint providers are added/removed.

Maybe Mathieu had a static (upfront to application start) tracepoint 
configuration in mind. That's what I would expect from an RT setup at least.

> 
> But then I don’t know how the buffers are managed, this appears to
> be system-wide in another process.
> 
> The sys_membarrier syscall would be called by writers (not xenomai threads) to additionally allow
> instructions like dmb (for arm) around atomic accesses to be removed for the readers.
> I think it's useless for x86_64 and the syscall itself would not do anything for running xenomai threads.
> (you can only force the syscall but not disable it, without changing sources that is).

While an x86-only view can be ok for a concrete setup, it's better to 
develop a generic / portable solution that enables lttng for broader use 
in Xenomai applications.

> 
>> As I said, that was just a conceptual discussion.
>> None of us actually looked into the implementation.
> 
> Hmm, would like to test this soon. Still need a way to totally disable it in-case something goes wrong.. ie ugly macro magic.
> Can you tell me that I am right about membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED) not blocking until
> the running xenomai thread had some sort of syscall synchronization?

I haven't looked into membarrier semantics in Xenomai context yet. The 
key question is if the Xenomai task switcher happens to provide the same 
information to that service as a normal Linux task switch would do. 
Maybe it's working, just slower, maybe it's stalling with CPUs that only 
switch between Linux idle and the Xenomai scheduler as a black box from 
Linux perspective.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

