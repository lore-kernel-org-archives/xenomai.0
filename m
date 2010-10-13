Message-ID: <4CB54F93.4000102@domain.hid>
Date: Wed, 13 Oct 2010 08:20:03 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>	<1286611432.13186.200.camel@domain.hid>	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>	<4CB2B98A.8010605@domain.hid>	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>	<4CB36116.8090507@domain.hid>	<4CB367AA.6020403@domain.hid>	<AANLkTimpY=60yJbWBwnu7KWZMst5ajFvrRoFzVx092oN@mail.gmail.com>	<AANLkTimTRK9RG6md3vVoohx7KFw2uwczZGGaXvajnPxq@domain.hid>	<4CB4103E.80009@domain.hid>	<AANLkTikwqboZGsSC99yMOQZTm48QoT8C6j+RPi3Wcs=k@domain.hid>	<4CB49A14.3050400@domain.hid>
	<AANLkTik2jiYm58JQkqv_f9E6KTZiyUb4B+kP27xezP2G@mail.gmail.com>
In-Reply-To: <AANLkTik2jiYm58JQkqv_f9E6KTZiyUb4B+kP27xezP2G@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai and PEAK can bus card problem
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Peter Pastor <peter.pastor@domain.hid>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@domain.hid>

Peter Pastor wrote:
> Hey Jan, Wolfgang, Gilles,
> 
> After actually trying to reroute the interrupt by cutting and jumping
> the pins on the PCI card we figured that there was actually a 64bit PCI
> slot free. Also, according to wikipedia...  "PCI-X 1.0b and PCI-X 2.0
> are backward compatible with some PCI standards." Thus, we simply stuck
> the card in that slot and got assigned an interrupt that is not shared
> by other devices. Well, after rerouting things back to the initial
> configuration on the card, we were able to load the rtcan modules and
> communicate on the CAN bus !!
> 
> THANKS again for all the help and please let me know if you want me to
> run some tests. We are running xenomai 2.6.31 with xenomai 2.5.5.1 and
> thelinux_2.6.31-14.48.diff.gz ubuntu patch and the
> adeos-ipipe-2.6.31.8-x86-2.4-09.patch on a 64bit dell precision
> workstation T7500.
> 
> The only problem remaining is the fact that we get latency problems the
> moment we start an opengl window but as mentioned in another thread,
> there is nothing Xenomai can do about. Also, the MSI workaround is
> enabled but fails. I hope that this does not cause problems for our
> purposes of using Xenomai.

Hi Peter,

good news. Moving the card in the slot was what I was among the things I
was thinking about when I suggested you to look at the FAQ. So,
apparently, I was not precise enough. The same goes for the X issue,
when I told you to look at the TROUBLESHOOTING guide, the
TROUBLESHOOTING guide suggests to use "NoAccel" in the X server
configuration. Did you try that?

Regards.

-- 
                                                                Gilles.

