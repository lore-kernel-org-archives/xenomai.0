MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18217.62663.728033.819886@domain.hid>
Date: Thu, 1 Nov 2007 16:46:15 +0100
In-Reply-To: <200711011004.lA1A40qV005239@domain.hid>
References: <18216.16434.853914.993008@domain.hid>
	<200711011004.lA1A40qV005239@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] RT, nonRT communication
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Patrick <kpa_info@domain.hid>
Cc: xenomai@xenomai.org

Patrick wrote:
> -----Message d'origine-----
> De=A0: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]=20
> Envoy=E9=A0: mercredi, 31. octobre 2007 09:44
> =C0=A0: ROSSIER Daniel
> Cc=A0: Patrick; xenomai@xenomai.org
> Objet=A0: RE: [Xenomai-help] RT, nonRT communication
>=20
> [...]
>=20
> > As soon as you compile your application with the flags returned by
> > xeno-config --posix-cflags and xeno-config --posix-ldflags, it really
> > becomes an RT application where all threads are real-time threads. The
> > only way to create a non real-time thread in such an application is by
> > calling __real_pthread_create.
>=20
> Do I have to use --posix-cflags and --posix-ldflags together with the
> --xeno-cflags and --xeno-ldflags or are they exclusive?
>=20

--posix-*flags is for compilation for the posix skin, --xeno-*flags is
for compilation for other skins. You can use them together if your
application uses the posix skin at the same time as another skin.

--=20


					    Gilles Chanteperdrix.

