Subject: Antwort: Re: [Xenomai-help] pSOS skin questions
MIME-Version: 1.0
Message-ID: <OF1CB72C09.F6D4F8B3-ONC12571EA.0055805B@uk.marconicomms.com>
From: "Thomas Necker" <Thomas.Necker@domain.hid>
Date: Fri, 15 Sep 2006 17:56:58 +0200
Content-Type: text/plain; charset="us-ascii"
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

> > - Is somebody out there actually using the pSOS skin? Who should I 
send 
> > patches to?

> Please send your patches to xenomai@xenomai.org. They will be reviewed
> and possibly picked from there.

Ok. I'll do that as soon as the behaviour of my program resembles a bit
the behaviour when running under the original OS ;-)

> In any case, the pSOS interface is carefully maintained, and bugs will
> be fixed as they are reported. Providing a simple testcase to reproduce

That's good to hear.

> If you want to run the pSOS interface over the UVM, you just need the
> nucleus and the uvm support. If you want to run kernel space pSOS apps,
> then you need the nucleus and the psos module.

Ok. I'll go with the nucleus and UVM for the moment as you described it. 
Thus,
I managed to get the tm_evafter to work. My program still behaves pretty 
odd -
but that's not necessarily Xenomai's problem.

Thanks again,
Thomas


