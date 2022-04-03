Date: Sun, 3 Apr 2022 18:32:55 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <317493564.212576.1649003575604.JavaMail.zimbra@nod.at>
In-Reply-To: <20220403144348.1775590-1-rpm@xenomai.org>
References: <20220403144348.1775590-1-rpm@xenomai.org>
Subject: Re: [PATCH v2] x86: dovetail: reinstate I/O bitmap on user entry
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@xenomai.org>


----- Urspr=C3=BCngliche Mail -----
> Von: "Philippe Gerum" <rpm@xenomai.org>
> An: "xenomai" <xenomai@xenomai.org>
> CC: "Philippe Gerum" <rpm@xenomai.org>, "Richard Weinberger" <richard.wei=
nberger@gmail.com>
> Gesendet: Sonntag, 3. April 2022 16:43:48
> Betreff: [PATCH v2] x86: dovetail: reinstate I/O bitmap on user entry

> From: Philippe Gerum <rpm@xenomai.org>
>=20
> We have to fix up the TSS with the proper I/O bitmap settings in
> arch_dovetail_switch_finish() when the incoming Dovetail-enabled task
> is about to re-enter user mode.
>=20
> This fixes an application crash observed when such a task would rely
> on iopl() to raise its I/O permissions then block, relinquishing the
> CPU to another task invalidating them, before the former eventually
> resumes in user mode.
>=20
> See https://xenomai.org/pipermail/xenomai/2022-March/047451.html.
>=20
> Reported-by: Richard Weinberger <richard.weinberger@gmail.com>
> Tested-by: Richard Weinberger <richard.weinberger@gmail.com>
> Signed-off-by: Philippe Gerum <rpm@xenomai.org>
> ---
> arch/x86/include/asm/dovetail.h | 16 ++++++++++++----
> 1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/dovetail.h b/arch/x86/include/asm/dovet=
ail.h
> index 9cf811fe98ba..940726f16f2e 100644
> --- a/arch/x86/include/asm/dovetail.h
> +++ b/arch/x86/include/asm/dovetail.h
> @@ -9,6 +9,7 @@
> #if !defined(__ASSEMBLY__) && defined(CONFIG_DOVETAIL)
>=20
> #include <asm/fpu/api.h>
> +#include <asm/io_bitmap.h>
>=20
> static inline void arch_dovetail_exec_prepare(void)
> {
> @@ -25,11 +26,18 @@ void arch_dovetail_switch_prepare(bool leave_inband)
> static inline
> void arch_dovetail_switch_finish(bool enter_inband)
> {
> -=09if (enter_inband)
> +=09unsigned int ti_work =3D READ_ONCE(current_thread_info()->flags);
> +
> +=09if (unlikely(ti_work & _TIF_IO_BITMAP))
> +=09=09tss_update_io_bitmap();
> +
> +=09if (enter_inband) {
> =09=09fpu__resume_inband();
> -=09else if (!(current->flags & PF_KTHREAD) &&
> -=09=09test_thread_flag(TIF_NEED_FPU_LOAD))
> -=09=09switch_fpu_return();
> +=09} else {
> +=09=09  if (unlikely(ti_work & _TIF_NEED_FPU_LOAD &&
> +=09=09=09=09  !(current->flags & PF_KTHREAD)))
> +=09=09=09  switch_fpu_return();
> +=09}
> }

For the whole series:
Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks for addressing the issue so quickly. :-)

Thanks,
//richard

