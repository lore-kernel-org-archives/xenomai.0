Message-ID: <49B13443.5010203@domain.hid>
Date: Fri, 06 Mar 2009 15:33:39 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20090306142134.37AC11C079@domain.hid>
In-Reply-To: <20090306142134.37AC11C079@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai version 2.4.7 with linux kernel 2.6.28.7
 under ubuntu problem
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
To: stefano.franzoni@domain.hid
Cc: xenomai@xenomai.org

stefano.franzoni@domain.hid wrote:
> Dear
>=20
> I am trying to install Xenomai under Ubuntu 8.10:
>=20
> I have used linux kernel 2.6.28.7 and Xenomai 2.4.7.
>=20
> During the kernel compilation I have the following error
>=20
> arch/x86/kernel/ipipe.c: In function =E2=80=98__ipipe_divert_exception=E2=
=80=99:
> arch/x86/kernel/ipipe.c:710: error: =E2=80=98ex_device_not_available=E2=
=80=99 undeclared
> (first use in this function)
> arch/x86/kernel/ipipe.c:710: error: (Each undeclared identifier is repo=
rted
> only once
> arch/x86/kernel/ipipe.c:710: error: for each function it appears in.)
> make[1]: *** [arch/x86/kernel/ipipe.o] Error 1
> make: *** [arch/x86/kernel] Error 2
>=20
> I have seen that ex_device_not_available is missed but the kernel
> compilation terminates with no errors if I use ex_do_device_not_availab=
le
> instead of ex_device_not_available.

This fix is correct as well.

>=20
> Any suggestion?
>=20
> I link my .config file.
>=20
> Thanks in advance
>=20
> Stefano
>=20
> (See attached file: .config)
>=20
>=20
> -----------------------------------------------------------------------=
-
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


