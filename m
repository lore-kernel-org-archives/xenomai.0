Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 6 Mar 2009 13:06:29 +0100
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A0187317D@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <49B0FE9A.9040809@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks
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
Cc: xenomai@xenomai.org, wg@domain.hid

> Unfortunately, I'm not able to reproduce this bug on my side,=20
> even using the=20
> latest linuxppc_devel tree. I have attached my test code to=20
> make sure we are=20
> testing the same thing. This test code does raise the FPU=20
> exception properly.

This program produces a core here too (Xeno 2.4.6).
May I remember that Thomas got a core too, when he forced a switch to =
secondary mode.
Probably your task_suspend is something similar.


Thomas=B4 original post from 13.2.09
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I successfully managed to enable FP Exceptions on our MPC5200 board for
plain linux applications (via fesetenv). When I put the same trigger
code (DivByZero) into a (native) RT task no exception is triggered until
I force a mode switch to secondary mode (e.g. printf). How can I get
them without performing the mode switch?

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

