Message-ID: <4CB4103E.80009@domain.hid>
Date: Tue, 12 Oct 2010 09:37:34 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <AANLkTi=6d4sZN11G0TfDXZPfwS8dDkhgE=LjnGcS4AG1@domain.hid>	<1286611432.13186.200.camel@domain.hid>	<AANLkTinfQTmC=165zLerDF1JsYnS-XHaUtWrMuOGmN4D@mail.gmail.com>	<AANLkTi=uCSYFazTzxLQWBhJgkmcoeJbLkd4Wv-O=tzb=@mail.gmail.com>	<4CB2B98A.8010605@domain.hid>	<AANLkTinrw0yUPApypmaN4L+Auv4WtE+BRJr-wkDjiAE-@domain.hid>	<4CB36116.8090507@domain.hid>	<4CB367AA.6020403@domain.hid>	<AANLkTimpY=60yJbWBwnu7KWZMst5ajFvrRoFzVx092oN@mail.gmail.com>
	<AANLkTimTRK9RG6md3vVoohx7KFw2uwczZGGaXvajnPxq@domain.hid>
In-Reply-To: <AANLkTimTRK9RG6md3vVoohx7KFw2uwczZGGaXvajnPxq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
Cc: xenomai@xenomai.org

On 10/12/2010 02:09 AM, Peter Pastor wrote:
> Hey Wolfgang,
> 
> I am compiling the rtcan code as modules. Also, for debugging purposes, I
> moved the xeno_can.ko and friends out of the /lib/modules directory and
> successfully booted into xenomai. Once xenomai booted up correctly, I insmod
> the modules by hand, first xeno_can.ko, then xeno_can_sja1000.ko and then
> the xeno_can_peak_pci.ko. The first two modules do not cause any trouble.
> However, the last one causes the system to freeze (after a short delay).
> 
> The ERROR message is
> ERROR -16: IRQ is busy, check shared interrupt support !
> ERROR -16 while trying to register SJA1000 device.
> 
> It turns out that I haven't had the shared interrupt support turned on !!

Ah, now I remember. But it's not the reason for your problems, I think.
Interrupts are *not* requested when you install the driver but later,
when a device is opened (when you call rtcanconfig).

> However, after enabling shared inturrupts (in the real-time subsystem
> category) and recompiling and rebooting... the error message disappears but
> the system still freezes after a certain while. I cannot really grep what
> comes out of the dmesg and also, it seems that each time I load this final
> kernel module it spits out slightly different things.
> 
> Initially it seems that everything is fine. It registers rtcan0 and rtcan1
> on IRQ 16
> 
> I do not quit understand why it is assigned to 16 though and not 11.

Magic, indeed. Looks like the proper irq number was not written to the
corresponding interrupt PCI configuration register. I assume 16 is
correct, otherwise the PCI layer would be broken badly. Do the Xenomai
tests, e.g. latency or cyclictest, work properly without RTCAN?

Wolfgang.

