Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45349113.2010700@domain.hid>
References: <1161013724.5503.65.camel@domain.hid>
	<1161034219.5131.81.camel@domain.hid>  <45349113.2010700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 17 Oct 2006 12:04:34 +0200
Message-Id: <1161079474.5154.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, 2006-10-17 at 10:15 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2006-10-16 at 17:48 +0200, Schl=E4gl Manfred jun. wrote:
> >>3. in-kernel periodic task & in-kernel timer benchmark=20
> >>
> >>-sh-3.00# ./latency -t 2 -T 10
> >>=3D=3D Sampling period: 100 us
> >>=3D=3D Test mode: in-kernel timer handler
> >>=3D=3D All results in microseconds
> >>latency: failed to start in-kernel timer benchmark, code -25
> >=20
> >=20
> > Eh? That's weird. The fact that the RTDM benchmark device could be
> > opened, but that a wrong ioctl code seemed to flow to it might be the
> > sign of the worm, somewhere in the Adeos syscall propagation path. Bt=
w,
> > are the RTDM-based benchmark drivers compiled statically into the
> > kernel?
>=20
> All benchmark drivers (timerbench, switchtest and irqbench) use the
> /dev/rttest%d devices, the device index is passed to latency
> and irqbench using the -D option whereas switchtest uses the ioctl erro=
r
> to find the correct device. So this error might simply be the sign that
> Manfred did not pass the -D option to latency.

AFAICS, the failed operation did not happen on an attempt to open the
device, but later when submitting an ioctl() request to it, in order to
start the sampling. So this can't be a simple device index issue. IOW,
the rttestX device is available and ready to use; the problem lies
beyond that point.

--=20
Philippe.



