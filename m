From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4D6CE2E8.2070706@domain.hid>
References: <alpine.DEB.1.10.1102281209570.12109@domain.hid>
	<4D6B9032.5060907@domain.hid>
	<alpine.DEB.1.10.1102281325340.12109@domain.hid>
	<4D6B92C8.3070505@domain.hid>
	<alpine.DEB.1.10.1102281342180.12109@domain.hid>
	<4D6B97E5.5030901@domain.hid>
	<alpine.DEB.1.10.1102281353490.12109@domain.hid>
	<4D6BA899.90600@domain.hid>
	<alpine.DEB.1.10.1102281944470.12808@domain.hid>
	<4D6CE2E8.2070706@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Mar 2011 18:47:03 +0100
Message-ID: <1299001623.2067.39.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] More blackfin kernel oops under heavy load
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, 2011-03-01 at 13:13 +0100, Gilles Chanteperdrix wrote:
> Kolja Waschk wrote:
> >> I do not really understand what we are talking about. Are we talking
> >> about Linux select/accept or Xenomai select/accept? Why not using the
> > 
> > Linux select/accept. Using the blocking accept() would have changed the
> > behaviour somewhat compared to the original design. Anyway, I think that doesn't
> > actually matter much.
> > 
> > I have meanwhile derived a much smaller RTDM driver kernel module, test
> > application with blocking accept() ;) plus Makefile that do not depend on any
> > particular external hardware anymore: A SPORT interface (SPORT1 receiver) is
> > configured with internal clock and frame sync generation and so on itself
> > generates a lot of interrupts, and this alltogether quite quickly reproduces
> > the problem on my system. The files together are less than 1000 lines, 20kb.
> > 
> > I'd really appreciate if you or someone could take a look at it and maybe try
> > the code on his own bf537 system whether the same faults occur, and why. May I
> > post the files here (as a zipped attachment? inline)? I've already uploaded
> > a copy at
> > 
> >> http://www.ixo.de/tmp/till20110228.tgz
> 
> Thanks a lot. I do not know much about blackfin, Philippe is the
> specialist. But having this code will certainly help find the issue.
> 

Clearly, yes. Thanks. I'll do my best to find cycles to have a look at
this asap.

> Regards.
> 

-- 
Philippe.



