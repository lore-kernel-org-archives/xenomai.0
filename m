From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <E1C5E37E-623F-41B8-892C-5101FD132E4A@gmail.com>
References: <mailman.45.1289905237.25153.xenomai@xenomai.org>
	<E1C5E37E-623F-41B8-892C-5101FD132E4A@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Nov 2010 09:43:46 +0100
Message-ID: <1289983426.1933.406.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Debug/trace tools for xenomai applications.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <andi.glatz@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2010-11-16 at 11:46 +0000, Andreas Glatz wrote: 
> > 
> > 
> > On Mon, 2010-11-15 at 21:26 +0100, ronny meeus wrote: 
> > > Hello 
> > > 
> > > 
> > > Thanks for the information. 
> > > I was testing on QEMU but I have seen that there are issue with
> > > the 
> > > timing anyhow. 
> > > I'm currently changing to a target environment. Once this is 
> > > completed, I will re-run my tests and get back with the result. 
> > > 
> > > 
> > > I do not really understand what you mean with the simulator. 
> > > Where can I find more information about it? 
> > 
> > 
> > http://git.xenomai.org/?p=xenosim.git;a=blob;f=doc/mvm-manual.txt;h=1c6767ea2890d68e1c1c5cfe1420e189b3cc5328;hb=06919eb3a6b6baf7880ea3ade1ecc5f610c35794 
> > 
> > 
> 
> 
> So in other words the simulator is a good debugging tool if your
> application doesn't (i) directly access hardware (mmap aso...)
> (ii) doesn't used assembly code written for another platform and (iii)
> can be compiled with the gcc 2.95.3. 
> 
> 
> For the first two restrictions this means in other words that
> the application should follow the golden design standard which
> proposes to put all hardware depended code into rtdm drivers and
> everything else into the application. 

Exactly. The hardware-dependent code should be either:
- stubbed or replaced with some C/C++ code providing limited feedback,
enough to have the application running.
- left in, but connected internally to a software component partially or
fully modeling the hardware. Such component would run within the
simulator directly, which is actually an extensible event-driven
simulation engine, with a C++ interface to build add-ons/models.

> 
> 
> Could one (partly) work around the first two restrictions by letting
> the simulator run inside of qemu which emulates the
> target architecture?

Maybe for the inline assembly code which is not directly device-related.
Running RTDM drivers in simulation mode would require to simulate the
devices with a model though.

> 
> Andreas
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.




