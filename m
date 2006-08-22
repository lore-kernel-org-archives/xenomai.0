Message-ID: <44EAA684.3060506@domain.hid>
Date: Tue, 22 Aug 2006 08:39:00 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Socketcan-users] [Xenomai-help] Re: send error: permission	denied
References: <DD39B5C3F4963040ADC9768BE7E430CBFFAD9F@is-hdq-exchange.marel.net>	<44EA096D.9080208@domain.hid>
	<44EA0DB4.1080302@domain.hid> <44EA9D22.5090301@domain.hid>
In-Reply-To: <44EA9D22.5090301@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig153115313513E794C0972D84"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, socketcan-users@domain.hid, Daniel Schnell <danielsch@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig153115313513E794C0972D84
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Jan Kiszka wrote:
>> Wolfgang Grandegger wrote:
>>> Hi Daniel,
>>>
>>> Daniel Schnell wrote:
>>>> Hi,
>>>>
>>>> =20
>>>>
>>>> I am new to socket can.
>>>>
>>>> =20
>>>>
>>>> I wanted to test the rtcan driver in combination with Linux and
>>>> Xenomai and made a little program according to the rtcansend program=

>>>> but with some response time measurements.
>>>>
>>>> =20
>>>>
>>>> However after setting up the socket I get =E2=80=93EPERM when trying=
 to send a
>>>> packet to the can device. As the documentation doesn=E2=80=99t state=
 anything
>>>> about this error when calling rt_dev_send() I wonder why the error i=
f
>>>> at all doesn=E2=80=99t appear earlier if I try to setup the socket. =
The test
>>>> program already ran nicely when I tested the peak can drivers for
>>>> linux. I just changed the driver specific calls.
>>>>
>>>> =20
>>>>
>>>> Attached you find the complete test file, the function task() is the=

>>>> one to blame.
>>>>
>>>> =20
>>>>
>>>> I am a bit stuck with this, so maybe someone can give me a slight hi=
nt
>>>> in what i am doing wrong.
>>> I tried your program on my system and got the same error. The problem=

>>> is, that rt_dev_send() is called from non-RT context, which is illega=
l.
>>
>> ...but should not matter if the caller is a Xenomai thread in "Linux"
>> mode.
>>
>>> At a first glance, it's not obvious to me why. Therefore I added the
>>> Xenomai Help ML to the CCs.
>>
>> How did you all compile the program [1]? Using xeno-config
>> --posix-cflags / --posix-ldflags?
>=20
> No, ah, oh. It works using the above flags, indeed. I see, that it call=
s
> _rtdm_sendmsg in secondary execution mode (none-RT) first, which
> returned -ENOSYS (-38). Then I guess, the context is switch to primary
> mode and _rtdm_sendmsg is called again, correct?
>=20

Exactly, that's how it works.

>> Jan
>>
>>
>> PS: Daniel, if you go the POSIX way, you don't have to use rt_dev_, yo=
u
>> can use the normal POSIX API directly. That services will be wrapped o=
n
>> the Xenomai core just like pthread&friends.
>=20
> Cool. I was not yet aware of that.

Yes, and one should try to keep the sources clean (though mixing is
technically fine): either go native and pick real-time related services
from this API (would include task creation here) or go POSIX and use
only that API. If unsure about the status of some particular function,
see the docs or <xeno-installation>/lib/posix.wrappers for the list of
available bindings. (*)

>=20
>> [1]https://lists.berlios.de/pipermail/socketcan-users/attachments/2006=
0821/ff454f48/cantest_rt.obj
>>
>=20
> Thanks for clarifying things.
>=20
> Wolfgang.
>=20

Jan


(*) Native has the charm of being more explicit ("This is hard-RT, any
    other service not.") and sometimes more handy to use. POSIX is
    standard, thus far easier portable. And it may already be well known
    to the programmer.


--------------enig153115313513E794C0972D84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE6qaEniDOoMHTA+kRAvEYAJ4uhWlYE25a+MntKllpMJIr27eVVwCfZbgY
EvLvUclhSyA6+KLRGaE0rak=
=O5JC
-----END PGP SIGNATURE-----

--------------enig153115313513E794C0972D84--

