Subject: Re: Antwort: Re: [Xenomai-help] pSOS skin questions
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF1CB72C09.F6D4F8B3-ONC12571EA.0055805B@uk.marconicomms.com>
References: <OF1CB72C09.F6D4F8B3-ONC12571EA.0055805B@uk.marconicomms.com>
Content-Type: text/plain
Date: Sun, 17 Sep 2006 17:50:52 +0200
Message-Id: <1158508252.4979.19.camel@domain.hid>
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
To: Thomas Necker <Thomas.Necker@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-09-15 at 17:56 +0200, Thomas Necker wrote:
> > > - Is somebody out there actually using the pSOS skin? Who should I 
> send 
> > > patches to?
> 
> > Please send your patches to xenomai@xenomai.org. They will be reviewed
> > and possibly picked from there.
> 
> Ok. I'll do that as soon as the behaviour of my program resembles a bit
> the behaviour when running under the original OS ;-)
> 
> > In any case, the pSOS interface is carefully maintained, and bugs will
> > be fixed as they are reported. Providing a simple testcase to reproduce
> 
> That's good to hear.
> 
> > If you want to run the pSOS interface over the UVM, you just need the
> > nucleus and the uvm support. If you want to run kernel space pSOS apps,
> > then you need the nucleus and the psos module.
> 
> Ok. I'll go with the nucleus and UVM for the moment as you described it. 
> Thus,
> I managed to get the tm_evafter to work.

I checked both tm_evafter() over the UVM and the simulator, and this
call works as expected here, so I guess that the source of the problem
was elsewhere (maybe the timing mode).

>  My program still behaves pretty 
> odd -
> but that's not necessarily Xenomai's problem.
> 

You may want to pass --enable-debug when configuring the user-space
support. Some useful additional checks would be performed by the nucleus
when running inside the virtual machine.

> Thanks again,
> Thomas
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



