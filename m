Date: Fri, 20 Oct 2006 11:12:05 +0200
From: Robert Schwebel <r.schwebel@domain.hid>
Subject: Re: [Xenomai-help] Re: LIRE LInux Real-time Environment
Message-ID: <20061020091205.GB18636@domain.hid>
References: <s5363968.059@domain.hid> <45362AE0.60301@domain.hid>
	<1161270429.9460.17.camel@domain.hid> <4537AA25.4090900@domain.hid>
	<20061020083104.GA18636@domain.hid> <45389018.3080706@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <45389018.3080706@domain.hid>
Sender: Robert Schwebel <rsc@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, kritop@domain.hid

On Fri, Oct 20, 2006 at 11:00:08AM +0200, Jan Kiszka wrote:
> > Tell me if we can do something to boost your playing activities :)
> 
> Take over the rest of our daily work. ;)

Ok, if you take over mine we might make a deal :)

> > PTXdist can easily cope with usual things like patches, patch stacks
> > with series files and local software packages. So everything you
> > need should be there without turning PTXdist upside down. 
> 
> Xenomai is special in that it comes as one package for kernel patch,
> kernel "hook" (which may also be expressed as a patch), and user space
> libs/tools.

The easiest way is probably to just put the patches into

	kernel-patches-native/

of your project and create a series file for them. You can use the
normal kernel build magic then and don't have to provide your own kernel
packet. Then make a separate packet for the tools. 

> Yeah, I'm going to start a thread there soon (once I fixed some other
> issue - daily work, you know). Anyone interested is welcome to join
> the thread again.

Ok. Note that we are very close to 0.10.5, so it might be a topic for
the next release then.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


