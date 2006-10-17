Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45349671.2050500@domain.hid>
References: <1161013724.5503.65.camel@domain.hid>
	<1161034219.5131.81.camel@domain.hid> <45349113.2010700@domain.hid>
	<45349671.2050500@domain.hid>
Content-Type: text/plain
Date: Tue, 17 Oct 2006 11:54:27 +0200
Message-Id: <1161078867.5154.0.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Tue, 2006-10-17 at 10:38 +0200, Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
> > All benchmark drivers (timerbench, switchtest and irqbench) use the
> > /dev/rttest%d devices, the device index is passed to latency
> > and irqbench using the -D option whereas switchtest uses the ioctl error
> > to find the correct device. So this error might simply be the sign that
> > Manfred did not pass the -D option to latency.
> 
> Or that Xenomai was compiled without the timerbench driver.

No, you would get -ENODEV, with a failure on the opening of the device.

> 
-- 
Philippe.



