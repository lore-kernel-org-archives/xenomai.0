Message-ID: <4C0A8B94.7020207@domain.hid>
Date: Sat, 05 Jun 2010 19:38:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C037798.8070307@domain.hid>	<1275403262-23939-1-git-send-email-P.B.Cheblakov@domain.hid>
	<4C051D3F.2030407@domain.hid>
In-Reply-To: <4C051D3F.2030407@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] [PATCH V3] rtcan: add rtcan_plx_pci driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "P.B.Cheblakov" <P.B.Cheblakov@domain.hid>
Cc: xenomai@xenomai.org

P.B.Cheblakov wrote:
> I'v=D1=83 merged fixes from Wolfgang for Kconfig and for warnings in th=
is=20
> patch and tested it

Thanks, but it seems we still have a few build issues:
- the PCI IDs used by this patch are not available in old kernels
- the I-pipe patches no longer apply on some stable releases.

--=20
					    Gilles.


