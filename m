Message-ID: <4534C6F0.2010500@domain.hid>
Date: Tue, 17 Oct 2006 14:05:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161013724.5503.65.camel@domain.hid>	
	<1161034219.5131.81.camel@domain.hid>
	<45349113.2010700@domain.hid> <1161079474.5154.8.camel@domain.hid>
In-Reply-To: <1161079474.5154.8.camel@domain.hid>
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
To: rpm@xenomai.org, xenomai@xenomai.org

Philippe Gerum wrote:
>>All benchmark drivers (timerbench, switchtest and irqbench) use the
>>/dev/rttest%d devices, the device index is passed to latency
>>and irqbench using the -D option whereas switchtest uses the ioctl error
>>to find the correct device. So this error might simply be the sign that
>>Manfred did not pass the -D option to latency.
> 
> 
> AFAICS, the failed operation did not happen on an attempt to open the
> device, but later when submitting an ioctl() request to it, in order to
> start the sampling. So this can't be a simple device index issue. IOW,
> the rttestX device is available and ready to use; the problem lies
> beyond that point.

When using the wrong /dev/rttest device, open would not fail but ioctl
would fail. But I agree, Manfred is facing a different issue.

-- 
                                                  Gilles Chanteperdrix

