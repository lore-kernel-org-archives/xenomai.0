Message-ID: <457820AF.4070403@domain.hid>
Date: Thu, 07 Dec 2006 15:09:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] I/O privilege losted and killed message
References: <s577092a.032@domain.hid>
In-Reply-To: <s577092a.032@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD866F9244D26B4573A60860"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nicolas BLANCHARD <n.blanchard@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD866F9244D26B4573A60860
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Nicolas BLANCHARD wrote:
> Hello,
>=20
> Sometime i lose my i/o privilege put with the system call ioperm (in
> the main function of my program).
>=20
> My application stop with a "killed" message in the console and  in
> /proc/xenomai/fault i've an "general fault".
> To ignore this problem, i use the call system iopl (with full
> privilege) or recall ioperm before each inb or outb.
> But there is a problem, why i/o privilege are losted ?
>=20
> In attachment you can find an archive with an example (application and
> source) witch show the problem.
> This program has 2 task :
> - task_1 priority 23 period 100 ms, lock a mutex, access to /dev/rtc,
> unlock the mutex, outb on hardware.
> - task 2 priority 25 period 1 ms, do nothing !
>=20
> I put a 1 ms period to task_2 because it's near the speedest period on
> my cpu (166 MHz).
> With this period it stop immediatly.
> If i put 10 ms it's need 1 or 2 minutes.
>=20
> On my Pentium 4 (Ubuntu on VmWare worstation under WindowsXP), i put 30=

> ms (the more speed before overrun).
>=20
> If i use iopl (and not ioperm), no problem.
> If i just have task_1, no problem.
> If i don't use mutex (lock for Rtc access) on task_2, no problem.
>=20
> I use Xenomai Xenomai 2.3-rc2 (adeos 1.5-02), same probleme with
> 2.2.3.
>=20
> If you have an idea.

No idea yet and no time to dig out the reason. But I can confirm the
sporadic lost of ioperms of a Xenomai task that enters secondary mode
(QEMU UP with CONFIG_XENO_OPT_RPIDISABLE and CONFIG_PREEMPT_NONE).

Jan


--------------enigFD866F9244D26B4573A60860
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFeCCvniDOoMHTA+kRAq30AJ960oPKonUofMPY3ErdBQaUUVXj6gCcDHqy
Fd+ZmksECamrnZYiocG9vmQ=
=Q4kr
-----END PGP SIGNATURE-----

--------------enigFD866F9244D26B4573A60860--

