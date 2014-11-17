Date: Mon, 17 Nov 2014 11:22:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141117102236.GE23508@sisyphus.hd.free.fr>
References: <04e5e7e2fab241a5916e4e48f9d9b325@EX132MBOX1B.de2.local>
 <20141109155351.GH17476@sisyphus.hd.free.fr>
 <28083d9b9cc34fce9a6d308e8d12fbc6@EX132MBOX1B.de2.local>
 <20141110124308.GK17476@sisyphus.hd.free.fr>
 <b258eccb6b124aaf91fd1b35c9ccbf30@EX132MBOX1B.de2.local>
 <20141111174652.GK17476@sisyphus.hd.free.fr>
 <6f2c7097b3eb4473844743b8b495f5e0@EX132MBOX1B.de2.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2c7097b3eb4473844743b8b495f5e0@EX132MBOX1B.de2.local>
Subject: Re: [Xenomai] "inconsistent lock state" on boot-up
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Stoidner, Christoph" <c.stoidner@arvero.de>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Nov 17, 2014 at 10:01:40AM +0000, Stoidner, Christoph wrote:
> 
> Hi,
> 
> > you are completely right, we have implemented our own skin. Using
> > the debugging functionality mentioned above we have identified a
> > function-call that leads to exact the behaviour as described in your post.
> >
> > Hopefully solving that issue solves our application crash.
> 
> Now the problem "scheduling while atomic" does not occur anymore
> within API calls of our own skin. However, after some run-time
> (about 5 minutes or more) it seems to appear in gatekeeper-thread
> (see below).
> 
> What is not clear to me is the ipipe_raise_irq() call in backtrace
> below. I could not identify any according call from within
> gatekeeper_thread(). Do I overlook something?
> 
> What I also do not understand is the timestamp of kernel message.
> As mentioned the messages do appear about 5 minutes after kernel
> start. However the message's timestamp are from about 40 seconds
> after boot? Could it happen that messages are delayed? Or is the
> timestamp wrong?

This would probably mean an issue with the tsc emulation, have you
tried running the "tsc" program, from xenomai regression testsuite
with the -w option ? I remember than the imx28 tsc emulation is a
bit weird, the hardware sometimes returns wrong values, and the
support answer was "read it twice, until you get twice the same
value". But I never found this really satisfactory: what if reading
it twice returns the same wrong value twice ? 

The tsc test should see if the tsc wrapping is doing fine. You can
try to run it several time, or even in parallel to your tests, to
see if it does not detect any problem.

-- 
					    Gilles.

