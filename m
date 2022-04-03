References: <20220403144348.1775590-1-rpm@xenomai.org>
 <317493564.212576.1649003575604.JavaMail.zimbra@nod.at>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH v2] x86: dovetail: reinstate I/O bitmap on user entry
Date: Sun, 03 Apr 2022 19:49:59 +0200
In-reply-to: <317493564.212576.1649003575604.JavaMail.zimbra@nod.at>
Message-ID: <87ilrqnjdp.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai <xenomai@xenomai.org>


Richard Weinberger <richard@nod.at> writes:

> ----- Urspr=C3=BCngliche Mail -----
>> Von: "Philippe Gerum" <rpm@xenomai.org>
>> An: "xenomai" <xenomai@xenomai.org>
>> CC: "Philippe Gerum" <rpm@xenomai.org>, "Richard Weinberger" <richard.we=
inberger@gmail.com>
>> Gesendet: Sonntag, 3. April 2022 16:43:48
>> Betreff: [PATCH v2] x86: dovetail: reinstate I/O bitmap on user entry
>
>> From: Philippe Gerum <rpm@xenomai.org>
>>=20
>> We have to fix up the TSS with the proper I/O bitmap settings in
>> arch_dovetail_switch_finish() when the incoming Dovetail-enabled task
>> is about to re-enter user mode.
>>=20
>> This fixes an application crash observed when such a task would rely
>> on iopl() to raise its I/O permissions then block, relinquishing the
>> CPU to another task invalidating them, before the former eventually
>> resumes in user mode.
>>=20
>> See https://xenomai.org/pipermail/xenomai/2022-March/047451.html.
>>=20
>> Reported-by: Richard Weinberger <richard.weinberger@gmail.com>
>> Tested-by: Richard Weinberger <richard.weinberger@gmail.com>
>> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
>> ---
>> arch/x86/include/asm/dovetail.h | 16 ++++++++++++----
>> 1 file changed, 12 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/x86/include/asm/dovetail.h b/arch/x86/include/asm/dove=
tail.h
>> index 9cf811fe98ba..940726f16f2e 100644
>> --- a/arch/x86/include/asm/dovetail.h
>> +++ b/arch/x86/include/asm/dovetail.h
>> @@ -9,6 +9,7 @@
>> #if !defined(__ASSEMBLY__) && defined(CONFIG_DOVETAIL)
>>=20
>> #include <asm/fpu/api.h>
>> +#include <asm/io_bitmap.h>
>>=20
>> static inline void arch_dovetail_exec_prepare(void)
>> {
>> @@ -25,11 +26,18 @@ void arch_dovetail_switch_prepare(bool leave_inband)
>> static inline
>> void arch_dovetail_switch_finish(bool enter_inband)
>> {
>> -	if (enter_inband)
>> +	unsigned int ti_work =3D READ_ONCE(current_thread_info()->flags);
>> +
>> +	if (unlikely(ti_work & _TIF_IO_BITMAP))
>> +		tss_update_io_bitmap();
>> +
>> +	if (enter_inband) {
>> 		fpu__resume_inband();
>> -	else if (!(current->flags & PF_KTHREAD) &&
>> -		test_thread_flag(TIF_NEED_FPU_LOAD))
>> -		switch_fpu_return();
>> +	} else {
>> +		  if (unlikely(ti_work & _TIF_NEED_FPU_LOAD &&
>> +				  !(current->flags & PF_KTHREAD)))
>> +			  switch_fpu_return();
>> +	}
>> }
>
> For the whole series:
> Reviewed-by: Richard Weinberger <richard@nod.at>
>

These are the two remaining patches in the final series, ok for both?

tick: irq_pipeline: fix proxying of a broadcast device
x86: dovetail: reinstate I/O bitmap on user entry

> Thanks for addressing the issue so quickly. :-)
>

You are welcome, your test case made it easy.

--=20
Philippe.

