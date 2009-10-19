Message-ID: <4ADC657A.2080609@domain.hid>
Date: Mon, 19 Oct 2009 15:11:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <b88603c30910190556u50fc55afnc5886b3fb15a2f3c@domain.hid>
In-Reply-To: <b88603c30910190556u50fc55afnc5886b3fb15a2f3c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai on Freescale i.MX25
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Henri Roosen <henriroosen@domain.hid>
Cc: xenomai@xenomai.org

Henri Roosen wrote:
> Hello,
> 
> I want to use Xenomai (2.4.9.1) on a Freescale iMX25 processor. The
> faq tells this processor is currently not supported by Xenomai, but
> the similar iMX27 is. I would like to find out what needs to be done
> to get Xenomai running on the iMX25 platform.

There are only two or three things that need to be implemented to port
the I-pipe patch for a new ARM board:
1- the system timer, based on some kind of hardware timer;
2- the TSC emulation (usually also based on a hardware timer, often the
same as used for the system timer);
3- if they exist, the GPIO interrupts de-multiplexing.

If we assume that the iMX25 has the same hardware timers as iMX27, you
probably only need to implement 3.

In any case, a guide on how to port Xenomai on a new ARM platform exists
here:
http://www.xenomai.org/index.php/I-pipe:ArmPorting

> 
> Does anyone on this list have any input or have experience already
> with Xenomai on an iMX25?
> 
> Also I am a little confused about the extra ipipe-2.6.26-mxc.diff
> patch contained in Xenomai. Is the iMX27 supported for a 2.6.28 kernel
> with the normal adeos-ipipe-2.6.28-arm-1.12-05.patch, or is it
> supported only until the 2.6.26 kernel with the ipipe-2.6.26-mxc.diff
> patch?

ipipe-2.6.26-mxc.diff is a backport to 2.6.26 of the MXC patches which
were included in 2.6.27, that is because the port to MXC was done
between the time when the MXC patches were submitted on the
linux-arm-kernel mailing list, and the time when they were merged and
released with 2.6.27. Starting from 2.6.27 onwards, the I-pipe support
for MXC is included into the I-pipe patch.

So, yes, adeos-ipipe-2.6.28-arm-1.12-05.patch, should be ok.

-- 
                                          Gilles


