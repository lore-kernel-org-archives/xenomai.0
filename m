Message-ID: <49346FD3.8050609@domain.hid>
Date: Tue, 02 Dec 2008 00:14:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A820268933E41D449CC13B5E097C1E2F0363CE21@domain.hid>
In-Reply-To: <A820268933E41D449CC13B5E097C1E2F0363CE21@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0D22775613A57C4E247CCE24"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] External PCIe device: MSI interrupt install
	hangs up the CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rubio, Martial" <Martial.Rubio@domain.hid>
Cc: jeanfrancois.gilot@domain.hid, xenomai@xenomai.org, "Dupeyrou,
	Gilles" <Gilles.Dupeyrou@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0D22775613A57C4E247CCE24
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rubio, Martial wrote:
>  Hi Jan ...
>=20
> ... Thanks a lot for your reply ... And the workaround is OK!
>=20
> 2 little last precisions about this topic :=20
>=20
> 	-is it necessary to rename all the "rt"'s entry points as
> "nrt"'s entry points (close,read,write,ioctl) ?

For close, yes, but the rest should be fine - otherwise the problem is
fatal for you. Changing the rest, which is likely supposed to do the
critical work, will leave you without any improvement over plain Linux.
I said "should" because there is the risk that some other code paths of
PCIe MSI handling triggers the bug report as well.

> 	-is the interrupt handler "vxworks_tick_time_module" (when a HW
> source of PEV1100 will be enable)=20
> 	running in Linux (not critical) mode ? =20

Is that the handler you register with RTDM? Then no, it will be run over
the primary domain, ie. Xenomai.

>=20
> It's very easy (by looking at the name of the interrupt handler) to kno=
w
> why I ask these questions :
> vxworks_tick_time_module is waiting for an external pulse at 1 ms (and
> other MSI VME interrupts of course)
> provided by an external PCIe device PEV1100 in order to announce tick
> and so schedule an 'old' VME real time=20
> Multi-cpu Application (so I'm using also Xenomai VxWorks skins for the
> migration in multi-core environment)
> ... Only VME slave boards will be stay in the distant crate!
>=20
> It's perharps a little bit fresh ... But it must go right !!!
>=20
> Regards=20
>=20
> Martial=20
>=20

Jan


--------------enig0D22775613A57C4E247CCE24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkk0b9cACgkQniDOoMHTA+keOwCeLVHFTSeowiVPsomNzfhnb6Zo
jwwAnjRGR2XjEG0CDd/5LzLQg1FwBoSe
=Nvm/
-----END PGP SIGNATURE-----

--------------enig0D22775613A57C4E247CCE24--

