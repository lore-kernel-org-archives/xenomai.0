From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A05FD82-380E-4DBB-A848-CB2212F88C39@domain.hid>
References: <49EF6591.7000802@domain.hid>
	<468CF57C-40DE-498B-9C2C-C73AE07CFE4F@comcast.net>
	<49EF7088.6070006@domain.hid>
	<4A05FD82-380E-4DBB-A848-CB2212F88C39@domain.hid>
Content-Type: text/plain
Date: Thu, 23 Apr 2009 00:17:44 +0200
Message-Id: <1240438664.6987.85.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] An answer to Steven's questions.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Wed, 2009-04-22 at 17:17 -0400, Steven Seeger wrote:
> > You are repeating yourself, so, I am going to repeat myself. Just run
> > the latency test, if it does not have the same latency, then your
> > problem is in your application. It it has the same latency, then there
> > is a problem with Xenomai, and you should enable the I-pipe tracer and
> > send us the trace.
> 
> I see what you are saying. I believe our application has the same  
> latency but I am not there to see the timing analysis, so I will have  
> to take other peoples' word.

Sorry for being desperately clueless, and very probably hopelessly lost
in space, but I still have a dumb question for the guy in charge of this
problem, whoever he is (since you don't seem to be the one here):

Why can't we just have the output of a simple latency test on the
problematic GX1, using the bundled program we provide for that, and
copy&paste this text into a mail message, eventually directed to _this_
list?

We do _not_ know what the heck your application does, whether it has
problems or not. But, we could find out whether Xenomai has problems or
not on your particular hardware. You already confirmed that your
RTAI-based implementation differed totally from your Xenomai-based one,
so comparing won't help either. Btw, do you really think that other
users would settle for 3 digit latency figures on x86? Obviously not, so
what you see must be pathological. Therefore, the only question worth
discussing is: who is causing this?

Do you think we might have some clue regarding the way Xenomai works,
then answer the above question in case this is a Xenomai issue? If so,
then give us some actual data to examine the situation. Otherwise, it's
a total loss of time for everybody.

===================================================
EXECUTIVE SUMMARY to send to the boss in charge:
1) run /usr/xenomai/bin/latency for an hour with
   some process load (hackbench) and interrupt load.
2) copy&paste output to new e-mail
3) hit Send.
===================================================

We will do our best after this. No kidding. C'mon!

> 
> Steven
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



