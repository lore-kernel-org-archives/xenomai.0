Message-ID: <44242CD7.7080409@domain.hid>
Date: Fri, 24 Mar 2006 18:31:03 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200603201434.15258@domain.hid>
	<200603210148.11118.berlemont.hauw@domain.hid> <441F5F31.70206@domain.hid>
	<200603220224.48468.berlemont.hauw@domain.hid>
In-Reply-To: <200603220224.48468.berlemont.hauw@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig27600BD85CB3B19AF8E6AC5B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: COMEDI over RTDM
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
--------------enig27600BD85CB3B19AF8E6AC5B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Alexis Berlemont wrote:
> Hi,
>=20
>>> But there are plenty of things I am not happy with :
>>> -> the original comedilib version is not really well suited for rtdm.=
 In
>>> this library for many reasons; for example, you can find calls to
>>> malloc/free
>> Oops, not so nice.
>>
>>> functions. If I stick to the original implementation, I have to eithe=
r to
>>> ask for adding alloc stuff in user mode in rtdm skin or use another s=
kin
>>> to manage allocations. None of these solutions seems interesting for =
me
>>> for many reasons. A lot of people  must be thinking I am overkill, it=
 is
>>> true that the comedilib allocations should be done at init time
>>> (comedi_open, comedi_close) then no need to fulfull real-time constra=
ints
>>> but I think comedi should be fully rtdm compliant; this would avoid
>>> tricky corner cases for
>>> developpers/users. The best and simplest solution for me would be som=
e
>>> slight modifications in the comedilib API but I doubt everyone is OK =
with
>>> that.
>> Could you give some concrete use cases of the comedilib where dynamic
>> allocation is involved? I don't know that library actually. What does =
it
>> manage beyond calling the driver core?
>=20
> In the function comedi_open() :=20
>=20
>   if(!(it=3Dmalloc(sizeof(comedi_t))))
>     goto cleanup;
>   memset(it,0,sizeof(comedi_t));
>=20
>   if((it->fd=3Drt_dev_open(fn,0))<0)
>   {
>     fprintf(stderr, "comedi_open: rt_dev_open failed (ret=3D%d)\n",
> 	    it->fd);
>     goto cleanup;
>   }
>=20
>   if(comedi_ioctl(it->fd, COMEDI_DEVINFO,=20
> 		  (unsigned long)&it->devinfo)<0)
>     goto cleanup;
>=20
>   it->n_subdevices=3Dit->devinfo.n_subdevs;
>=20
>   get_subdevices(it);
>=20
> ...
>=20
> We can see an allocation for a structure which will contain the result =
("fd")=20
> of rt_dev_open(). And this is not over, the function "get_subdevices()"=
 will=20
> make another allocation to keep info about the driver (subdevice, numbe=
r of=20
> channels, etc.). And this function "get_subdevices()" will trigger more=
=20
> allocations by calling "get_rangeinfo()". In fact, "malloc()" is called=
 eight=20
> times.
>=20
> All disallocations are done in "comedi_close()".

Ok, then opening and closing comedi devices is not deterministic and
must not happen when strict timing requirements exist - but that's a
rather unlikely scenario anyway. As long as there is no
allocation/release in the acquisition code path...

>=20
> Starting from here, we have two alternatives:
> -> preallocate enough structs the first time "comedi_open()" is called.=
 mmh...
> -> modify the comedilib API to let the developper handle the allocation=
s.
>=20
>>> -> I think the comedi structures organization (comedi_device, subdevi=
ce,
>>> async, etc.) should be reviewed considering the rtdm architecture. Of=

>>> course, these modifications should not induce big changes in the come=
di
>>> drivers source.
>> Please also give concrete examples here. RTDM devices should be
>> manageable by the user via file descriptors, just like normal devices.=

>=20
> There is a little difference with normal devices and classical drivers.=
 The=20
> link between a device and a driver is not direct. The comedi layer affe=
cts a=20
> comedi device (/dev/comedi0..9 or comedi0..9) to a specific driver at r=
untime=20
> thanks to a specific ioctl (cf. comedi_config in comedilib). This is th=
e=20
> comedi attach stuff.

Then what does comedi0..9 stand for, some interface channel?

>=20
> At this level, I may think it would be interesting to consider quite pr=
ecisely=20
> the layer organization. I have not well understood the architectural bo=
rder=20
> between what must be done by the driver and what must be done by the ab=
stract=20
> layer.
>=20
> For example, here is a description of the attaching procedure:=20
> 1) the devconfig ioctl is received by the abstract comedi layer;
> 2) the abstract layer (in comedi/drivers.c) calls do_devconfig_ioctl() =
which=20
> makes some allocations and a few setups in the structure comedi_device,=
 the=20
> the function comedi_device_attach() is called;
> 3)In comedi_device_attach(), we check if the proper driver whether avai=
lable=20
> (insmoded), if so a driver specific function is called;
> 4) in this driver function, we have access to the structures of the abs=
tract=20
> layer and we modify them (comedi_subdevice);
> 5) back in the abstract layer, the function "postconfig() is called to =
setup=20
> the struct "comedi_async" (this struct belongs to a comedi_subdevice).
>=20
> To sum up:=20
> -> comedi_device { (managed by the abstract layer)
> 	-> comedi_subdevice { (managed by the driver)
> 		-> comedi_async (managed by the abstract layer)
> 	}
> }
>=20
> I am not sure I am clear (it is quite hard to explain without source co=
de),=20
> but I think the drivers should not get direct access to the structures =
of the=20
> abstract layer.=20
>=20
> You may find this points useless, all this stuff is not directly relate=
d with=20
> rtdm functionnalities, I just thought the rtdm port would be a good=20
> opportunity to think about that.=20

Yes, certainly. And as it's not related to real-time or RTDM, this
should definitely raise the interest of the comedi developers as well. I
can only recommend torturing them with questions about why things are
the way they are!

>=20
>> What is different, what extra information is needed?
>=20
> . I just think some fields could be removed or grouped in comedi_subdev=
ice=20
> (lock, busy, etc.) and we could integrate in comedi_async the nonblocki=
ng=20
> info. This is minor.
>=20
> I may have some more points to share with you but I have to keep them f=
or=20
> tomorrow night.
>=20
>> Release early, release often ;). I would offer to have a look, maybe i=
t
>> will clarify where the RTDM-specific problems are.
>=20
> OK sorry for tonight, hard day...
>=20
> Alexis.
>=20

Jan


--------------enig27600BD85CB3B19AF8E6AC5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEJCzXniDOoMHTA+kRArGVAJ9H0k01M2tk+VXzJYYbXg/s5dT/9QCeKD9m
MnQkj4Tqv8SJEDK8CAwpQd4=
=nj3u
-----END PGP SIGNATURE-----

--------------enig27600BD85CB3B19AF8E6AC5B--

