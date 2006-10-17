Message-ID: <45349671.2050500@domain.hid>
Date: Tue, 17 Oct 2006 10:38:09 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161013724.5503.65.camel@domain.hid>	<1161034219.5131.81.camel@domain.hid>
	<45349113.2010700@domain.hid>
In-Reply-To: <45349113.2010700@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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

Gilles Chanteperdrix wrote:
> All benchmark drivers (timerbench, switchtest and irqbench) use the
> /dev/rttest%d devices, the device index is passed to latency
> and irqbench using the -D option whereas switchtest uses the ioctl error
> to find the correct device. So this error might simply be the sign that
> Manfred did not pass the -D option to latency.

Or that Xenomai was compiled without the timerbench driver.

-- 
                                                  Gilles Chanteperdrix

