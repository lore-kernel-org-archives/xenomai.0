Message-ID: <4916A7F4.501@domain.hid>
Date: Sun, 09 Nov 2008 10:05:56 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20081108211807.EF75F47808F@ws1-5.us4.outblaze.com>
In-Reply-To: <20081108211807.EF75F47808F@ws1-5.us4.outblaze.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Weird return after make instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Marco_Ant=F4nio_Possamai?= <marco.possamai@domain.hid>
Cc: Xenomai help <Xenomai-help@domain.hid>

Marco Ant=F4nio Possamai wrote:
> make[1]: Nada a ser feito para `all-am'.
> make[1]: Saindo do diret=F3rio `/home/user/xenomai-2.4.x'
>=20
> And I'm not sure of what to make of it.
> There's no error message, but those stuff don't seem right.

Why is that ? Kernel-space and user-space configurations are distinct,
so, when you change an option in kernel configuration, there is no need
to recompile user-space support.

--=20
					    Gilles.

