Message-ID: <4ACE365B.7020004@domain.hid>
Date: Thu, 08 Oct 2009 20:58:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <200910080126.13483.berlemont.hauw@domain.hid>
	<1255023424.2781.70.camel@domain.hid>
In-Reply-To: <1255023424.2781.70.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9B4A2C51242D04E5EA8DC5C4"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Some thoughts on Analogy "kernel side" framework
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9B4A2C51242D04E5EA8DC5C4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2009-10-08 at 01:26 +0200, Alexis Berlemont wrote:
>> Hi,
>>
>> The last week, I have been working on the global architecture of the a=
nalogy=20
>> project.
>>
>> I tried to sum-up the main characteristics of Comedi. That was a start=
 to=20
>> figure out what shape analogy will get.
>>
>> Here are some notes on that subject:
>>
>> 1) Comedi drivers are not common Linux drivers. In these drivers:
>> 	- there is neither fops structure nor ioctl operations
>> 	- there is, of course, no cdev registration
>> 	- The Linux API is sometimes wrapped into Comedi-specific functions (=
ex.=20
>> irq).
>>
>> 2) Comedi imposes a specific organization: devices are composed of sub=
devices=20
>> which are themselves composed of channels. Then a Comedi driver:
>> 	- declares a list of subdevices
>> 	- displays a list of callbacks per subdevices (command, instructions,=
=20
>> trigger, etc.).
>>
>> 3) The Comedi midlayer is the link between the Linux driver programmin=
g model=20
>> and the Comedi drivers:
>> 	- The Comedi core manages a set of pre-registered character devices
>> 	- Via a specific ioctl, the core assigns a dev file to some driver an=
d an=20
>> "attach" callback is called within the driver.
>> 	- The comedi core is in charge of routing the ioctls to the proper su=
bdevice=20
>> callbacks.
>>
>> According to me, this architecture brings some troubles:
>> 1) Not all the drivers perfectly fit into the midlayer:
>> 	- Some components of acquisition cards do not comply with the subdevi=
ce model=20
>> (ex. the mite in NI card).=20
>> 	- We find card specific declarations in the Comedi core layer (ex.: s=
ome NI=20
>> specific counter modes in comedi.h);
>> 2) On the user space side, it is difficult to write a card independant=
=20
>> application.
>>
>> All these points make me think that the idea of midlayer itself is not=
=20
>> suitable in our case. Because of the fact that the drivers do not fit =
well=20
>> into the generic programing model, we find ourselves adapting user spa=
ce=20
>> programs to the card they will use.
>>
>> I would rather propose a framework composed of helper modules. Analogy=
 drivers=20
>> would be quite similar with common RTDM drivers (they would contain fo=
ps=20
>> declarations, dev registrations, etc.);=20
>>
>> As a consequence, Analogy will be a set of tools:
>> 	- ioctl routing function
>> 	- acquisition device registration
>> 	- asynchronous buffer management modules
>> 	- etc.
>>
>=20
> This sounds like a plan, but this also raises a major concern: what's
> the status of your current code wrt the upcoming 2.5 now, given that yo=
u
> seem to imply that the current Comedi/RTDM tree does not exhibit the
> final architecture yet, and your proposal entails fundamental changes?
>=20
> It was made very clear during the recent XUM that 2.5 will be out this
> year, which leaves us with enough time to tackle the current issues, bu=
t
> likely not to reshuffle a complete framework.
>=20
> We could live with that framework only providing a single acquisition
> driver in 2.5.0, but the former has to be stable, and the ABI written i=
n
> stone for the 2.5.x series. Provisions for transparent multi-ABI suppor=
t
> might be acceptable, but this still requires to be confident about what=

> would be needed in the long run, and that sudden change in your
> architecture is worrisome.
>=20
> In short, assuming your current work description eventually holds,
> what's your timing to deliver?

Given that we did not deliver a stable version with comedi/analogy
support yet, what about declaring the whole thing "experimental" or
"unstable" (/wrt to its ABI) until the dust settled. That way any user
building some application on top if it would do this on his own risk.

Jan


--------------enig9B4A2C51242D04E5EA8DC5C4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkrONlsACgkQitSsb3rl5xSH/gCglzMnbCWof4FsMlWQaCVfnHiN
FfYAoMskhxqi2akOqzG4ClEeSoJ3m55T
=nTz0
-----END PGP SIGNATURE-----

--------------enig9B4A2C51242D04E5EA8DC5C4--

