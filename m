Message-ID: <467FF391.8020401@domain.hid>
Date: Mon, 25 Jun 2007 18:55:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>
	<20070625175107.438849fa@domain.hid>
In-Reply-To: <20070625175107.438849fa@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9E39956401FCC7A111B907BF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E39956401FCC7A111B907BF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Fri, 08 Jun 2007 13:20:11 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
> Hello,
>=20
>> Well, the best (=3D=3Dmost comfortable :o) ) way from my POV would be =
if you
>> could try rebasing your work on your own first. Questions, even on min=
or
>> details, are always welcome, review on patches will be provided. Shoul=
d
>> be no problem to get this into Xenomai 2.4.
>>
>> The rough to-do list would be:
>>
>>  o add some persistent runtimer counter to xnthread::stat and maintain=

>>    it
>>  o introduce an xnpod service (inline function) to obtain it (let that=

>>    thing return [0..LONGLONG_MAX] when stats are available, -1
>>    otherwise)
>>  o export the runtime via struct rt_task_info, maybe also the task sta=
rt
>>    time
>=20
> Coming back on this topic:
> please find attached a first draft of a patch following (more or less) =
 your
> suggestions:
> -there is an additional field "exectime" in  TASK_INFO, which can be se=
t by
> rt_task_inquire and read in the info structure (the computation is slig=
htly
> different for self and remote measurement);
> -xnthread_get_exectime() and xnthread_get_lastswitch() pass the values =
of the
> current thread's  timing out of xn;
> -exectime and lastswitch times are stored in an extended xnstat_runtime=
_t,
> updated by xnstat_runtime_update() (but not exactly like the "total" it=
em)

That was not my idea, and there is a reason for it, see below.

>=20
> it has been tested (only on  P3 single core cpu) with the testexec prog=
ram also
> attached : there are 2 periodic tasks, clockit and loop, which measure
> either their exectime, or the one of the other task: the measures=20
> seems reasonable, except when the clockit task measures itself, in that=
 case the
> first and second printed values are always absurd for a reason I cannot=

> understand...)

A few generic wishes related to your patch:

 - Please don't include debug or commented out code in your patches.

 - Please avoid unrelated changes

 - Please use an editor that properly formats your code, e.g. doesn't
   insert spaces where tabs belong according to kernel style

>=20
> Only works in primary mode... (also I hope that the tsc is monotonic?)

Don't worry, TSC can be considered monotonic under Xenomai (that's why
you have to switch off frequency scaling e.g.).

>=20
> I have no idea of what may happen on a smp or when on the fly migrating=
 tasks!

SMP should not be an issue, given that we rely on more or less
synchronised TSCs anyway.

=2E..
> diff -urN xenomai-2.3.1-orig/include/nucleus/stat.h xenomai-2.3.1/inclu=
de/nucleus/stat.h
> --- xenomai-2.3.1-orig/include/nucleus/stat.h	2006-12-26 19:38:59.00000=
0000 +0100
> +++ xenomai-2.3.1/include/nucleus/stat.h	2007-06-25 15:48:25.000000000 =
+0200
> @@ -31,6 +31,10 @@
> =20
>  	xnticks_t total; /* Accumulated execution time */
> =20
> +	xnticks_t exectime; /* Overall execution time from taskspawn upto las=
tswitch*/
> +
> +	xnticks_t lastswitch; /* Last time the task was made active */
> +
>  } xnstat_runtime_t;
> =20
>  /* Return current date which can be passed to other xnstat services fo=
r
> @@ -42,6 +46,10 @@
>  do { \
>  	(sched)->current_account->total +=3D \
>  		start - (sched)->last_account_switch; \
> +	(sched)->current_account->exectime +=3D \
> +                xnstat_runtime_now() - (sched)->last_account_switch; \=

> +	(sched)->current_account->lastswitch =3D \
> +                xnstat_runtime_now(); \

My idea was to keep a persistent version the existing xnstat_runtime_t
instance in xnthread (and later on also xnintr). That one shall not be
reset on readout via /proc.

Instead, you establish quite some new calculations that break
the existing API (the switch date is given via "start" - which was
misnamed so far, I just changed it to "date") and increase the runtime
overhead in the hotpath. Why? All the information you should need is
already there, it just has to be saved from being vaporised when the
user dumps /proc/xenomai/stat.

>  	(sched)->last_account_switch =3D start; \
>  } while (0)
> =20

Let's try it like this: Change Xenomai so that it leaves the existing
xnthread_t::stat.account untouched when it reads /proc. Rather add
something like "xnstat_runtime_t last;" to xnthread_t::stat. On readout
for /proc output, do the stats now like "account-last" and then move
account into last. For your task exectime, you can then read
xnthread_t::stat.account directly, because it will always reflect the
full task history. Would't this work better?

Thanks for working on this!

Jan


--------------enig9E39956401FCC7A111B907BF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGf/ORniDOoMHTA+kRArGGAJ0fD146poG4jCH5opuXY2MdwNiOmACcCrSk
9jAnZpggeRgoLBePDRW3M2E=
=w7qs
-----END PGP SIGNATURE-----

--------------enig9E39956401FCC7A111B907BF--

