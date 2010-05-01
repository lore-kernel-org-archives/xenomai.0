Message-ID: <4BDC3B80.6030405@domain.hid>
Date: Sat, 01 May 2010 16:32:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1O78nO-0008PE-EK@xenomai.org> <4BDC332E.2010804@domain.hid>
	<4BDC357A.30803@domain.hid> <4BDC3686.9050004@domain.hid>
	<4BDC3829.9070306@domain.hid> <4BDC3A09.2060106@domain.hid>
	<4BDC3ADA.4040608@domain.hid>
In-Reply-To: <4BDC3ADA.4040608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC526FE06ACD76C372D69B972"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : native: Improve fault
 tolerance /wrt multiple task deletions
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC526FE06ACD76C372D69B972
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Gilles Chanteperdrix wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> GIT version control wrote:
>>>>>>> Module: xenomai-jki
>>>>>>> Branch: for-upstream
>>>>>>> Commit: 5d2fa6c7578683e036d88bc6dbb6a7f458dfe705
>>>>>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3D=
5d2fa6c7578683e036d88bc6dbb6a7f458dfe705
>>>>>>>
>>>>>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>> Date:   Wed Apr 28 15:08:11 2010 +0200
>>>>>>>
>>>>>>> native: Improve fault tolerance /wrt multiple task deletions
>>>>>>>
>>>>>>> As we may pass the pthread handle of an RT_TASK directly to glibc=
, we
>>>>>>> may trigger a SIGSEGV if the underlying thread was already termin=
ated.
>>>>>>> Try to catch this application mistakes by clearing the handle at =
least
>>>>>>> in that task descriptor which successfully ran rt_task_delete or
>>>>>>> rt_task_join.
>>>>>>>
>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>> Ok. I have tested this patch (though I could not find whether it w=
as
>>>>>> discussed on the mailing list). And in fact, it looks to me like i=
t
>>>>>> turns an application error into a silently working application.
>>>>> Then there is probably something broken: rt_task_delete is supposed=
 to
>>>>> return -EIDRM of the passed handle no longer exists. That's at leas=
t
>>>>> what the doc says. The point of this patch is to turn an applicatio=
n
>>>>> crash into a proper error return value (and that not only for
>>>>> --enable-debug).
>>>> Here is the test I used:
>>>> #include <stdio.h>
>>>> #include <native/task.h>
>>>> #include <sys/mman.h>
>>>>
>>>> void task_main(void* arg)
>>>> {
>>>>         rt_task_sleep(1000000000);
>>>> }
>>>>
>>>> int main(void)
>>>> {
>>>>      RT_TASK task;
>>>>
>>>>      mlockall(MCL_CURRENT|MCL_FUTURE);
>>>>      rt_task_create(&task, "task", 128*1024, 99, T_FPU|T_JOINABLE);
>>>>      rt_task_start(&task, task_main, NULL);
>>>>      fprintf(stderr, "join: %d\n", rt_task_join(&task));
>>>>      fprintf(stderr, "delete: %d\n", rt_task_delete(&task));
>>>> }
>>>>
>>>> it prints:
>>>> join: 0
>>>> delete: 0
>>>>
>>>> This said, I like the segfault, because people probably never check =
the
>>>> return value of rt_task_join/rt_task_delete (which is, I guess, the
>>>> reason why phtread_cancel and pthread_join segfault themselves, beca=
use
>>>> the posix spec allows to return ESRCH in that case).
>>> Well, that's kind of hard to sell to people writing software based on=

>>> documentation. We documented -EIDRM, so we should make it work like
>>> this. Will look into this later.
>>>
>>> The fact that pthread_cancel /may/ crash on invalid thread handles is=
 an
>>> implementation detail: The handle is a pointer to an object that /may=
/
>>> no longer exist in memory when dereferenced.
>> Ok, another point is that when cancelling a joinable thread,
>> pthread_join should still be called after pthread_cancel. So,
>> rt_task_join should still be able to call pthread_join after a call to=

>> rt_task_delete.
>>
>> Running pthread_join inside rt_task_delete is not an option, as there
>> would be a risk for deadlocks.
>>
>=20
> So we should always pthread_detach before canceling a thread in
> rt_task_delete?

Err, after, but only if it was joinable. Think we need to track
T_JOINABLE in user space as well.

Jan



--------------enigC526FE06ACD76C372D69B972
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvcO4AACgkQitSsb3rl5xTA2ACcCygmFiz+k3Ww7NHHVZ2MWkSd
18oAniGZ8CgAdNTKkDT1QuLUtWiDu90q
=twOO
-----END PGP SIGNATURE-----

--------------enigC526FE06ACD76C372D69B972--

