Date: Fri, 25 Jun 2010 00:50:57 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100624225057.GA9802@domain.hid>
References: <4C177276.7060005@domain.hid> <20100615221116.GB3087@domain.hid>
	<4C1915BD.1020601@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C1915BD.1020601@domain.hid>
Subject: Re: [Xenomai-help] How to avoid a tight real time loop
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
> Alexis Berlemont wrote:
> > Hi,
> > 
> > Daniele Nicolodi wrote:
> >> Hello. In my application I need to read data from an ADC card in blocks
> >> of a given number of samples. For efficiency I'm using an mmapped buffer
> >> to exchange data with the ADC driver. I'm setting up the acquisition,
> >> and then calling a loop like this:
> >>
> >> unsigned int required = <compute required number of bytes>;
> >> unsigned int read = 0;
> >> while (1) {
> >>   while (read < required) {
> >>     read = a4l_pool(...);
> >>   }
> >>   process(buffer, ...);
> >> }
> >>
> >> However if I run this loop in a real time thread the tight while loop is
> >> an obvious cpu hog: the watchdog kicks in and kills the thread.
> >>
> >> There is not an analogy API that can be used to require a certain amount
> >> of data to the ADC driver. How can I code this loop to let other
> >> processes to run?
> > 
> > As a matter of fact, there is something in the API which could have
> > helped you in an unmapped configuration. If you set the flag
> > A4L_CMD_BULK in the field "flags" of the command structure, a call to
> > a4l_async_read() only returns when the data size specified as argument
> > is available. 
> > 
> > Unfortunately, I have not done the same thing with a4l_poll, I might
> > have added the requested size as an additional argument to a4l_poll. 
> > 
> > Any idea on how to extend the API without breaking it ?
> 
> Maybe it would be possible to use the standard "select" call, with a
> threshold configurable with an ioctl ?

Thanks. I added your idea in my TODO list.

> 
> 
> -- 
> 					    Gilles.

-- 
Alexis.

