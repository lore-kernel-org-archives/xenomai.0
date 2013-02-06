Message-ID: <51124E54.603@xenomai.org>
Date: Wed, 06 Feb 2013 13:36:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51122E82.6050209@siemens.com> <51124A06.3020205@xenomai.org>
	<51124C88.1060401@siemens.com> <51124D37.1000001@xenomai.org>
	<51124DAD.3060306@siemens.com>
In-Reply-To: <51124DAD.3060306@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i8253 clocksource vs. rthal_get_8254_tsc
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 02/06/2013 01:33 PM, Jan Kiszka wrote:

> On 2013-02-06 13:31, Gilles Chanteperdrix wrote:
>> On 02/06/2013 01:28 PM, Jan Kiszka wrote:
>>
>>> On 2013-02-06 13:18, Gilles Chanteperdrix wrote:
>>>> On 02/06/2013 11:20 AM, Jan Kiszka wrote:
>>>>
>>>>> Hi Gilles,
>>>>>
>>>>> I just realized that there is now a 8253 clocksource in core-3.4+. How
>>>>> does this work together with Xenomai's TSC emulation via the 8254 in the
>>>>> x86 hal_32? Xenomai reprograms the PIT in rthal_setup_8254_tsc - is this
>>>>> harmless?
>>>>>
>>>>> I came across this while trying to get rid of Xenomai's "depends on
>>>>> !INPUT_PCSPKR" to avoid that circular Kbuild dependency.
>>>>
>>>>
>>>> This emulation replaces Xenomai's TSC emulation when the kernel boots on
>>>> a cpu without a TSC: the detection is made at run-time instead of
>>>> compilation time using self-modifying code (this in order to be able to
>>>> build Debian kernels which boots with any configuration).
>>>
>>> Hmm, that's for the kernel. But what prevents rthal_setup_8254_tsc from
>>> being executed in addition? I'm currently a bit lost in the #ifdefs.
>>
>>
>> rthal_setup_8254_tsc is not called.
>>
>>>
>>>> There is no
>>>> reason to keep the compilation-time dependency on !INPUT_PCSPKR with
>>>> I-pipe core, as now the pc speaker is disabled at run-time too.
>>>> Unfortunately, I could not find how to arrange the Kconfig either.
>>>
>>> As this is only about practically unsupported combinations of Xenomai
>>> (2.6.x) and I-pipe (for kernel 2.6.x) on x86, we could move from a
>>> configure-time to a build-time detection (#ifdef CONFIG_INPUT_PCSPKR ->
>>> BUILD_BUG()).
>>
>>
>> There is already a run-time detection which simply does not declare the
>> PC speaker platform device when there is no tsc.
> 
> That's for core-3.4+, but not for older kernels. If we are fine with
> ignoring them, I'll just write a patch to remove that Kconfig dependency.


You could replace !INPUT_PCSPKR with !X86_TSC && !INPUT_PCSPKR
I-pipe core kernels can be compiled with CONFIG_X86_TSC anyway.

-- 
                                                                Gilles.

