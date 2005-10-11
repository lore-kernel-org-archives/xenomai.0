content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] PATCH: fix ppc64 calibration
Date: Tue, 11 Oct 2005 16:36:25 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0E16@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Heikki Lindholm wrote:
> The old calibration value was from some ancient ppc32 embedded board,
I=20
> guess. This reflects the awesome power of them ppc64 boxen better :)

Actually, the ppc32 calibration value was from some ancient x86 machine,
I=20
guess. The same patch could be applied to asm-ppc/calibration.h. This=20
reflects the awesome power of them ppc32 boxen better :)

--=20
Stephane


