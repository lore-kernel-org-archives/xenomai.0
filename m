Message-ID: <4B728A56.6010605@domain.hid>
Date: Wed, 10 Feb 2010 11:28:38 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <E1Nf9fW-0008Fe-OI@linux.dcomt.com>
In-Reply-To: <E1Nf9fW-0008Fe-OI@linux.dcomt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] ARM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gideon Spreeth <gideon@domain.hid>
Cc: xenomai@xenomai.org

Gideon Spreeth wrote:
> Hi there,
> 
>  
> 
> I am using a AT91SAM9260-ek board to develop a multiplexing card. I built
> Angstrom linux with kernel 2.6.27 and also built in Xenomai 2.4.91 (2.5
> rc2). Xenomai features works ok, but I have a problem with the Xenomai uart
> driver.. The xeno_16550A serial driver is not compatible with the ARM uarts
> and I cant seem to find a compatible one except for writing my own. Also
> linux app like setserial, does not work correctly, I also think as it does
> not have support for Atmel serial. So the standard solution of killing
> serial driver with setserial and then modprobe xeno_16550A does not work..

If setserial does not work with the Linux serial driver, it is not
Xenomai's fault, you are asking the wrong list.

> 
>  
> 
> Does anyone have a xenomai serial driver for ARM? Any other help you might
> give will be much appreciated..

Each ARM SoC has its own serial driver. There is a driver for the IMX
SoCs family floating on the mailing list (not yet merged in Xenomai
sources), but not for AT91. I am afraid you will have to write the
serial driver for AT91. If you do that, we will be happy to include it
in Xenomai sources distribution.


-- 
					    Gilles.

