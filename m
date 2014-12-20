Date: Sat, 20 Dec 2014 16:54:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141220155455.GA3961@daedalus>
References: <CAFgu5KXBDRLxt4q3PUw9he+4Z97RV0=Q96Y+or7FzEwT3CVZRA@mail.gmail.com>
 <20141220153337.GD24110@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141220153337.GD24110@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] Kernel Configuration Woes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Sat, Dec 20, 2014 at 10:33:37AM -0500, Lennart Sorensen wrote:
> On Sat, Dec 20, 2014 at 12:05:25AM -0800, Justin Hart wrote:
> > I recently rebuilt my kernel and I seem to be running into some problems
> > that I previously encountered with xenomai.  Unforutnately, I can't seem to
> > fix them.
> > 
> > When I load my application (which runs at Barrett WAM), I get the following
> > messages in my kernel log.
> > 
> > Dec 19 23:59:01 magnum kernel: [ 1232.835449] Clocksource tsc unstable
> > (delta = 1998076024 ns)
> > Dec 19 23:59:01 magnum kernel: [ 1232.835477] Switched to clocksource
> > refined-jiffies
> > 
> > At this juncture, a few things happen, my entire system grinds to a halt,
> > my system clock starts to drift significantly, and xeno-test reports major
> > clock drift.
> > 
> > CPU  ToD offset [us] ToD drift [us/s]      warps max delta [us]
> > --- -------------------- ---------------- ---------- --------------
> >   0          164328553.0      7034205.095          0            0.0
> >   1          164329131.5      7033385.416          0            0.0
> >   2          164328794.0      7030756.296          0            0.0
> >   3          164328783.3      7030646.980          0            0.0
> > 
> > I'm running kernel 3.14.17, xenomai 2.6.4, and the default ipipe that comes
> > with 2.6.4
> > 
> > Attached is my .config
> > 
> > Does anybody have any idea what I'm doing wrong?  This looks pretty close
> > to what I had marked in my notes.
> 
> I suspect it would help a lot to know what hardware this is on.
> 
> The tsc being unstable seems rather bad, since I can't imagine using
> jiffies is going to give any removely stable for system time.
> 
> I am surprised if any modern x86 hardware has bad tsc support, unless
> of course SMI is involved.

Very likely the problem is not related to the tsc at all. You have
to understand that the principle of Xenomai is to stop Linux at some
point to run the RT threads, then resume Linux at the point where it
was preempted when the RT threads suspend. So, if the RT threads run
for too long, Linux will experience some "loss of time", which may
have some consequences on all sorts of watchdogs, the tsc having
such a watchdog. The usual advice is to get Xenomai threads to
suspend every Linux tick. I believe the tsc watchdog has a
workaround for this issue in the I-pipe patch, but maybe it got
broken by some upstream code change in 3.14.

-- 
					    Gilles.

