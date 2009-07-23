Message-ID: <4A6829D6.9060301@domain.hid>
Date: Thu, 23 Jul 2009 11:13:58 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A99D@XVS-DCFR-21.europe.corp.altran.com>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A99D@XVS-DCFR-21.europe.corp.altran.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] State of implementation of CAN,
	CANOpen in Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Berruer_S=E9bastien?= <sebastien.berruer@domain.hid>
Cc: xenomai@xenomai.org

Berruer S=E9bastien wrote:
> Hello,
>=20
> I'm reviewing the feasibility of a project that would require the drivi=
ng of
> devices with real time constrains.

OK, then RT-Socket-CAN is a good choice.

> I'm asking for the current state of the CAN implementation. Is it a
> partial or a
> complete implementation of the CAN standard? What are the guarantee
> about real
> time latency?

What exactly do you mean with CAN standard? RT-Socket-CAN allows
low-level access the CAN controller to send and receive messages, handle
errors and set the bit-timing. Standard, extended and RTR frames are
supported.

> I explored briefly the sources of Xenomai, and I read the file
> "ksrc/drivers/can/README". Is it up-to-date? Is there really only
> support for
> the controllers listed in it?

Mainly yes, what CAN controller would you like to use? Writing a
RT-Socket-CAN driver is usually not a big deal.

> I've read in "RTDM and applications" that there would be an effort for
> implementing a CANOpen profile. But, the implementation of CANOpen
> protocol is
> let to users? I can't find any newer reference for that in sources or i=
n the
> documentation of Xenomai. What is the state of this project?

If you are looking for a free CANopen implementation, CANfestival might
be an option, which also supports RT-Socket-CAN, IIRC. Check
http://canfestival.org/ for further information.

> I've seen that there is currently only one implementation of a RT drive=
r
> for the
> 16550A serial controller. Has anybody implemented it for other chip?

What chip/hardware do you have in mind?

> If I finally decide to choose a RT-Patch, instead of Xenomai, I will
> have the
> CAN implementation that will use the Linux networking stack. But I will
> not have
> any guarantee about its real time implementation, isn't it?

The Linux network stack is not hard real-time capable and the real-time
preemption patch will only help partially.

Wolfgang.

