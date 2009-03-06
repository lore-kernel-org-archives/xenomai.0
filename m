Message-ID: <49B13294.4010903@domain.hid>
Date: Fri, 06 Mar 2009 15:26:28 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A0187317D@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A0187317D@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org, wg@domain.hid

roderik.wildenburg@domain.hid wrote:
>> Unfortunately, I'm not able to reproduce this bug on my side,=20
>> even using the=20
>> latest linuxppc_devel tree. I have attached my test code to=20
>> make sure we are=20
>> testing the same thing. This test code does raise the FPU=20
>> exception properly.
>=20
> This program produces a core here too (Xeno 2.4.6).
> May I remember that Thomas got a core too, when he forced a switch to s=
econdary mode.
> Probably your task_suspend is something similar.
>=20

rt_task_suspend() is a conforming call; on behalf of a Xenomai task, it w=
ill
switch to (or remain in) _primary_ mode, this is precisely why this test =
is
using it. As a matter of fact, fetest.c does trigger the exception as wel=
l with
my setup, albeit it does not on yours, so the explanation must be elsewhe=
re.

>=20
> Thomas=B4 original post from 13.2.09
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I successfully managed to enable FP Exceptions on our MPC5200 board for
> plain linux applications (via fesetenv). When I put the same trigger
> code (DivByZero) into a (native) RT task no exception is triggered unti=
l
> I force a mode switch to secondary mode (e.g. printf). How can I get
> them without performing the mode switch?
>=20
> --------------------------------------------------------
> manroland AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Ral=
l, Paul Steidle  =20
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
> USt-Ident-Nr. DE 250200933
>=20



