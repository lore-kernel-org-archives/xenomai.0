Message-ID: <4734677E.6010904@domain.hid>
Date: Fri, 09 Nov 2007 14:58:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472F6C17.2070100@domain.hid>
	<472F6DAD.20308@domain.hid>	<472F990A.2030209@domain.hid>
	<473006D8.4080808@domain.hid> <47302D55.9050808@domain.hid>
	<47339C53.5010700@domain.hid>
In-Reply-To: <47339C53.5010700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Adeos-main] [PATCH] i386: switch to root domain
 on unhandled non-root faults
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org, Xenomai-core@domain.hid

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Jan Kiszka wrote:
>>> Philippe Gerum wrote:
>>>> Jan Kiszka wrote:
>>>>> Jan Kiszka wrote:
>>>>>> This patch addresses the recently discovered issue that I-pipe actually
>>>>>> need to deal with faults over non-root domain in which the current
>>>>>> domain shows no interest in. Such faults could be triggered inside
>>>>>> copy_*_user, thus can cleanly be handled by Linux - if we only allow for
>>>>>> this. Currently, if debugging is on, we warn about a potential bug, and
>>>>>> corrupt the pipeline states otherwise.
>>>>>>
>>>>>> The new approach is to unconditionally drop to root domain in such
>>>>>> cases, but - for debugging purposes of non-fixable faults - keep track
>>>>>> of the original domain and report it on oops.
>>>>>>
>>>>>> Similar patches are required for other archs. Maybe I can look into
>>>>>> x86_64 later.
>>>>>>
>>>> Nak, this patch would not work as wanted. Again, what you need is to
>>>> always fixup, and conditionally send a bug report to the kernel log if
>>>> CONFIG_IPIPE_DEBUG is enabled, nothing more.
>>>>
>>>> This patch assumes that die() is always going to be fired for any
>>>> in-kernel fault, so that all reports only need to go through this
>>>> routine, which is wrong. Kernel fixups through exception tables may fix
>>>> the fault early and silently, and this is particularly the case for
>>>> copy_to_user helpers, which do include kernel fixup code.  By being
>>>> silent when fixing up things in __ipipe_handle_exception() like your
>>>> patch currently is, we would be left with no trace at all that some
>>>> unhandled fault just happened, except by looking at /proc/xenomai/faults.
>>> As you are still remain vague on the actual problematic scenarios, I
>>> will try to go through them, and maybe you can add/correct what I miss:
>>>
>>>  - faults in user land => can be silently handled by Linux after
>>>    dropping to root domain. This lowering is perfectly fine as the
>>>    higher domains showed no interest in the fault, thus are currently
>>>    running in domain-agnostic code paths anyway.
>>>
>>>  - faults on fixable kernel addresses => same as above. If the high
>>>    domains fail to evaluate the fix-up result, it's not I-pipe's fault.
>>>
>>>  - minor faults on kernel addresses (more precisely: in the I-pipe core
>>>    or some I-pipe user) => those would now went unnoticed and need
>>>    further thoughts, granted.
>>> +
>>>  - major faults on kernel addresses => still generate major oopses and
>>>    will thus be visible.
>>>
>>> Did I missed something? If not, I would now start addressing the
>>> remaining problematic scenario directly instead of throwing all into the
>>> same pot.
>>>
>>>> By sending the report immediately when fixing up in the latter routine,
>>>> you also avoid the ugly ipipe_orig_domain stuff.
>>> It's not nice, but it is at least as ugly as reporting a kernel BUG when
>>> there is only a gracefully fixable bug in user code. I definitely do not
>>> agree with your approach as well, and I'm convinced we need to find a
>>> third way here.
>> OK, I think this should be acceptable for everyone. It's basically your
>> approach, reworked to avoid false positives. Moreover, it
>> unconditionally sets the root domain - should be faster.
>>
> 
> Fine with me now. I made the fault report systematically dumped when
> CONFIG_IPIPE_DEBUG is enabled, to help us fixing the existing issues in
> the skins (e.g. syscall arguments escaping the required sanity checks
> for whatever reason).

Well, this is practically your original version. I still don't see why
we want debug code in production setups (WARN_ON, e.g., doesn't work
this way either), and I still don't understand why you want to report
user faults as kernel bugs.

If you want to spot skin issues, just grep for __xn_copy_to/from_user or
__xn_strncpy_from_user and check for missing return code evaluations.
Really, that's nothing we need runtime checks in I-pipe for.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

