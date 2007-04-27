From: Paul <paul_c@domain.hid>
Date: Fri, 27 Apr 2007 17:56:29 +0100
References: <cbe23c50704270912i1cdb1272hd700a8b83775a34a@domain.hid>
	<46322259.5080409@domain.hid>
	<cbe23c50704270932t7475e16dt77e54ab1eebe0883@domain.hid>
In-Reply-To: <cbe23c50704270932t7475e16dt77e54ab1eebe0883@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704271756.29874.paul_c@domain.hid>
Subject: Re: [Xenomai-help] Core Dump on possibly buggy signal handler
	installation
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>


Hi Eric

On Friday 27 April 2007 17:32, Eric Noulard wrote:
> 2007/4/27, Jan Kiszka <jan.kiszka@domain.hid>:
> > > I mean I know that uninitialized memory have unpredictable consequence
> > > but here the bug is persistent after rerun, reboot, power cycle etc...
> >
> > What is a.sa_flags initialised when it is not initialised? 0? Maybe you
> > can nail it down to defined state that causes the core dump reliably.
> > Then we can also track down what happens to your sigaction call and
> > if/why Xenomai/I-pipe changes the picture in some regard.
>
> I did rerun as you suggest, find the code attached which
> consistentely core dump with xenomai kernel and (seems to) do nothing
> special with the other kernel.
>
> a.sa_flags = 0xbff81578;

Try:

    a.sa_flags = 0x04000000;


Regards, Paul.

