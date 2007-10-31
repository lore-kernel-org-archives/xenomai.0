Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 Oct 2007 15:33:43 +0100
Message-ID: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172BA3F@esealmw118.eemea.ericsson.se>
In-Reply-To: <47285858.3030204@domain.hid>
References: <E5E9C6CC7DC8844A8DA7A9EFE7B5350E0172B790@domain.hid>
	<47285666.4080108@domain.hid> <47285858.3030204@domain.hid>
From: "Thomas Necker" <thomas.necker@domain.hid>
Subject: Re: [Xenomai-help] xntbase_get_jiffies in user space?
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

> >=20
> > The other option would be to extend this skin with a=20
> Xenomai-specific=20
> > syscall returning this value, in a similar way than=20
> tm_getm(), which=20
> > returns the TSC converted to nanoseconds.
> >=20
>=20
> Like the attached patch does.

Thanks for the quick patch. It seems necessary to change the call
ticks =3D xntbase_get_jiffies(&psos_tbase)
to
ticks =3D xntbase_get_jiffies(psos_tbase)
in syscall.c for the patch to work.
Will this change become part of the regular Xenomai release?

Thomas

