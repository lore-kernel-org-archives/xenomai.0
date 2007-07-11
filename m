Message-ID: <4694FD99.3030405@domain.hid>
Date: Wed, 11 Jul 2007 17:56:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>	<20070625175107.438849fa@domain.hid>	<467FF391.8020401@domain.hid>	<20070627105726.7db7a459@domain.hid>	<46825054.7030800@domain.hid>	<20070629164326.15579570@domain.hid>	<4690B86C.1000907@domain.hid>	<20070711155932.4b88699e@domain.hid>	<4694E96B.5020801@domain.hid>
	<20070711173545.709225f1@domain.hid>
In-Reply-To: <20070711173545.709225f1@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig89A84A9593AE0C120EA52DE2"
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
--------------enig89A84A9593AE0C120EA52DE2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Wed, 11 Jul 2007 16:30:03 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>> Daniel Simon wrote:
>>> On Sun, 08 Jul 2007 12:11:56 +0200
>>> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>>>
>>> Hello,
>>>> You are welcome to test, fix, improve, or just use it. Looking forwa=
rd
>>>> to your feedback!
>>> here are attached some corrections against your previous patch (itsel=
f against
>>> #2758 files): from my tests I now get likely exectime values from bot=
h remote
>>> and self measurement (i.e. we get the accumulated exectime at the ins=
tant we
>>> call rt_task_inquire ), and the stats given in /proc still seem to be=
have
>>> normally...
>>>
>>> the full patch against the original 2758 version is also given in att=
achement
>> To check if I got it the first attachment is an add-on patch, the seco=
nd
>> one is the base patch as in my repos + the former add-on patch?
> yes
>> Then let's comment on the add-on:
>>
>>> diff -urN xenomai-2758/include/nucleus/stat.h xenomai-2758-V2/include=
/nucleus/stat.h
>>> --- xenomai-2758/include/nucleus/stat.h	2007-07-11 15:16:14.000000000=
 +0200
>>> +++ xenomai-2758-V2/include/nucleus/stat.h	2007-07-11 15:09:38.000000=
000 +0200
>>> @@ -42,7 +42,7 @@
>>>  do { \
>>>  	(sched)->current_account->total +=3D \
>>>  		date - (sched)->last_account_switch; \
>>> -	(sched)->last_account_switch =3D date; \
>>> +	(sched)->last_account_switch =3D (sched)->current_account->start =3D=
 date; \
>> That looks bogus on first sight, but I might miss your intention.
>> current_account points to the overall stats of an accounted entity.
>> Therefore, start must always contain the start time, not the last swit=
ch
>> time. Please explain your idea.
>=20
> sorry, I forgot to delete this attempt to correct a former bug, it's us=
eless now, line 45 in stat.h remains as=20
> in your original patch
>=20
> 	(sched)->last_account_switch =3D date; \
>=20
> just tested, the exectime measure still works...
>>>  	/* All changes must be committed before changing the current_accoun=
t \
>>>  	   reference in sched (required for xnintr_sync_stat_references) */=
 \
>>>  	xnarch_memory_barrier(); \
>>> @@ -71,6 +71,9 @@
>>>  #define xnstat_runtime_get_start(account)	((account)->start)
>>>  #define xnstat_runtime_get_total(account)	((account)->total)
>>> =20
>>> +/* Obtain last time something has been switched */
>>> +#define xnstat_runtime_get_last_switch(sched)	((sched)->last_account=
_switch)
>>> +
>> OK (though a more precise comment would be good :))
>>
> /* Get the last time the calling thread was switched active */=20
>=20
> may be better, but it could be also an intr. handler, isn't?

Yep, we have executable entities here (threads and interrupt handlers)
that have an exectime account. And that account is switched.

"Get last account switch date on given sched", or so.

>=20
>>>  /* Reset statistics from inside the accounted entity (e.g. after CPU=

>>>     migration). */
>>>  #define xnstat_runtime_reset_stats(stat) \
>>> @@ -113,6 +116,7 @@
>>>  #define xnstat_runtime_finalize(sched, new_account)		do { } while (0=
)
>>>  #define xnstat_runtime_get_start(account)			({ 0; })
>>>  #define xnstat_runtime_get_total(account)			({ 0; })
>>> +#define xnstat_runtime_get_last_switch(sched)			({ 0; })
>>>  #define xnstat_runtime_reset_stats(account)			do { } while (0)
>>> =20
>>>  typedef struct xnstat_counter {
>>> diff -urN xenomai-2758/include/nucleus/thread.h xenomai-2758-V2/inclu=
de/nucleus/thread.h
>>> --- xenomai-2758/include/nucleus/thread.h	2007-07-11 15:16:14.0000000=
00 +0200
>>> +++ xenomai-2758-V2/include/nucleus/thread.h	2007-07-11 14:28:15.0000=
00000 +0200
>>> @@ -294,7 +294,7 @@
>>>  #define xnthread_affinity(thread)          ((thread)->affinity)
>>>  #define xnthread_affine_p(thread, cpu)     xnarch_cpu_isset(cpu, (th=
read)->affinity)
>>>  #define xnthread_get_exectime(thread)      xnstat_runtime_get_total(=
&(thread)->stat.account)
>>> -#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_start(=
&(thread)->stat.account)
>>> +#define xnthread_get_lastswitch(thread)    xnstat_runtime_get_last_s=
witch((thread)->sched)
>> Yeah, that was wrong. Did your first patch hunk relate to an initial
>> attempt to fix this bug?
>>
> yes, it was made to cancel an extra period in the measure
>>> =20
>>>  /* Class-level operations for threads. */
>>>  static inline int xnthread_get_denormalized_prio(xnthread_t *t)
>>> diff -urN xenomai-2758/ksrc/skins/native/task.c xenomai-2758-V2/ksrc/=
skins/native/task.c
>>> --- xenomai-2758/ksrc/skins/native/task.c	2007-07-11 15:16:14.0000000=
00 +0200
>>> +++ xenomai-2758-V2/ksrc/skins/native/task.c	2007-07-11 15:22:10.0000=
00000 +0200
>>> @@ -1144,10 +1144,13 @@
>>>  	info->cprio =3D xnthread_current_priority(&task->thread_base);
>>>  	info->status =3D xnthread_state_flags(&task->thread_base);
>>>  	info->relpoint =3D xntimer_get_date(&task->thread_base.ptimer);
>>> +	if(task =3D=3D xeno_current_task())
>>>  	info->exectime =3D xnarch_tsc_to_ns(
>>>  		xnthread_get_exectime(&task->thread_base) +
>>>  		xnstat_runtime_now() -
>>>  		xnthread_get_lastswitch(&task->thread_base));
>>> +	else=20
>>> +	  info->exectime =3D xnarch_tsc_to_ns(xnthread_get_exectime(&task->=
thread_base));
>> OK, second bug taken. But you approach was written without SMP in mind=

>> (while I thought too much about SMP). The correct condition is "task i=
s
>> running, somewhere?":
>>
>> if (task->thread_base.sched->runthread =3D=3D &task->thread_base)
>> 	<exectime up to now>
>> else
>> 	<currently stored exectime>
>=20
> Can I leave you handling (and testing) this correction, as I don't have=
 a running Xenomai/SMP machine at hand?

Let's find a compromise: I will try to role out -v2 of this patch with
your fixes soon. And you will try to do the in-depth tests of exectime
reporting once you have a Xenomai box again? Hacking is cheap, testing
takes the time... :) Or does the test code you once submitted report
clear results /wrt the correctness of the exectime data?

Jan


--------------enig89A84A9593AE0C120EA52DE2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFGlP2ZniDOoMHTA+kRAoJLAJ0QszcR56ALqSuXkbz8faqadf+FJQCXcYEo
FidCrSBDcmUD4fe8broEdQ==
=HVII
-----END PGP SIGNATURE-----

--------------enig89A84A9593AE0C120EA52DE2--

