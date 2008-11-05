Message-ID: <49119FE3.9050701@domain.hid>
Date: Wed, 05 Nov 2008 14:30:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49119A02.9020407@domain.hid>
In-Reply-To: <49119A02.9020407@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
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
To: =?ISO-8859-1?Q?C=E9dric_Schaffter?= <cedric.schaffter@domain.hid>
Cc: xenomai@xenomai.org

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
> When I observe the file intr.h, I see there are two rt_intr_create (the=20
> one with six arguments which I need and an other one with only four).
>=20
> I tried to specifiy four parameters as requested by the other=20
> *rt_intr_create* and it works, so I don't think there is a problem with=20
> my include paths.
>=20
> Does someone already have these issues or can help me?
>=20
> In this file there is an other instruction that I don't understand :
> "#if (defined(__KERNEL__) || defined(__XENO_SIM__)) && !defined(DOXYGEN_C=
PP)

__KERNEL__ is defined when compiling a kernel-space module;
__XENO_SIM__ is defined when compiling for xenomai simulator (which is
probably not your case);
DOXYGEN_CPP is defined when generating Xenomai documentation with doxygen.

--=20
                                                 Gilles.

