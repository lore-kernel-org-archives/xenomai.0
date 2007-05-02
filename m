Message-ID: <4638A574.5020706@domain.hid>
Date: Wed, 02 May 2007 16:51:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46388DCC.5070303@domain.hid> <46389325.7080200@domain.hid>
	<4638A368.9040705@domain.hid>
In-Reply-To: <4638A368.9040705@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig10A8E1E5BEB8ABDB1E0B96B4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] HELP!!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig10A8E1E5BEB8ABDB1E0B96B4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi Jan,
>=20
>> Maybe you missed the separated lists? rtnet-user-at-lists.sourceforge.=
net
>=20
> I did. Sorry. I think you even mentioned it before. Sorry again.
>=20
>>
>> But note in advance that RTnet for I/O coupling requires RTnet I/O
>> coupler that you cannot buy as there are no commercial ones. You would=

>> have to embed it on your own. Maybe you then rather want to use the
>> Ethercat MasterLibrary with RTnet to attach Ethercat I/O nodes.
>=20
> This looks like it may be a break. I had just found ethercat before thi=
s
> mail came in. By the look of things (very early) the hardware (Beckhoff=
)
> will give the IO and according to the vendor (who I have limited faith
> in by now) should make the time.
>=20
> According to the same vendor (whom I have limited faith in) I can use
> the standard ethernet hardware in PC's for ethercat. Unlike Powerlink
> (B&R whom I am at war with and also have limited faith in :)) which
> requires a special powerlink card.
>=20
> But my next problem will be to get xenomai to work with ethercat. You
> say I can try using the Ethercat Master library with RTnet. But why
> would I need RTnet? How will the layering look in this case? IOW what
> functionality will the ethernet master library provide and what will th=
e
> RTnet provide?
>=20
> Has anyone done this before?

[being in a hurry]
Check the links on www.rtnet.org to the related project at FMTC. They
even have mailing lists for detail questions.

The setup will be: Xenomai (basis) + RTnet (RT-NIC driver, core network
stack) + EML (userspace lib with Ethercat master code) + Your App
(linked against Xenomai and EML).

Jan




--------------enig10A8E1E5BEB8ABDB1E0B96B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGOKV0niDOoMHTA+kRAnCOAJ9RqchGZh9Ty0RwbyM0STTV46i+QgCfWKAq
XY0p6PVFzI1vg2hYsjcY8Zg=
=bw84
-----END PGP SIGNATURE-----

--------------enig10A8E1E5BEB8ABDB1E0B96B4--

