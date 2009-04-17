From: Vikesh Rambaran <vikesh.rambaran@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904161537400.26955@domain.hid>
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<Pine.LNX.4.64.0904101708030.4820@domain.hid>
	<6C68EA7C-72E4-482D-917A-24C7C6DA31C9@domain.hid>
	<Pine.LNX.4.64.0904101729031.4820@domain.hid>
	<49E08F6F.8000604@domain.hid>
	<Pine.LNX.4.64.0904111233180.32647@domain.hid>
	<49E0F887.40805@domain.hid>
	<Pine.LNX.4.64.0904111820330.6444@domain.hid>
	<49E1B05A.4040705@domain.hid>
	<Pine.LNX.4.64.0904121206040.23562@domain.hid>
	<49E23FB1.5030505@domain.hid>
	<Pine.LNX.4.64.0904151951500.9694@domain.hid>
	<1239872431.5845.25.camel@domain.hid>
	<Pine.LNX.4.64.0904161537400.26955@domain.hid>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Apr 2009 10:01:39 +0200
Message-Id: <1239955299.5833.36.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] Running xeno-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Thu, 2009-04-16 at 16:33 -0700, Martin Shepherd wrote:
> On Thu, 16 Apr 2009, Vikesh Rambaran wrote:
> >...
> > Just for info, we are having similar issues with Ubuntu 8.04.2 LTS
> > running linux 2.6.27 / 2.6.28 patched with xenomai 2.4.7. For more info
> > on what we've tried see recent emails titled Xenomai LTTng support.
> 
> Thanks.  By the way, have you used Xenomai before, and if so, how well
> has it worked for you in the past? I'm wondering whether lockups and
> other problems are typical of Xenomai.
> 

We have used Xenomai in a few HILS (Hardware in the Loop Simulation)
environments. With the appropriate hardware, Xenomai applications have
met our requirements in terms of timing and stability.

As with any product, there are sometimes problems, but the support from
the developers and community are excellent. 

In my experience the Xenomai environment and support is on par (and
sometimes exceeds) international products for which we pay !

Generally the problems that we have are with programmer interfacing with
the keyboard :) 

< End of sales talk :) >

> > In our case, no xenomai application needs to be running for the lockup
> > to occur.
> 
> Same here. Right now I'm recompiling 2.6.28.7 under Ubuntu 8.10, but
> this time without the Xenomai patches, to see if the lockups really
> are Xenomai's fault. Unfortunately it takes 4 hours to compile the
> kernel on the old machine that I'm using...
> 

In our case the vanilla 2.6.28.7 kernel did not lock up after more than
an hour of use. Xenomai patched kernel locks up within a few seconds /
minutes. Lockup occurs after we log into the Gnome desktop. Working
only in the console environment seems ok thus far.

Keep well
Vicki



