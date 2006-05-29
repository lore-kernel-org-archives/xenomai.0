Message-ID: <447ADD9E.80704@domain.hid>
Date: Mon, 29 May 2006 13:40:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Porting xeno-{info|load|test} to a busybox system
References: <200605252134.08614.niklaus.giger@domain.hid>
	<200605281200.18974.niklaus.giger@domain.hid>
	<44797F49.7020705@domain.hid>
	<200605281641.56813.niklaus.giger@domain.hid>
In-Reply-To: <200605281641.56813.niklaus.giger@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig154C72159BAACBEF9D34BEA4"
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
To: niklaus.giger@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig154C72159BAACBEF9D34BEA4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Niklaus Giger wrote:
> Am Sonntag, 28. Mai 2006 12:45 schrieb Jan Kiszka:
>> Niklaus Giger wrote:
>>> Am Samstag, 27. Mai 2006 18:42 schrieb Jan Kiszka:
> <..>
>>> Added a "ps | grep $_j" to show whether a dd job is still running bef=
ore
>>> killing it. Now, at least running under the busybox. the dd jobs get
>>> killed as they should. Therefore I added a "killall dd" for the case =
the
>>> dd_jobs variable is empty.
>> But there is still no load during the tests, correct?
> Yes. But now it should. The dd_jobs got killed too early, as under the =
BusyBox=20
> the trap exit handler got called too early. I think there are some subt=
le=20
> differences between the trap of the BusyBox- and the Bash-shell.
>=20
> Now I store the pids in a file under /var/lock. Tested it under bash an=
d=20
> busybox, works okay for me.=20
>=20
> Options like "-4-W 'dd if=3D/dev/hda1 of=3D/dev/null'" should also be h=
andled=20
> correctly.

Default workload behaves as expected now, but specifying something
different here via -W let the script hang on the workload startup.

>=20
> Options -L -m -M not tested under the BusyBox PPC405 target, as there I=
 do not=20
> have access to curl, script and mail.
>=20
> <..>
>> - special characters in line 152 of xeno-test:
> Sorry. Corrected. I think kate did not handle a paste from your e-mail =
message=20
> correctly
> <..>
>> - the output of xeno-test contains this error:
> <..>
>> /bin/xeno-test: /bin/xeno-test: 325:  : not found
> May be the result of above error? Could not reproduce it here. Could tr=
y again=20
> the attached patch?

Basically, it runs fine. But I have two further suggestions:

o some kind of summary of the completed rt-tests on script termination.
  I know what to lock for in the logs, but will the newbie do so?

o a switch to control the test periods. I'm playing with a patch to
  control the aperiodic timer resolution. When I tune it to 1 ms e.g.,
  having an option to push the test tool periods at this level as well
  would be nice.

Thanks a lot for your effort!

Jan


--------------enig154C72159BAACBEF9D34BEA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEet2eniDOoMHTA+kRAgO1AJ9HaH28uR7H5yCrk0lhdYeg1nRiMQCfVvuo
gjy3/Wy5QLsiDKSN7ICES8A=
=y3qX
-----END PGP SIGNATURE-----

--------------enig154C72159BAACBEF9D34BEA4--

