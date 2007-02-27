Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Kernel-OOps
Date: Tue, 27 Feb 2007 13:53:00 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB01B536B3@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01B5368C@is-hdq-exchange.marel.net>
References: <DD39B5C3F4963040ADC9768BE7E430CB01B5368C@is-hdq-exchange.marel.net>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>, xenomai@xenomai.org


Daniel Schnell wrote:
> Hi,
>=20
> I have a bad Kernel-Ooops on my MPC5200B based PPC target.
> Unfortunately not reproducable with a small application again.
> I used a 2.4.25 based Denx Kernel (latest and greatest version) and
> Xenomai - trunk with revision 2256.
>=20


If I increase MAX_DELAYED_MM in linux/kernel/sched.c from 32 to 64 the
OOPS disappears ....

As we have quite a number of concurrent threads running (>50) could
MAX_DELAYED_MM be depending on the number of threads in the system ?



Best regards,

Daniel Schnell.

