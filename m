Date: Thu, 21 May 2015 18:34:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150521163440.GM10686@hermes.click-hack.org>
References: <20150513203301.GC6169@csclub.uwaterloo.ca>
 <20150513203743.GG3759@hermes.click-hack.org>
 <20150513203833.GD6169@csclub.uwaterloo.ca>
 <20150514162351.GE6169@csclub.uwaterloo.ca>
 <20150514162831.GH3759@hermes.click-hack.org>
 <20150514164745.GF6169@csclub.uwaterloo.ca>
 <20150514193433.GG6169@csclub.uwaterloo.ca>
 <20150521163208.GL6169@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150521163208.GL6169@csclub.uwaterloo.ca>
Subject: Re: [Xenomai] 3.14 hangs with ipipe patch applied
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Thu, May 21, 2015 at 12:32:08PM -0400, Lennart Sorensen wrote:
> On Thu, May 14, 2015 at 03:34:33PM -0400, Lennart Sorensen wrote:
> > I managed to confirm that jiffies is in fact stuck at the boot time
> > -300000 value.  Now if I could only track down what code is supposed to
> > increment it.  The code I found (do_timer called by xtime_update) does
> > not appear to get called by anyone.
> 
> I have narrowed it down.  If I apply the ipipe patch except for
> drivers/irqchip/irq-gic.c then it still boots.
> 
> So only about 200 lines of patch left to investigate.
> 
> I guess the reason the timer ticks were not happening was that no
> interrupts were happening.

There is no need to guess that, it can be verified easily.

-- 
					    Gilles.

