Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Dec 2007 15:13:49 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB028A9712@domain.hid>
In-Reply-To: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>
References: <2ff1a98a0712200643u797cfad2ve3848d88feda3bea@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: Re: [Xenomai-core] Auto closing of file descriptors and fork.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Hi,
>=20
> I have a problem with auto closing of file descriptors and fork. I
> have an application (a modified pppd, to name it), which in a certain
> mode (pppd "updetach" mode) opens some real-time file descriptors,
> forks and exit the parent, continuing to use the file descriptors in
> the child. The problem is that when exiting the parent, file
> descriptors are automatically destroyed and therefore can not be used
> in the child.     =20
>=20
> Any ideas for a fix ?

Maybe not exiting the child but saying waitpid() ?



Daniel Schnell.

