References: <20220524144631.25020-1-jamienstar@163.com>
 <871qwgp8nd.fsf@xenomai.org>
 <41546ac9-21d0-c42d-f0c5-87c874d32825@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] x86/fpu: fix compile error without kernel_fpu_disabled()
Date: Thu, 09 Jun 2022 10:43:59 +0200
In-reply-to: <41546ac9-21d0-c42d-f0c5-87c874d32825@siemens.com>
Message-ID: <87czfiw7ii.fsf@xenomai.org>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: jamienstar@163.com, florian.bezdeka@siemens.com, xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 26.05.22 18:19, Philippe Gerum wrote:
>>=20
>> jamienstar@163.com writes:
>>=20
>>> From: Jamie Huang <jamienstar@163.com>
>>>
>>> In v5.18-evl-rebase, function kernel_fpu_disabled() has been removed in
>>> commit 59f5ede3bc0f("x86/fpu: Prevent FPU state corruption"), so we will
>>> get compile error when CONFIG_DOVETAIL is enabled:
>>> arch/x86/kernel/fpu/core.c:931:6: error: implicit declaration of functi=
on =E2=80=98kernel_fpu_disabled=E2=80=99; did you mean =E2=80=98perf_pmu_di=
sable=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>>>     if (kernel_fpu_disabled()) {
>>>         ^~~~~~~~~~~~~~~~~~~
>>>         perf_pmu_disable
>>> cc1: all warnings being treated as errors
>>> So, fix it.
>>>
>>> Signed-off-by: Jamie Huang <jamienstar@163.com>
>>> ---
>>>  arch/x86/kernel/fpu/core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
>>> index 6a0d1e7f278f..c3adbbb73226 100644
>>> --- a/arch/x86/kernel/fpu/core.c
>>> +++ b/arch/x86/kernel/fpu/core.c
>>> @@ -928,7 +928,7 @@ void fpu__suspend_inband(void)
>>>  	 * preemption of an inband kernel context currently using the
>>>  	 * fpu by a thread which resumes on the oob stage.
>>>  	 */
>>> -	if (kernel_fpu_disabled()) {
>>> +	if (this_cpu_read(in_kernel_fpu)) {
>>>  		save_fpregs_to_fpstate(kfpu);
>>>  		__cpu_invalidate_fpregs_state();
>>>  		oob_fpu_set_preempt(&tsk->thread.fpu);
>>=20
>> Merged adding the same fixup to the comment nearby, thanks.
>>=20
>
> Could you backport to 5.15 as well?
>
> https://gitlab.com/Xenomai/xenomai-hacker-space/-/jobs/2563340960
>

Done, this should build now.

--=20
Philippe.

