References: <56210E7E.1050606@siemens.com> <5621102C.4030902@siemens.com>
 <56211645.9090503@xenomai.org> <56211787.8090107@siemens.com>
 <5621184E.8070704@xenomai.org> <56211E6A.2080300@siemens.com>
 <56211F0C.7030905@xenomai.org> <56211FB7.9000306@siemens.com>
 <56212068.8010405@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <562120A8.6070303@xenomai.org>
Date: Fri, 16 Oct 2015 18:07:04 +0200
MIME-Version: 1.0
In-Reply-To: <56212068.8010405@xenomai.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3: kill() to non-Xenomai PIDs
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

On 10/16/2015 06:06 PM, Philippe Gerum wrote:
> On 10/16/2015 06:03 PM, Jan Kiszka wrote:
>> On 2015-10-16 18:00, Philippe Gerum wrote:
>>> On 10/16/2015 05:57 PM, Jan Kiszka wrote:
>>>> On 2015-10-16 17:31, Philippe Gerum wrote:
>>>>> On 10/16/2015 05:28 PM, Jan Kiszka wrote:
>>>>>> On 2015-10-16 17:22, Philippe Gerum wrote:
>>>>>>> On 10/16/2015 04:56 PM, Jan Kiszka wrote:
>>>>>>>> On 2015-10-16 16:49, Jan Kiszka wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> kill() is currently handled by libcobalt such that PIDs <= 0 are
>>>>>>>>> forwarded to Linux and PIDs > 0 are considered to target only Xenomai
>>>>>>>>> threads. But what if the user wants to address a regular Linux task from
>>>>>>>>> within a Xenomai application? Shouldn't we retry kill via the Linux path
>>>>>>>>> if Xenomai's syscall reports ESRCH?
>>>>>>>>>
>>>>>>>>
>>>>>>>> IOW:
>>>>>>>>
>>>>>>>> diff --git a/lib/cobalt/signal.c b/lib/cobalt/signal.c
>>>>>>>> index aac4059..7e03301 100644
>>>>>>>> --- a/lib/cobalt/signal.c
>>>>>>>> +++ b/lib/cobalt/signal.c
>>>>>>>> @@ -99,6 +99,10 @@ COBALT_IMPL(int, kill, (pid_t pid, int sig))
>>>>>>>>  
>>>>>>>>  	ret = XENOMAI_SYSCALL2(sc_cobalt_kill, pid, sig);
>>>>>>>>  	if (ret) {
>>>>>>>> +		/* Retry with regular kill is no RT target was found. */
>>>>>>>> +		if (ret == -ESRCH)
>>>>>>>> +			return __STD(kill(pid, sig));
>>>>>>>> +
>>>>>>>>  		errno = -ret;
>>>>>>>>  		return -1;
>>>>>>>>  	}
>>>>>>>>
>>>>>>>> Jan
>>>>>>>>
>>>>>>>
>>>>>>> This may break code that sends signal 0 to detect whether a rt thread
>>>>>>> exists (like copperplate does), which is the reason for the lack of
>>>>>>> forwarding IIRC. (ret == -ESRCH && sig) would be required to forward
>>>>>>> without breaking such assumption.
>>>>>>
>>>>>> That still breaks POSIX (what if the user wants to test for a non-rt
>>>>>> thread, like this is possible under regular Linux?). Can't copperplate
>>>>>> be changed to bypass the wrapper?
>>>>>>
>>>>>
>>>>> Probably, yes.
>>>>>
>>>>
>>>> Looking at cluster_probe, I wonder if there is actually a problem.
>>>> Doesn't that code also run over mercury? Then kill(pid, 0) also targets
>>>> the whole system, not just a set of Xenomai applications.
>>>
>>> Over mercury, the whole system is the rt domain.
>>>
>>>  Or do we need
>>>> to ensure that the caller is not migrated to Linux needlessly under
>>>> cobalt? IOW: can that probing happen under RT constraints?
>>>>
>>>
>>> It does with clusters. In general, no restriction on the calling domain
>>> should exist for this low level interface.
>>
>> Ok, will handle that path cobalt-specific then.
>>
>>>
>>>> The same applies for me to the other users of the kill-based probing
>>>> pattern (copperplate/heapobj-pshared.c and copperplate/regd/fs-common.c).
>>
>> But these are fine, no?
>>
> 
> Yes, don't care for mode switches there.
> 
> 

In fact, those will never target a non-Xenomai thread over cobalt.

-- 
Philippe.

