Message-ID: <49119F82.7080108@domain.hid>
Date: Wed, 05 Nov 2008 14:28:34 +0100
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
References: <49119A02.9020407@domain.hid>
In-Reply-To: <49119A02.9020407@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_intr_create issues
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?C=E9dric_Schaffter?= <cedric.schaffter@domain.hid>, xenomai-help <xenomai@xenomai.org>

C=E9dric Schaffter wrote:
> Hi List!
>=20
> I'm writing a programm where I need to use interruptions.
>=20
> To create it, I use the function "rt_intr_create(RT_INTR *intr, const=20
> char *name, unsigned irq, rt_isr_t isr, rt_iack_t iack, int mode)".
>=20
> I included this header : #include <native/intr.h>.
>=20
> When I compile, I get these error messages :
>=20
> *error 'RT_INTR_HANDLED' undeclared
> error too many arguments to function 'rt_intr_create'.*
>=20
> When I observe the file intr.h, I see there are two rt_intr_create (the=
=20
> one with six arguments which I need and an other one with only four).

The one with six parameters is for kernel apps, the other one with four
parameters for userland which is probably the right one for you. Please s=
ee
http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__inte=
rrupt.html

--=20
Sebastian


