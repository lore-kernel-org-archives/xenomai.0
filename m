Message-ID: <4405A5A3.6020303@domain.hid>
Date: Wed, 01 Mar 2006 14:46:11 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: AW: AW: [Xenomai-core] vxworks-skin taskSpawn
References: <5D63919D95F87E4D9D34FF7748CE2C2A1C3EE6@domain.hid>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A1C3EE6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roderik_Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik_Wildenburg@domain.hid wrote:
> Philippe Gerum wrote :
>=20
>>I've run the satch example successfully on an Icecube board=20
>>here using -rc2.=20
>>What's the status of this issue on your side? Was it a timer=20
>>configuration issue as suspected by Gilles?
>>
>=20
>=20
> Status is unchanged. I still try to debugg satch with gdb/ddd and have =
been a little bit successfull with this.
  But I face more and more problems the deeper I dig into the system (e.g=
.=20
unresolved symbols when compiling vxWorks-examples
  with --debug enabled (see other thread)

This has been fixed in the repository:
http://mail.gna.org/public/xenomai-help/2006-02/msg00149.html

  or now, gdb moans about "cannot find bounds of current function" (do yo=
u have=20
any idea, what this means ?))
>=20

It means that GDB is confused actually; while stepping into some code, it=
 could=20
not locate the routine the current text address belongs too. This might h=
appen=20
when interrupting the program execution while it was running some code GD=
B has no=20
symbolic information about. Nothing to worry about, unless GDB would not =
find any=20
symbol at all.

> I don=B4t think it is a timer problem, as my timer is running in onesho=
t mode and not in
  continous mode what causes the problem on Gilles system. But I am not s=
hure.

Could you try running "strace" on your program? TIA,

>=20
> Nevertheless, thank you for asking !! If you have any other suggestions=
 what I can do, please let me know. I will inform you when the status cha=
nges on my side.
>=20
> Best Regards
> Roderik
>=20
>=20
>=20


--=20

Philippe.

