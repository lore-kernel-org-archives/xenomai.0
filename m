Message-ID: <44E42BE3.1060709@domain.hid>
Date: Thu, 17 Aug 2006 10:42:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problem with installation
References: <20060816190510.20935.qmail@domain.hid>	<44E36F6A.7060004@domain.hid>
	<200608162137.09103.nicola17@domain.hid>	<44E37823.8080407@domain.hid>	<33646.155.98.4.150.1155767832.squirrel@domain.hid>
	<1155803145.4356.33.camel@domain.hid>
In-Reply-To: <1155803145.4356.33.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD1ED5FF3050D08CA6AEB6584"
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
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD1ED5FF3050D08CA6AEB6584
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Wed, 2006-08-16 at 16:37 -0600, Brandt Erickson wrote:
>> So, perhaps I spoke too soon.  The system does boot, but I just looked=
 in
>> the syslog and found this:
>>
>> 16 16:08:49 dewback kernel: [4294670.201000] I-pipe: Domain Xenomai
>> registered.
>> Aug 16 16:08:49 dewback kernel: [4294670.201000] Xenomai: hal/x86 star=
ted.
>> Aug 16 16:08:49 dewback kernel: [4294670.231000] Xenomai: real-time
>> nucleus v2.2 (Engines Of Creation) loaded.
>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting nat=
ive
>> API services.
>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting POS=
IX
>> services.
>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: starting RTD=
M
>> services.
>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: incompatible=

>> timer mode (aperiodic found, need periodic).
>> Aug 16 16:08:49 dewback kernel: [4294670.232000] Xenomai: VxWorks skin=

>> init failed, code -16.
>>
>> my .config is attached.  As far as I can tell, my timer is periodic an=
d
>> not aperiodic.  My kernel is 2.6.16 patched with xenomai-2.2.0 from th=
e
>> download page and not the trunk.
>=20
> You need to build the native and POSIX skins as modules, so that they d=
o
> not override the timing mode (they both request aperiodic mode to the
> nucleus, which conflicts with the VxWorks skin initializing after them)=
=2E
>=20

Mmh, not on my test setup: once you set a reasonable period, all skins
boot into periodic mode.

Jan


--------------enigD1ED5FF3050D08CA6AEB6584
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE5CvjniDOoMHTA+kRAgbJAJ415kDlXwD5On5XIaF/dRP8f7TZ2wCfd6py
0+YhMPcjAjSabMNgkL3nuMI=
=7+qt
-----END PGP SIGNATURE-----

--------------enigD1ED5FF3050D08CA6AEB6584--

