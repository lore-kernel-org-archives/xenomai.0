Message-ID: <499DD671.3000103@domain.hid>
Date: Thu, 19 Feb 2009 23:00:17 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20090219191556.C00FBBE407B@ws1-9.us4.outblaze.com>
In-Reply-To: <20090219191556.C00FBBE407B@ws1-9.us4.outblaze.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] building image error
	regarding	xenomai/can/mscan/rtcan_mscan.o
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
Cc: XENOMAI <Xenomai-help@domain.hid>

Marco Ant=F4nio Possamai wrote:
> Greetings, all.
>=20
> I'm working on building a kernel image for the mpc5200b board with
> Xenomai and CAN settings. I wish to generate a cuImage.lite5200b.
>=20
> Got the xenomai-2.4.3 and the linux-2.6.24. Patched it with
> adeos-ipipe-2.6.24-powerpc-DENX-2.1-04.patch.

When starting a new development, there is no reason not to pick the
latest release i.e. xenomai-2.4.6.1. As for why the compilation fails, I
bet it is because the I-pipe patches are made for DENX tree, not the
vanilla kernel.

--=20
					    Gilles.


