Message-ID: <466ADF16.5010607@domain.hid>
Date: Sat, 09 Jun 2007 19:10:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>
	<4668440F.7020706@domain.hid>
	<1753.194.254.210.7.1181246882.squirrel@domain.hid>
	<46697391.4080006@domain.hid>
	<1807.194.254.210.7.1181405163.squirrel@domain.hid>
In-Reply-To: <1807.194.254.210.7.1181405163.squirrel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A5BAAFBF91C8D1F6A7AA678"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] real time task disapears... memory problem ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: desvages@domain.hid
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1A5BAAFBF91C8D1F6A7AA678
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

desvages@domain.hid wrote:
>> From my kernel console after running your program for a few seconds:
>>
>> Xenomai: watchdog triggered -- killing runaway thread 'MyAlarmServer'
>>
>> Previously, "rt_alarm_wait" was printed on the console, thus gsl_qp()
>> likely entered some infinite loop. You have the watchdog enabled as
>> well, so you should see the same effect, right?
>>
>> Jan
>=20
> In my console, I only see the "rt_alarm_wait". Is there something to
> activate to enable xenomai errors messages ?

Not local console, _kernel console_. Check your systems log files (eg.
/var/log/syslog or .../messages), or run "dmesg" to see the last kernel
messages.

>=20
> As this gsl_qp() function takes about 6/7 secondes to solve my quadrati=
c
> problem, the watchdog could effectively be the thing that goes wrong...=


Well, don't blame others until you are sure (=3D=3D you measured) that it=
 is
not your own code. :)

>=20
> To be sure to understand how works the watchdog in xenomai:
> - Is it a limit on the execution time (so time effectively used by the =
task)
> - or is it a limit on the response time (the time between the beginning=

> and the end of the task, even if it is preempted) ?

See documentation. Linux must be able to run at least once in _4_ seconds=
=2E

>=20
> Because, if it is the first case, maybe that putting the gsl_qp() funct=
ion
> in primary mode increases the execution time measured by xenomai, and t=
his
> activate the watchdog ? whereas in secondary mode, time is not counted =
by
> xenomai watchdog ?

Yes, secondary mode would be accounted to Linux, thus the watchdog would
be happy (and your Linux subsystem as well because it would be allowed
to breath).

>=20
> I will try to increase the watchdog time to see if this is only a matte=
r
> of a task taking to much time.

Wrong approach. First check how long your loop actually takes. If you
have to tweak the watchdog (and there is no bug in the trivial watchdog
code), it's your code that is broken.

Jan


--------------enig1A5BAAFBF91C8D1F6A7AA678
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGat8XniDOoMHTA+kRAinMAJ9RDhzDzcT8TF3pD7H19oLTKb+1swCfaRJv
H9+PV5sGQ+9jGdSgWuRuIG4=
=rTPw
-----END PGP SIGNATURE-----

--------------enig1A5BAAFBF91C8D1F6A7AA678--

