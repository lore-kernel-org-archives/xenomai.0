Message-ID: <4B953580.7020309@domain.hid>
Date: Mon, 08 Mar 2010 18:36:00 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B95253E.3030303@domain.hid> <4B952D21.5090204@domain.hid>
	<4B953426.6070905@domain.hid>
In-Reply-To: <4B953426.6070905@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] u_mode and condvar fixes.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Hi,
>>>
>>> I pushed the changes fixing the u_mode (taken from Jan, slightly
>>> modified) and condvar stuff (not entirely taken from Jan's changes), as
>>> well as the modifications coming from Philippe's branch.
>>>
>>> However, two questions remain open:
>>> - as in Jan's original patch, the u_mode stuff tests the presence of the
>>> new syscall by testing whether it returns -ENOSYS. Now that we have the
>>> vdso, I wonder if we should not use a vdso bit for this. This would give
>>> us a systematic way of testing such syscalls extension.
>> I would prefer this path over -ENOSYS testing as well. We could collect
>> the bits once and just test for it in-place. No more setup needed then
>> when adding more (for cond e.g.).
>>
>>> - the condvar fix only fixes the general case, using errno, it does not
>>> add any new syscall. I am not entirely convinced we really need to add
>>> new syscalls. In fact we could use special values in the existing ones.
>>> Or have access in kernel-space to the a process' vdso flags, allowing to
>>> adapt according to these flags. I am simply wondering what is the
>>> cleanest way.
>> I think the cleanest way are separate syscalls. The existing prologue
>> syscalls of both skins are already at their limits (5 arguments), so
>> adding something here is not easy.
> 
> That can be done:
> the prologue syscall has a "timed" parameter to which the old versions
> always passed O or 1, we only have to pass 2 or 3 to mean 0 and 1, only
> with the newer user-space. As for the epilogue syscall, we can multiplex
> the prologue return value (ten bits for instance is plenty) in the upper
> bits of the count returned to user-space. A recursive lock count of 4
> million is a reasonable limit anyway. I just wonder if these tricks are
> worth the trouble.
> 

That's the question.

If you look at my patches, there is a lot of code in common for path
syscalls. I don't think it will noticeably increase, it should just be
the dispatching method that will vary.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

