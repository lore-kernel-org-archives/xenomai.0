Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Feb 2009 07:00:31 +0100
Message-ID: <4B2EEE69E41E524EB7FCDC62A15D68D80308F237@domain.hid>
In-Reply-To: <49958653.2010803@domain.hid>
References: <4B2EEE69E41E524EB7FCDC62A15D68D80308F137@domain.hid>
	<49958653.2010803@domain.hid>
From: <thomas.debes@domain.hid>
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
Cc: xenomai@xenomai.org

Sorry, no exception is fired.

Thomas

-----Urspr=FCngliche Nachricht-----
Von: Philippe Gerum [mailto:rpm@xenomai.org
Gesendet: Freitag, 13. Februar 2009 15:40
An: Debes, Thomas RAEK3 MRA
Cc: xenomai@xenomai.org
Betreff: Re: [Xenomai-help] Floating Point Exceptions in RT-Tasks

thomas.debes@domain.hid wrote:
> Hi,
>=20
> I successfully managed to enable FP Exceptions on our MPC5200 board =
for
> plain linux applications (via fesetenv). When I put the same trigger
> code (DivByZero) into a (native) RT task no exception is triggered =
until
> I force a mode switch to secondary mode (e.g. printf). How can I get
> them without performing the mode switch?
>=20

Could you check whether the following test does raise an exception on =
your
setup? TIA,

#include <sys/types.h>
#include <sys/mman.h>
#include <stdio.h>
#include <fenv.h>
#include <native/task.h>

double z;

int main (int argc, char **argv)
{
	double a =3D 23.0;

	z =3D 0;
	fesetenv(FE_ENABLED_ENV);

        mlockall(MCL_CURRENT | MCL_FUTURE);

	rt_task_shadow(NULL, "main", 10, 0);
	a /=3D z;
	rt_task_suspend(NULL);

	return (int)a;
}

> Thanks for your help!
> Thomas
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>=20


--=20
Philippe.

--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

