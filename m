From: "Gideon Spreeth" <gideon@domain.hid>
Date: Wed, 10 Feb 2010 13:45:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <4B728A56.6010605@domain.hid>
Message-Id: <E1NfB6Z-0000A4-RH@linux.dcomt.com>
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
To: xenomai@xenomai.org



> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, February 10, 2010 12:29 PM
> To: Gideon Spreeth
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] ARM
> 
> Gideon Spreeth wrote:
> > Hi there,
> >
> >
> >
> > I am using a AT91SAM9260-ek board to develop a multiplexing card. I
> built
> > Angstrom linux with kernel 2.6.27 and also built in Xenomai 2.4.91 (2.5
> > rc2). Xenomai features works ok, but I have a problem with the Xenomai
> uart
> > driver.. The xeno_16550A serial driver is not compatible with the ARM
> uarts
> > and I cant seem to find a compatible one except for writing my own. Also
> > linux app like setserial, does not work correctly, I also think as it
> does
> > not have support for Atmel serial. So the standard solution of killing
> > serial driver with setserial and then modprobe xeno_16550A does not
> work..
> 
> If setserial does not work with the Linux serial driver, it is not
> Xenomai's fault, you are asking the wrong list.
[Gideon Spreeth] 
I know, just stating that there isn't really support...
> 
> >
> >
> >
> > Does anyone have a xenomai serial driver for ARM? Any other help you
> might
> > give will be much appreciated..
> 
> Each ARM SoC has its own serial driver. There is a driver for the IMX
> SoCs family floating on the mailing list (not yet merged in Xenomai
> sources), but not for AT91. I am afraid you will have to write the
> serial driver for AT91. If you do that, we will be happy to include it
> in Xenomai sources distribution.


 [Gideon Spreeth] 
Thank you, but is there no one around here that's working on it or know of a
driver? would have preferred not to waste time on this if someone already
did it. If not, then I'll probably get going and let you know when I have
something working..

Thanx..
> 
> 
> --
> 					    Gilles.


