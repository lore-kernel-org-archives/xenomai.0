Message-ID: <48F4A00B.5000001@domain.hid>
Date: Tue, 14 Oct 2008 15:35:07 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2A01530E9F@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2A01530E9F@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: roderik.wildenburg@domain.hid
Cc: xenomai@xenomai.org

roderik.wildenburg@domain.hid wrote:
> I=B4ve built a library which includes Xenomai posix functions.
> If a "customer" wants to use this library (links the library to his
> project) he unfortunately has to define all the wrappers for the
> posix functions I used within the library. Is this a general
> limitation when using posix in a library or do I simply not know how
> to build a proper Xenomai-library. Is there a posibility to avoid the
> wrapers so the user simply has to link the library and needn=B4t to
> define anyhing else (just -lxenolib) ?
>=20
> Thank you in advance for your help Roderik

It is a limitation that comes from using ld --wrap option.
Unfortunately, we really have no other mean to achieve compliance with
the posix interface, especially since Xenomai posix library needs
symbols from the libc libpthread library.

In a near future, it will be possible to directly call xenomai posix
library services without using the --wrap trick. Only, you will have to
prefix them or postfix them. Actually, you can already do that by
calling directly __wrap_service instead of service.

Another way to solve your issue is to ship your library with a shell
script much like xeno-config which generates the correct flags. You can
probably do what we have not done for xenomai: use the pkg-config
package. This approach is used for many libraries nowadays.

--=20
                                                 Gilles.

