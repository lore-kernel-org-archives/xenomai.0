Message-ID: <502E6523.8050007@xenomai.org>
Date: Fri, 17 Aug 2012 17:37:07 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <502D040F.2010906@axesseurope.com>	<20120816144617.GD1237@csclub.uwaterloo.ca>
	<502E541F.7090801@axesseurope.com>
	<502E5830.4080205@xenomai.org> <502E5D04.70002@xenomai.org>
	<502E5F2E.20405@xenomai.org>
In-Reply-To: <502E5F2E.20405@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Trying to get Xenomai on P1010RDB
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

On 08/17/2012 05:11 PM, Gilles Chanteperdrix wrote:
> On 08/17/2012 05:02 PM, Philippe Gerum wrote:
>> On 08/17/2012 04:41 PM, Gilles Chanteperdrix wrote:
>>> On 08/17/2012 04:24 PM, Charles Retailleau wrote:
>>>> Thanks Lennart that was very useful, it now works.
>>>> Here is the little patch I made, yet I couldn't find a switch to force
>>>> it for core e500/e500xx only...
>>>>
>>>>
>>>> --- ./xenomai-2.6.1.orig/include/asm-powerpc/syscall.h	2011-11-09
>>>> 13:21:36.000000000 +0100
>>>> +++ ./xenomai-2.6.1.mine/./include/asm-powerpc/syscall.h	2012-08-17
>>>> 15:47:28.387435909 +0200
>>>> @@ -167,9 +167,9 @@
>>>>    	} u;
>>>>    	unsigned long __tbu;
>>>>
>>>> -	__asm__ __volatile__("1: mftbu %0\n"
>>>> -			     "mftb %1\n"
>>>> -			     "mftbu %2\n"
>>>> +	__asm__ __volatile__("1: mfspr %0,269\n"
>>>> +			     "mfspr %1,268\n"
>>>> +			     "mfspr %2,269\n"
>>>>    			     "cmpw %2,%0\n"
>>>>    			     "bne- 1b\n":"=r"(u.v[0]),
>>>>    			     "=r"(u.v[1]), "=r"(__tbu));
>>>> Thanks to all for your help
>>>> Charles,
>>>
>>> If I understand correctly, this patch breaks old powerpcs. So, do we
>>> have a compilation constant allowing to know whether we are compiling
>>> for an old or new powerpc?
>>>
>>
>> For the sake of completeness, we could condition mftb to CONFIG_POWER3,
>> all others we care for (i.e. >= ISA 2.01) do support mfspr 268.
>>
>
> is CONFIG_POWER3 available when configuring user-space support?
>

No, but actually, I never ported Xenomai to power3 and will likely never 
do this. It's the early 64bit server architecture; we won't officially 
support any 64bit platform which does not comply with ISA 2.04 at least 
anyway. Best effort would be to depend on a gcc define built-in for 
mcpu=power3 if any.

-- 
Philippe.

