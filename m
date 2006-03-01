Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: AW: AW: [Xenomai-core] vxworks-skin taskSpawn
Date: Wed, 1 Mar 2006 14:23:13 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A1C3EE6@domain.hid>
From: <Roderik_Wildenburg@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote :
>=20
> I've run the satch example successfully on an Icecube board=20
> here using -rc2.=20
> What's the status of this issue on your side? Was it a timer=20
> configuration issue as suspected by Gilles?
>=20

Status is unchanged. I still try to debugg satch with gdb/ddd and have =
been a little bit successfull with this. But I face more and more =
problems the deeper I dig into the system (e.g. unresolved symbols when =
compiling vxWorks-examples with --debug enabled (see other thread) or =
now, gdb moans about "cannot find bounds of current function" (do you =
have any idea, what this means ?))

I don=B4t think it is a timer problem, as my timer is running in oneshot =
mode and not in continous mode what causes the problem on Gilles system. =
But I am not shure.

Nevertheless, thank you for asking !! If you have any other suggestions =
what I can do, please let me know. I will inform you when the status =
changes on my side.

Best Regards
Roderik



