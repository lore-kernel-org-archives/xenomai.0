From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4AF1474C.7000701@domain.hid>
References: <4AF1474C.7000701@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Nov 2009 11:50:56 +0100
Message-ID: <1257331856.2210.85.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [Xenomai-help] How to fix t_delete call in psos
	skin?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexandre Coffignal <alexandre.coffignal@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2009-11-04 at 10:20 +0100, Alexandre Coffignal wrote:
> Hello,
>=20
> I'm trying to use t_delete routine in psos skin (xenomai-2.4.7) from a=20
> user space application .
> I'm encountring two different behaviors:
> -1- Calling t_delete(0) from a psos task seems to work perfectly (e.g.=20
> task self deletes).
> -2- Calling t_delete(task_id) with another task id (e.g. current task=20
> tries to delete another task) doesn't result in task deletion but=20
> returns 0 (success).
>=20
> I've been through both psos skin (ksrc/psos+/task.c) and nucleus=20
> (ksrc/nucleus/pod.c) source code.
>=20
> xnpod_delete_thread() behaves differently depending on previously=20
> described t_delete calls:
>=20
> -1- First case (t_delete(0)):
>=20
> Execution skip condition in ksrc/nucleus/pod.c at line 1173:
>=20
>   if (xnthread_user_task(thread) !=3D NULL &&
>       !xnthread_test_state(thread, XNDORMANT) &&
>       !xnpod_current_p(thread)) {
>       if (!xnpod_userspace_p())
>           xnshadow_send_sig(thread, SIGKILL, 1);
>       /*
>        * Otherwise, assume the interface library has issued
>        * pthread_cancel on the target thread, which should
>        * cause the current service to be called for
>        * self-deletion of that thread.
>        */
>       goto unlock_and_exit;
>   }
> #endif /* CONFIG_XENO_OPT_PERVASIVE */
>=20
> and continues to run after it. This results in a successful deletion.
>=20
>=20
> -2- Second case:
>=20
> Execution enters one of the first conditions (if=20
> (xnthread_user_task(thread))...)  but skip the second one :=20
> xnshadow_send_sig(thread, SIGKILL, 1) is not executed;
> goto unlock_and_exit; instruction is then executed.
> ->Our thread is never deleted.
>=20
> -3-
> Modifing actual source code by commenting goto intruction or moving it=20
> into second condition (if (!xnpod_userspace_p()) mentioned above)=20
> results in a working t_delete (task_id).
>=20
> - I'm not sure of the possible side effects of such a modification?
> - Is it correct to do so?
>=20

Nope, this would defeat the purpose of testing those conditions, and end
up breaking the nucleus. The implicit logic behind such block is that a
real-time task should always exit on behalf of its own context, so that
its Linux side never survives the removal of the mated Xenomai shadow
TCB. Otherwise, you would get a real-time Xenomai task running without
any Xenomai TCB.

The fix has to happen in userland, and only there, by implementing what
the comment suggests, which is still missing from the psos skin. i.e.
have the t_delete() wrapper issue pthread_cancel() under the hood, in
src/skins/psos/task.c. The native and POSIX APIs illustrate what is
needed in this respect, albeit the way they implement this is not 100%
portable to the psos skin context.

PS: this discussion should rather happen on xenomai-core. Redirecting
now.

>=20
> As mentioned in the source code comment, it is assumed "the interface=20
> library has issued pthread_cancel" ...
> I assume it might be missing somewhere?
>=20
> Please can you help on this topic?
>=20
> Thanks in advance.
>=20
> Please find a patch regarding this modification.
>=20
> diff --git a/ksrc/nucleus/pod.c b/ksrc/nucleus/pod.c
> index 9348ce1..ee362df 100644
> --- a/ksrc/nucleus/pod.c
> +++ b/ksrc/nucleus/pod.c
> @@ -1177,14 +1177,16 @@ void xnpod_delete_thread(xnthread_t *thread)
>             !xnthread_test_state(thread, XNDORMANT) &&
>             !xnpod_current_p(thread)) {
>                 if (!xnpod_userspace_p())
> +               {
>                         xnshadow_send_sig(thread, SIGKILL, 1);
> +                       goto unlock_and_exit;
> +               }
>                 /*
>                  * Otherwise, assume the interface library has issued
>                  * pthread_cancel on the target thread, which should
>                  * cause the current service to be called for
>                  * self-deletion of that thread.
>                  */
> -               goto unlock_and_exit;
>         }
>  #endif /* CONFIG_XENO_OPT_PERVASIVE */
> =20

>=20
>=20
> Fabrice.
>=20
>=20
> --------------------------------
> C=C3=A9noSYS <http://www.cenosys.com>
> 10, Rue Xavier Bichat
> F-72000 Le MANS
> --------------------------------
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


--=20
Philippe.



