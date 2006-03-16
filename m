Content-class: urn:content-classes:message
Subject: RE: [Xenomai-help] xenoami task pids
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Mar 2006 08:47:33 -0500
Message-ID: <067C9A1F6AFEB643895EA4513E116884178FC1@domain.hid>
From: "Moser, Dan" <DMoser@domain.hid>
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

> Looks like one box uses an old glibc with LinuxThreads=20
> support (multiple pids are visible from the application, one=20
> for each created thread including the main one), and the=20
> other one a more recent NPTL-based pthread support (getpid()=20
> returns a single "main" pid per process, although the NTPL=20
> still enforces a 1:1 mapping between user-space and kernel=20
> threads that support them). This is not a Xenomai issue in=20
> fact, but rather a glibc one, given that Xenomai relies on=20
> the glibc to create user-space threads before promoting them=20
> to the real-time domain it controls.
>=20
> Reading this may help:
> http://publib.boulder.ibm.com/infocenter/wasinfo/v5r1//index.j
> sp?topic=3D/com.ibm.websphere.base.doc/info/aes/ae/cins_nptl.html
>=20
> Philippe.
>

Philippe,

What you described above is exactly what my issue was.

Also, the article link you provided was a great help.

Thanks VERY MUCH!

Dan

