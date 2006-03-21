Message-ID: <441F5F31.70206@domain.hid>
Date: Tue, 21 Mar 2006 03:04:33 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200603201434.15258@domain.hid> <441EE01D.6020400@domain.hid>
	<441EE5D4.9000204@domain.hid>
	<200603210148.11118.berlemont.hauw@domain.hid>
In-Reply-To: <200603210148.11118.berlemont.hauw@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE4DADECA836243BF4875EFB2"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] COMEDI over RTDM (was: rtdm_event_timedwait hang-up)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE4DADECA836243BF4875EFB2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Alexis,

as this discussion starts to become architectural and low-level, I think
we should move it to xenomai-core and give people who are interested a
chance to jump onto it again there.

Alexis Berlemont wrote:
> Hi,
>=20
>>>>> I heard rumours of some COMEDI (www.comedi.org) port over RTDM rece=
ntly,
>>>>> don't know the current status.
>>>> Indeed. The rumour is called Alex.
>>> Yes, I know. I just don't wanted to drag someone to public, saying: "=
Hey
>>> man, already doing your job?" ;)
>> It's part of the anti-shyness treatment I'm administering to Alex...
>>
>>> But, as we all know him now, what is the current status then?
>=20
> My comedi port over RTDM is not completely over (and far from perfect).=
 The=20
> mmap functionnalities have not been rewritten yet. However, I have been=
=20
> working on
> -> the port of the comedi infrastructure layer (comedi/comedi_fops.c=20
> comedi/drivers.c comedi/range.c comedidev.h etc.)=20
> -> the rewriting of the driver comedi_test.c (which becomes comedi_test=
1.c)
> -> other test stuff has been written in comedi_test2.c (replications fu=
nctions=20
> to test comedi_write operations)
> -> the ports of comedi_config and comedilib (partially done for comedil=
ib),=20
> etc.
>=20
> This stuff is working (minor bugs appart) and I could give you a versio=
n in=20
> the next few days (I have to check "make dist" ;) and minor things).
>=20
> But there are plenty of things I am not happy with :
> -> the original comedilib version is not really well suited for rtdm. I=
n this=20
> library for many reasons; for example, you can find calls to malloc/fre=
e=20

Oops, not so nice.

> functions. If I stick to the original implementation, I have to either =
to ask=20
> for adding alloc stuff in user mode in rtdm skin or use another skin to=
=20
> manage allocations. None of these solutions seems interesting for me fo=
r many=20
> reasons. A lot of people  must be thinking I am overkill, it is true th=
at the=20
> comedilib allocations should be done at init time (comedi_open, comedi_=
close)=20
> then no need to fulfull real-time constraints but I think comedi should=
 be=20
> fully rtdm compliant; this would avoid tricky corner cases for=20
> developpers/users. The best and simplest solution for me would be some =
slight=20
> modifications in the comedilib API but I doubt everyone is OK with that=
=2E

Could you give some concrete use cases of the comedilib where dynamic
allocation is involved? I don't know that library actually. What does it
manage beyond calling the driver core?

>=20
> -> I think the comedi structures organization (comedi_device, subdevice=
,=20
> async, etc.) should be reviewed considering the rtdm architecture. Of c=
ourse,=20
> these modifications should not induce big changes in the comedi drivers=
=20
> source.

Please also give concrete examples here. RTDM devices should be
manageable by the user via file descriptors, just like normal devices.
What is different, what extra information is needed?

>=20
> -> etc.
>=20
> In fact, I wanted to propose two versions :
> -> a first implementation as close as possible from the original=20
> implementation and API.
> -> a second one a bit more adapted for rtdm.

What would be different with RTDM compared to the existing RTLinux and
RTAI support of comedi? Don't they use comedilib at all? Isn't there
some LXRT adoption in RTAI? Is it providing a different API?

>=20
> Thus, we could have compared the two versions and see if everyone agree=
s with=20
> the idea of adapting comedi infrastructure. It would have been a good=20
> opportunity to work closely with comedi developers community.

Yes, that would be best. But I guess it will not be too easy, as there
seems to exist a limited interest in RT on their side. Maybe it just
takes some (more) users explaining the requirements and the need. ;)

>=20
> Unfortunately, my second version is not finished yet. I still have some=
 work=20
> on it (non negligible). (I know I know I am slower than a turtle which =
learns=20
> programming with an amstrad cpc 6128 and damaged floppy disks ).=20
>=20
> If someone is interested in getting a version right now, I will try to =
send to=20
> him a tarball as soon as possible. Compared to original comedi deliveri=
es, I=20
> have not created two autotools tarballs (comedi and comedilib) but only=
 one.

Release early, release often ;). I would offer to have a look, maybe it
will clarify where the RTDM-specific problems are.

Jan


--------------enigE4DADECA836243BF4875EFB2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEH18xniDOoMHTA+kRAm33AJ9aNzZVICFamYo7YnPYzeSTOYnFTwCfaDQU
SY4FP+m7fLCvZi7orVAZ5as=
=5xOv
-----END PGP SIGNATURE-----

--------------enigE4DADECA836243BF4875EFB2--

