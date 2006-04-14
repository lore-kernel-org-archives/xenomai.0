From: Tobias Marschall <tmarscha@domain.hid>
Subject: Re: [Xenomai-help] Problems running testsuite
Date: Fri, 14 Apr 2006 13:42:39 +0200
References: <200604131149.40706.tmarscha@domain.hid>
	<443E9FD2.6070807@domain.hid>
In-Reply-To: <443E9FD2.6070807@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604141342.40129.tmarscha@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Scott Biddlestone <sbiddlestone@domain.hid>
Cc: xenomai@xenomai.org

Hello,

On Thursday 13 April 2006 21:00, you wrote:
> I saw a similar error when using --enable-x86-sep and not having NPTL
> enabled in glibc.
> Try configuring without --enable-x86-sep (used in the README.INSTALL
> Pentium x86 example, the default is disabled).
that did the trick, thank you for the hint! I did check that the cpu supported 
the sep instruction, but I wasn't aware that NPTL is required in this case.

Mentioning this in README.INSTALL would be helpful. I wonder if that mistake 
could be caught by configure. 

Regards,
Tobias

> Tobias Marschall wrote:
> >Hallo,
> >
> >I've been using rtai until now and decided to give xenomai (release 2.1) a
> >try. I followed the instructions from README.INSTALL, and everything
> > (kernel patching, compilation, etc.) went fine. Then I tried to run the
> > latency test, which failed:
> >
> >-----------
> >/usr/xenomai/testsuite/latency $ ./run
> >head: `-1' option is obsolete; use `-n 1' since this will be removed in
> > the future
> >*
> >*
> >* Type ^C to stop this application.
> >*
> >*
> >== Sampling period: 100 us
> >== Test mode: periodic user-mode task
> >== All results in microseconds
> >/usr/xenomai/bin/xeno-load: line 178:  5936 Killed                 
> > $suflag $* $cmdargs
> >-----------

