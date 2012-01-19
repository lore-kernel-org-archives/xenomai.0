Message-ID: <4F180CC2.8020700@domain.hid>
Date: Thu, 19 Jan 2012 13:29:54 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F0B530A.80905@domain.hid>	<4F0C5524.9020501@domain.hid>	<4F0C58B7.1080602@domain.hid>	<4F0C5C00.3060508@domain.hid>	<4F0C5C02.50308@domain.hid>	<4F0C5C63.40105@domain.hid>	<4F0C5E85.5080004@domain.hid>	<4F0C7EAE.8080209@domain.hid>	<4F0C85E2.1070109@domain.hid>	<4F0C8D0F.3080207@domain.hid>
	<4F174AA3.7030309@domain.hid> <4F17FD9E.6040007@domain.hid>
In-Reply-To: <4F17FD9E.6040007@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Issue with Auto relax and nested mutexes
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/19/2012 12:25 PM, Philippe Gerum wrote:
> On 01/18/2012 11:41 PM, Makarand Pradhan wrote:
>> Hi,
>>
>> Another problem was encountered with rescnt related to nested mutexes.
>>
>> This time the rescnt is not incrementing because the XNOTHER bit is not
>> set, causing a SIGDEBUG or SIGXCPU to be delivered to the thread causing
>> my application to crash.
>>
>> The scenario is as follows:
>>
>> 1. Thread started with priority 0. (Relaxed)
>> 2. This thread uses mutexes which causes Priority Inversions.
>> 3. At some point, a rt_task_set_priority is done to change the priority.
>> (RT 85).
>> 4. Some time later the priority is set back to 0.
> 
> If I understand it properly, your runtime scenario is badly broken I'm 
> afraid. By contrast to priority ceiling, priority inheritance is about 
> leaving the responsibility to the _kernel_ to pick the best dynamic 
> priority for your thread to solve a priority inversion.
> 
> Therefore, by changing your dynamic priority while holding a mutex, your 
> application is preventing the kernel to do the job you previously 
> assigned to it. Worst, you could be causing unexpected latencies to 
> other threads your application has no clue about, or just can't tell 
> whether they compete with your thread for accessing the resource at that 
> specific time.
> 
> After all, this is your application that defined the contented mutex, 
> and as such the fact that priority inheritance might be involved at some 
> point. If you don't trust the kernel and want to deal with priorities 
> manually during resource contention, then maybe you should use a 
> different mutual exclusion mechanism not implementing priority 
> inheritance, e.g. a plain binary semaphore.

Even if you implement manual priority ceiling, you should change
priority before acquiring the mutex, not after, otherwise there is a
race condition.

-- 
                                                                Gilles.

