Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Sep 2007 12:12:06 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB023D2124@domain.hid>
In-Reply-To: <46F777EE.3060100@domain.hid>
References: <46F777EE.3060100@domain.hid>
From: "Daniel Schnell" <daniel.schnell@domain.hid>
Subject: [Xenomai-core] RTCAN (MSCAN) doesn't compile on latest Denx 2.6.23
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I have cross compiled Xenomai latest trunk (Adeos-1.7) for the Denx
2.6.23 tree for a PowerPC5200 arch, and the only annoyance I can see is
that MSCAN driver for Xenomai is not compiling because of missing
defines/enums in asm-powerpc/mpc52xx.h in comparision to
asm-ppc/mpc52xx.h.

Looking at the included socket-can mscan driver, things seem to have
changed quite a bit since the socketcan has been ported to
RTCAN/Xenomai.

Wolfgang, Jan, is the MSCAN RT driver just needing the appropriate
defines inside asm-powerpc/mpc52xx.h or or does the driver itself need
changes ? How does the socketcan MSCAN driver come along without these ?


Best regards,

Daniel Schnell.=20


