From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1243533530.898.36.camel@domain.hid>
References: <1243526358.898.21.camel@domain.hid>
	<1243529533.22173.6.camel@domain.hid>  <1243533530.898.36.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 28 May 2009 23:47:03 +0200
Message-Id: <1243547223.22173.54.camel@domain.hid>
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

On Thu, 2009-05-28 at 14:04 -0400, Andreas Glatz wrote:
> On Thu, 2009-05-28 at 18:52 +0200, Philippe Gerum wrote:
> > On Thu, 2009-05-28 at 11:59 -0400, Andreas Glatz wrote:
> > > Hi,
> > > 
> > > We have to start 40+ Xenomai tasks in kernel space.
> > 
> > Why subjecting yourself to the pain of running a complex application in
> > kernel space? The difference between kernel and userland latencies on an
> > mpc836x should not be worth it.
> > 
> 
> We see a 70us difference between running exactly the same
> application in kernel-space and user-space. The application
> registers the rx and tx interrupt of one UEC and replaces
> the buffer descriptor rings allocated by Linux, and 
> takes care of the buffer handling. During the
> test we send out an Ethernet frame from the MPC8360, the
> frame gets processed on the other end of the wire and 
> eventually we receive the response from the other device. 
> The total round trip time (function call send() to 
> return of function call receive() measured with __xn_rdtsc()) 
> is 230us in kernel-space and 300us in user-space.
> 

A 70 us difference is pathological, this does not follow the common
latency ratio between kernel-based and userland tasking, really. If you
still have your userland test at hand, you may want to
display /proc/xenomai/stat periodically while it runs, checking whether
any of your communication task has a suspicious increase of its MSW
counter.

The other aspect, if I understand correctly, may involve the method you
picked for transferring data back and forth between your MAC layer and
the tasks running in userland. Message queues for instance would
probably not be the best approach in your case, since you would likely
pay extra data copies due to the different address spaces.

> 
> FYI: Another device which used direct SMI instead of Ethernet
> to talk to the device on the other end of the wire showed a
> round trip time of 40us... 
> 

What bothers me is that you seem to determine a latency based on
measurements of a round trip time, obtained on an ethernet network. So
it is a bit difficult for me to give any interpretation about the 70 us
figure; too many variables in that equation.

> 
> Andreas
-- 
Philippe.



