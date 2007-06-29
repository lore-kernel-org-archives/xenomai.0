Message-ID: <46851E97.7030402@domain.hid>
Date: Fri, 29 Jun 2007 17:00:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>	<20070625175107.438849fa@domain.hid>	<467FF391.8020401@domain.hid>	<20070627105726.7db7a459@domain.hid>	<46825054.7030800@domain.hid>
	<20070629164326.15579570@domain.hid>
In-Reply-To: <20070629164326.15579570@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig505E459118F012DA67C1A452"
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
--------------enig505E459118F012DA67C1A452
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Wed, 27 Jun 2007 13:56:04 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>>> On Mon, 25 Jun 2007 18:55:45 +0200
>>> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>>>> My idea was to keep a persistent version the existing xnstat_runtime=
_t
>>>> instance in xnthread (and later on also xnintr). That one shall not =
be
>>>> reset on readout via /proc.
>>> Is it necessary to keep also the reset one?
>> Yep, at least virtually (as in my proposal): We are dumping CPU share
>> percentages in /proc, and those need to be calculated over the same
>> measurement period. Thus we restart the measurement each time the user=

>> reads the stats.
>>
>>>> Let's try it like this: Change Xenomai so that it leaves the existin=
g
>>>> xnthread_t::stat.account untouched when it reads /proc. Rather add
>>>> something like " last;" to xnthread_t::stat. On readout
>>>> for /proc output,=20
>=20
>> That's one spot, the other is xnpod_migrate_thread()
>> (xnstat_runtime_reset_stats()) IIRC.
>=20
> ok, i've found only these two reset points.
>=20
> the account structure is also partially touched by  xnstat_runtime_fina=
lize()
> in pod.c, I don't understand when and why...

xnstat_runtime_finalize is called when a task passes away, i.e. you
wouldn't be able to retrieve it's stats later on anyway.

>=20
>>>> account into last. For your task exectime, you can then read
>>>> xnthread_t::stat.account directly, because it will always reflect th=
e
>>>> full task history. Would't this work better?
>> Jan
>>
> please find attached a new patch following these ideas:
>  (patch against svn trunk Revision: 2672)=20
>=20
> account is now persistent, its "start" field is the last_switch time, a=
nd the
> new xnstat_runtime_t "lastperiod" handles the past values necessary to =
compute
> the runtime values plot at snapshot time.
>=20
> from a few trials, it seems that /proc/xenomai/stat still behaves norma=
lly (i.e.
> like in the original version where the first reading of stat does gives=
 nothing
> for the tasks runtime?)

The first dump is always bogus as the task set changed since the
previous measurement date (here: Xenomai start-up time).

>=20
> exectime returns likely values when a task is measured by another one, =
but self
> measurement (with the NULL task calling parameter in rt_task_inquire) s=
ometime
> provides incoherent values (e.g. returns the period rather than the exe=
ctime,
> or returns non-monotonic exectime values...).=20
> I could not manage to fix this bug upto now.=20

I think I already see one, though it doesn't explain all your observed
behaviour to me:

> --- xenomai-orig/ksrc/skins/native/task.c	2007-06-28 10:20:17.000000000=
 +0200
> +++ xenomai/ksrc/skins/native/task.c	2007-06-28 17:20:29.000000000 +020=
0
> @@ -1144,7 +1144,10 @@
>  	info->cprio =3D xnthread_current_priority(&task->thread_base);
>  	info->status =3D xnthread_state_flags(&task->thread_base);
>  	info->relpoint =3D xntimer_get_date(&task->thread_base.ptimer);
> -
> +	if(task =3D=3D xeno_current_task())
> +	  info->exectime =3D xnthread_get_exectime(&task->thread_base) + (xns=
tat_runtime_now() - xnthread_get_lastswitch(&task->thread_base));
> +	else=20
> +	  info->exectime =3D xnthread_get_exectime(&task->thread_base);

Exectime is only updated on task switches. So you are not obtaining the t=
rue value when requesting your own data. Use the same formula for both ca=
ses.

> And unfortunately i'll be away and probably far from any xenomai-capabl=
e
> machine next week...
>=20

OK. I'll try to look into this in the meantime. But I think it should be =
no problem to merge a final version even after the approaching 2.4-rc1, t=
he patch is yet fairly confined.

Jan


--------------enig505E459118F012DA67C1A452
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGhR6XniDOoMHTA+kRAmyvAJ9Dzv7Btp/YfqXCvucnPjKMcOUW1QCaA6FP
T4LqWqt1YpYO/bdz4/pm1h8=
=qe0W
-----END PGP SIGNATURE-----

--------------enig505E459118F012DA67C1A452--

