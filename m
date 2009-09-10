From: Jonathan Haws <Jonathan.Haws@domain.hid>
Date: Thu, 10 Sep 2009 14:54:28 -0600
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F03248BDC03@domain.hid>
References: <BB99A6BA28709744BF22A68E6D7EB51F03248BDB59@domain.hid>
	<4AA95F97.6010802@domain.hid>
	<BB99A6BA28709744BF22A68E6D7EB51F03248BDBCD@midas.usurf.usu.edu>
	<4AA96689.3010502@domain.hid>
In-Reply-To: <4AA96689.3010502@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Installation and Makefile Help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

> >> Use DESTDIR, that is what it was made for. The makefiles use it
> >> when running "make install", and xeno-config prepends it to the
> >> directories it returns.
> >>
> >> So, in a makefile, you woud do:
> >>
> >> XENO_DESTDIR:=3D~/eldk/ppc_4xx
> >> XENO_CONFIG:=3D$(XENO_DESTDIR)/usr/local/xenomai/bin/xeno-config
> >> XENO_CPPFLAGS:=3D$(shell DESTDIR=3D$(XENO_DESTDIR) $(XENO_CONFIG) --
> >> xeno-cflags) XENO_LIBS:=3D$(shell DESTDIR=3D$(XENO_DESTDIR)
> >> $(XENO_CONFIG) --xeno- ldflags)
> >
> > Ah, that makes sense.  Thanks, Gilles.
> >
> >
> >> Note that to ease working in a cross-compile embedded
> environnement
> >>  you may want to avoid copying header files, documentation,
> etc...
> >> in the directory that will be used to generate the root
> filesystem.
> >> In this case pass a different --prefix and --exec-prefix options
> to
> >>  xenomai configure script.
> >
> > So, in that case I would do something like the following:
> >
> > ./configure --exec-prefix=3D~/eldk/ppc_4xx/usr/local/xenomai \
> > --prefix=3D/usr/local/xenomai --host=3Dppc-linux
> >
> > That would put headers, documentation, and other development files
> in
> > a usable location on the host and the libraries and executables in
> > ~/eldk/ppc_4xx.
>=20
> Well no, unfortunately not. To get things working properly, you have
> to
> pass ~/eldk/ppc_4xx as the DESTDIR when running "make install". At
> least
> that is the way the makefiles coming from automake are supposed to
> be
> used.
>=20
> So, what you would do is rather:
> ./configure --exec-prefix=3D/usr/local/xenomai --prefix=3D/xenomai-host
> --host=3Dppc-linux
>=20
> And then in the script generating the rootfs, prune the
> ~/eldk/ppc_4xx/xenomai-host directory.

Ah, yes.  I can see that now that I tried exactly what I just mentioned.  T=
his make sense.

Thanks.

Jonathan


