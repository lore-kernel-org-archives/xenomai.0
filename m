Message-ID: <443A9410.50402@domain.hid>
Date: Mon, 10 Apr 2006 19:21:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [BUG?] stalled xeno domain
References: <4437D2EE.4040902@domain.hid>
	<4437E704.4010607@domain.hid>	<443A437B.6010403@domain.hid>
	<443A5212.7020001@domain.hid> <443A56E2.1010204@domain.hid>
	<443A5D7B.2040707@domain.hid>
In-Reply-To: <443A5D7B.2040707@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig50E1659F4C2334B2D5836664"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig50E1659F4C2334B2D5836664
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>>>>
>>>> Philippe, do you see any remaining issues, e.g. that the leak surviv=
ed
>>>> the task termination? Does this have any meaning for correct driver =
and
>>>> skin code?
>>>>
>>>
>>> The only way I could see this leakage survive a switch transition wou=
ld
>>> require it to happen over the root context, not over a primary contex=
t.
>>> Was it the case?
>>>
>>
>>
>> The task had to leave from primary mode. If I forced it to secondary
>> before terminating, the problem did not show up.
>>
>=20
> But does the code causing the leakage could have been run by different
> contexts in sequence, including the root one?
>=20

I don't think so. Bugs in our software aside, there should be no switch
to secondary mode until termination. Moreover, we installed a SIGXCPU
handler, and that one didn't trigger as well.


I just constructed a simple test by placing rthal_local_irq_disable() in
rt_timer_spin and setting up this user space app:

#include <stdio.h>
#include <signal.h>
#include <native/task.h>
#include <native/timer.h>

RT_TASK task;

void func(void *arg)
{
    rt_timer_spin(0);
}


void terminate(int sig)
{
    printf("joining...\n");
    rt_task_join(&task);
    rt_task_delete(&task);
    printf("done\n");
}


int main()
{
    signal(SIGINT, terminate);
    rt_task_spawn(&task, "lockup", 0, 10, T_FPU | T_JOINABLE | T_WARNSW,
                  func, NULL);
    pause();
    return 0;
}


Should this lock up (as it currently does) or rather continue to run
normally after the RT-task terminated? BTW, I'm still not sure if we are
hunting shadows (is IRQs off a legal state for user space in some skin?)
or a real problem - i.e. is it worth the time.

Jan


--------------enig50E1659F4C2334B2D5836664
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEOpQQniDOoMHTA+kRAtu+AJ4qY6BTCWP5OLmT+Z4WT2K29bfjiQCfR+Q+
pK+w6eI7tiBB0QLVBsJT9Lw=
=/xYo
-----END PGP SIGNATURE-----

--------------enig50E1659F4C2334B2D5836664--

