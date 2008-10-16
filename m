Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Oct 2008 11:36:24 +0200
Message-ID: <5D63919D95F87E4D9D34FF7748CE2C2A0155D6F0@domain.hid>
In-Reply-To: <48F4A00B.5000001@domain.hid>
From: <roderik.wildenburg@domain.hid>
Subject: Re: [Xenomai-help] how to build a Xenomai posix library ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

> > I=B4ve built a library which includes Xenomai posix functions.
> > If a "customer" wants to use this library (links the library to his
> > project) he unfortunately has to define all the wrappers for the
> > posix functions I used within the library. Is this a general
> > limitation when using posix in a library or do I simply not know how
> > to build a proper Xenomai-library. Is there a posibility to=20
> avoid the
> > wrapers so the user simply has to link the library and needn=B4t to
> > define anyhing else (just -lxenolib) ?
> >=20
> > Thank you in advance for your help Roderik
>=20
> It is a limitation that comes from using ld --wrap option.
> Unfortunately, we really have no other mean to achieve compliance with
> the posix interface, especially since Xenomai posix library needs
> symbols from the libc libpthread library.
>=20
> In a near future, it will be possible to directly call xenomai posix
> library services without using the --wrap trick. Only, you=20
> will have to
> prefix them or postfix them. Actually, you can already do that by
> calling directly __wrap_service instead of service.

I did so and called, within the library, every posix_rt-function with =
the prefix __wrap_ :
e.g. __wrap_shm_open
then I compiled my application, which does not use any Xenomai-function, =
and linked it with pthread_rt an rt (-lpthread_rt -lrt) and my new =
Xenomai-library (linking without any wrapping defined). Linking and =
compiling did not produce any error.
But, when I call a function in my library, which in turn calls =
__wrap_shm_open, then shm_open fails.
When I link my application with wrapping (as provided by the =
XENO_CONFIG-script) then everything is fine. Do you have an explanation =
for this behavior or even better a solution ?

>=20
> Another way to solve your issue is to ship your library with a shell
> script much like xeno-config which generates the correct=20
> flags. You can
> probably do what we have not done for xenomai: use the pkg-config
> package. This approach is used for many libraries nowadays.
>

Achtung: Neue E-Mail-Adresse! Attention: New e-mail-address! =
roderik.wildenburg@domain.hid
--------------------------------------------------------
manroland AG
Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus =
Rall, Paul Steidle  =20
Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht =
Offenbach HRB-Nr. 42592
USt-Ident-Nr. DE 250200933

