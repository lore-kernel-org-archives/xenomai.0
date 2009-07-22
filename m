Message-ID: <589194.96340.qm@domain.hid>
Date: Wed, 22 Jul 2009 02:04:13 -0700 (PDT)
From: Yigal Goldberger <yigal_gold@domain.hid>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD386A4@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai exceptions tracing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fillod Stephane <stephane.fillod@domain.hid>
Cc: xenomai@xenomai.org


Hi Stephane,
Thanks for your help, I used this tool (which is something I've been needin=
g for a long time) and I got the function name .
My architecture is powerpc (freescale 8272)
Does anyine know what this exception means on this platform ?
Best Regards,
Yigal.

--- On Wed, 7/22/09, Fillod Stephane <stephane.fillod@domain.hid> wrot=
e:

> From: Fillod Stephane <stephane.fillod@domain.hid>
> Subject: RE: [Xenomai-help] xenomai exceptions tracing
> To: "Yigal Goldberger" <yigal_gold@domain.hid>, xenomai@xenomai.org
> Date: Wednesday, July 22, 2009, 11:41 AM
> Yigal Goldberger wrote:
> [...]
> > <6>Xenomai: Switching 802Rdr to secondary mode
> after exception #769
> from user-space at 0x10017cec (pid 974)
>=20
> I don't know what exception #769 stands for on your arch,
> but have you=20
> looked already what code in your program triggers it? This
> command
> may help you, esp. when the program is compiled with debug
> info.
>=20
> =A0 ${CROSS_COMPILE}addr2line -f -e 802Rdr 0x10017cec
>=20
> HTH
> --=20
> Stephane
> =0A=0A=0A      

