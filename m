Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 Aug 2008 17:48:00 +0200
Message-ID: <0B45E93C5FF65740AEAE690BF3848B7AD38352@domain.hid>
From: "Fillod Stephane" <stephane.fillod@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] Fix stat overruns on 64-bit (was:
	[Xenomai-help] Kernel panic: not syncing)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
>/proc/xenomai/stat output is strange. Probably some type cast error,=20
> because 18446744071739514846 =3D 0xFFFFFFFF8A939FDE and the =
appropriate=20
> value perhaps should be 0x000000008A939FDE =3D 2324930526.
[...]

Reminds me that other pending patch for /proc/xenomai/faults:
https://mail.gna.org/public/xenomai-core/2007-12/msg00064.html

--=20
Stephane

