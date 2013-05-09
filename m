Message-ID: <518BE4FC.6060507@xenomai.org>
Date: Thu, 09 May 2013 20:03:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5144D3E9.2050205@xenomai.org>
	<5144D524.4000302@web.de>	<5144D5AB.3080004@xenomai.org>
	<5144D5E3.9050601@web.de> <5144DB0F.9050901@xenomai.org>
	<518BDD9D.10804@xenomai.org> <518BE3C5.4090203@web.de>
	<518BE49D.2010404@xenomai.org> <518BE4CE.6020107@web.de>
In-Reply-To: <518BE4CE.6020107@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] __get_user/__put_user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 05/09/2013 08:02 PM, Jan Kiszka wrote:

> On 2013-05-09 20:02, Gilles Chanteperdrix wrote:
>> On 05/09/2013 07:58 PM, Jan Kiszka wrote:
>>
>>> On 2013-05-09 19:32, Gilles Chanteperdrix wrote:
>>>> On 03/16/2013 09:50 PM, Gilles Chanteperdrix wrote:
>>>>
>>>>> On 03/16/2013 09:28 PM, Jan Kiszka wrote:
>>>>>
>>>>>> On 2013-03-16 21:27, Gilles Chanteperdrix wrote:
>>>>>>> On 03/16/2013 09:25 PM, Jan Kiszka wrote:
>>>>>>>
>>>>>>>> On 2013-03-16 21:19, Gilles Chanteperdrix wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> xenomai asm-generic/syscall.h defines __xn_put_user/__xn_get_user as
>>>>>>>>> aliases for __put_user/__get_user, which implementation, for the ARM
>>>>>>>>> architecture calls might_fault() which triggers an ipipe_root_only() check.
>>>>>>>>>
>>>>>>>>> So, the question is, what is the best way of avoiding this issue? Remove
>>>>>>>>> the call to might_fault() when compiling with CONFIG_IPIPE enabled?
>>>>>>>>> Define __ipipe_safe_put_user which avoids the call to might_fault() ?
>>>>>>>>
>>>>>>>> Adjust might_fault() in a way that it only considers atomic non-root
>>>>>>>> contexts as problematic.
>>>>>>>
>>>>>>>
>>>>>>> atomic meaning with hardware irqs off? or within an irq handler? This
>>>>>>> requires xenomai...
>>>>>>
>>>>>
>>>>>> Hard irqs off || head domain stalled, I would say.
>>>>>
>>>>> ok, done, thanks.
>>>>>
>>>>
>>>> Actually, it does not work, the WARN_ON triggers in __rt_heap_bind for
>>>> instance, which does some copies from user with hard irqs off.
>>>
>>> Hmm, isn't that a real bug? The nucleus should then try to migrate to
>>> Linux while the nklock is held - ouch...
>>
>>
>> In theory, the fault should be fixed up without requiring a migration. I
>> will test this.
> 
> In theory, user space could also provide an invalid pointer.


Yes, this is what I am going to test, but an invalid pointer cause the
fault to be fixed up so that the copy_from_user return -EFAULT.

-- 
                                                                Gilles.

