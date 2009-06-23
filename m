From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1245749419.3986.165.camel@domain.hid>
References: <1243526358.898.21.camel@domain.hid>
	<1243529533.22173.6.camel@domain.hid> <1243533530.898.36.camel@domain.hid>
	<1243547223.22173.54.camel@domain.hid> <1245677021.9238.6.camel@domain.hid>
	<1245749419.3986.165.camel@domain.hid>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 12:37:39 +0200
Message-Id: <1245753459.3986.173.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running out of stack memory in kernel-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Andreas Glatz <AndreasGlatz@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2009-06-23 at 11:30 +0200, Philippe Gerum wrote:
> On Mon, 2009-06-22 at 09:23 -0400, Andreas Glatz wrote:
> > Hi,
> > 
> > 
> > > What bothers me is that you seem to determine a latency based on
> > > measurements of a round trip time, obtained on an ethernet network. So
> > > it is a bit difficult for me to give any interpretation about the 70 us
> > > figure; too many variables in that equation.
> > > 
> > > > 
> > 
> > 
> > I finally upgraded Xenomai from version 2.4.4 to 2.4.8
> > as you strongly suggested last time and I can say 
> > that this fixes all of the bugs we found in the earlier 
> > version. Thanks a lot for that!!
> > 
> > Furthermore I did some serious measurements with the new
> > Xenomai version on an MPC8360. In short, I measured
> > an interrupt latency around 7us when running in kernel-space
> > and around 35us when running in user-space. You can find
> > the details of those measurements the end of this Email!
> > 
> > I have two more questions:
> > 
> > 1) In the legacy code I am porting, critical sections are
> > protected by disabling/enabling ALL interrupts (like
> > sti/cli in kernel-space). This method is much faster than
> > locking a mutex, which might put a task to sleep.
> 
> Usually yes, but at the expense of wrecking the priority-based model of
> the RTOS when misused.
> 
> >  Are there
> > similar, portable functions available under Xenomai or IPIPE?
> 
> You should never rely directly on I-pipe features, using a Xenomai
> interface is the way to go.

I may have misunderstood your question actually: were you asking for a
way to block interrupts for user-space? If so, then forget about it.
There is no way to do this sanely, and safely. You should use mutexes;
2.5 even supports fastsynchs underneath, which could be roughly compared
as Xenomai's counterparts of Linux futexes.

-- 
Philippe.



