Message-ID: <4B770554.3080809@domain.hid>
Date: Sat, 13 Feb 2010 21:02:28 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8b216e9e1002100327h3aa332ddl13ec590fcb81f0b7@domain.hid>
	<8b216e9e1002111053gf6b4b2mf605e8c3b9f1c235@domain.hid>
	<4B745CAB.5000404@domain.hid>	<8b216e9e1002111215h1c1dac81w1a1ca1d19a37378c@domain.hid>
	<4B746FFE.20204@domain.hid>	<8b216e9e1002111430h5687cb9udfad3e08da08d83a@domain.hid>
	<4B750157.6080000@domain.hid>	<8b216e9e1002121023qa0f4d6n33c773110cfc78fd@domain.hid>
	<4B759DF9.9040800@domain.hid> <4B759F35.3050704@domain.hid>
	<8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid>
In-Reply-To: <8b216e9e1002131157k6f1a7ccbiba5e67b8855c77b2@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Problems when cross-compiling Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?RmVsaXBlIEJyYW5kw6NvIENhdmFsY2FudGk=?= <cavalkaf@domain.hid>
Cc: xenomai@xenomai.org

Felipe Brand=C3=A3o Cavalcanti wrote:
> OK - I did apply the patch to 2.6.30.10, with some very minor modificat=
ions
> in the sound system and in the headers (MACH_TYPE_IGEP0020 wasn't defin=
ed).
> I also applied the latest Adeos Ipipe patch.
>=20
> However, the compiled kernel doesn't boot - it actually just sits there=
,
> doing nothing:
>=20
> Bytes transferred =3D 2555616 (26fee0 hex)
> ## Booting kernel from Legacy Image at 80000000 ...
>    Image Name:   Linux-2.6.30.10
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    2555552 Bytes =3D  2.4 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>=20
> Starting kernel ...
>=20
> Uncompressing
> Linux..................................................................=
=2E......................................................................=
=2E........................
> done, booting the kernel.
>=20
> My guess is that Linux is simply not sending anything through my serial=

> (i.e., debug) port. Should I attempt to port over the serial driver, or=
 is
> this something else?
> I am also downloading kernel 2.6.32 to see if I can make it boot on my =
IGEP.

Do you pass the proper "console=3D" argument to the kernel? Is the suppor=
t
for serial driver enabled in the kernel?

If yes, then apply trick #1 from the "Tips and tricks" section in the
"porting I-pipe to a new board" HOWTO on Xenomai website.


--=20
					    Gilles.


