From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Message-ID: <17749.44672.200334.645300@domain.hid>
Date: Sat, 11 Nov 2006 12:05:36 +0100
Subject: Re: [Xenomai-help] timer-handling adeos/xenomai on arm
In-Reply-To: <1162810995.5144.20.camel@domain.hid>
References: <1162810995.5144.20.camel@domain.hid>
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "=?ISO-8859-1?Q?Schl=E4gl?= Manfred jun." <manfred.schlaegl@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Schl=E4gl "Manfred jun." wrote:
 > Hi again!
 >=20
 > I've the presumption, there is something wrong with my timer-handling.
 > Could you please take a look at my handling.
 >=20
 > Thanks in advance!

The problem I see with your code is that you are updating
ns_timer_lxlost in __ipipe_mach_acktimer, the integrator architecture
code, which also uses a decrementer does not do that. Apart from that, I
see nothing wrong.

If there is a problem with using ipipe_trigger_irq on your architecture,
maybe we could let rthal_timer_program_shot pass null delays to
__ipipe_mach_set_dec.

--=20


					    Gilles Chanteperdrix.

