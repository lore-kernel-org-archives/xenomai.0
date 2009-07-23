Message-ID: <4A689903.5010107@domain.hid>
Date: Thu, 23 Jul 2009 19:08:19 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <EB48F2CADC239E44A8598CC0B0571102E4A99D@XVS-DCFR-21.europe.corp.altran.com>
	<4A6829D6.9060301@domain.hid>
	<EB48F2CADC239E44A8598CC0B0571102E4A99E@XVS-DCFR-21.europe.corp.altran.com>
In-Reply-To: <EB48F2CADC239E44A8598CC0B0571102E4A99E@XVS-DCFR-21.europe.corp.altran.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] RE :  State of implementation of CAN,
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
> I'm on the first step of the project and I have to choose a complete
> system for my customer. I looking at the constraints both for hardware
> and software and the possibly dependency between them.

OK.

>> I'm asking for the current state of the CAN implementation. Is it a
>> partial or a
>> complete implementation of the CAN standard? What are the guarantee
>> about real
>> time latency?
>=20
> What exactly do you mean with CAN standard? RT-Socket-CAN allows
> low-level access the CAN controller to send and receive messages, handl=
e
> errors and set the bit-timing. Standard, extended and RTR frames are
> supported.
>=20
> Sorry, I've made a misunderstood about the CAN organization. In fact,
> the RT-Socket-CAN is a kind of user API for ease the use of CAN bus,
> isn't it? It seems that, generally, the handling of protocol, like the
> access to media or arbitration, is done in the chip.

Yep.

>> I've read in "RTDM and applications" that there would be an effort for
>> implementing a CANOpen profile. But, the implementation of CANOpen
>> protocol is
>> let to users? I can't find any newer reference for that in sources or
> in the
>> documentation of Xenomai. What is the state of this project?
>=20
> If you are looking for a free CANopen implementation, CANfestival might
> be an option, which also supports RT-Socket-CAN, IIRC. Check
> http://canfestival.org/ for further information.
>=20
> My client asks for a complete implementation of the CANOpen protocol. I
> will take all a look at this site and if it's clear for that use.

Usually, only a sub-set of the CANopen protocol is implemented.

Wolfgang

