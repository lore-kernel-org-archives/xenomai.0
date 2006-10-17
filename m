Message-ID: <45349113.2010700@domain.hid>
Date: Tue, 17 Oct 2006 10:15:15 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161013724.5503.65.camel@domain.hid>
	<1161034219.5131.81.camel@domain.hid>
In-Reply-To: <1161034219.5131.81.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Mon, 2006-10-16 at 17:48 +0200, Schl=E4gl Manfred jun. wrote:
>>3. in-kernel periodic task & in-kernel timer benchmark=20
>>
>>-sh-3.00# ./latency -t 2 -T 10
>>=3D=3D Sampling period: 100 us
>>=3D=3D Test mode: in-kernel timer handler
>>=3D=3D All results in microseconds
>>latency: failed to start in-kernel timer benchmark, code -25
>=20
>=20
> Eh? That's weird. The fact that the RTDM benchmark device could be
> opened, but that a wrong ioctl code seemed to flow to it might be the
> sign of the worm, somewhere in the Adeos syscall propagation path. Btw,
> are the RTDM-based benchmark drivers compiled statically into the
> kernel?

All benchmark drivers (timerbench, switchtest and irqbench) use the
/dev/rttest%d devices, the device index is passed to latency
and irqbench using the -D option whereas switchtest uses the ioctl error
to find the correct device. So this error might simply be the sign that
Manfred did not pass the -D option to latency.

--=20
                                                  Gilles Chanteperdrix

