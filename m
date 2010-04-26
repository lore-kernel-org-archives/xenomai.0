From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4BD49468.8000301@domain.hid>
References: <4BD45469.5040006@domain.hid> <4BD4926D.2080908@domain.hid>
	<4BD49468.8000301@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Apr 2010 17:21:26 +0200
Message-ID: <1272295286.28983.224.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull] Fix bogus lock stealing case
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Sun, 2010-04-25 at 21:13 +0200, Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
> > Jan Kiszka wrote:
> >> The following changes since commit fbc3b858ee728c1a6b03996e3285198caa7053c6:
> >>   Gilles Chanteperdrix (1):
> >>         debug: fix CONFIG_XENO_OPT_DEBUG_* issues
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.xenomai.org/xenomai-jki.git for-upstream
> > 
> > Something wrong here, the logs on your branch appear as:
> > 
> > 13ee2a1 nucleus: Fix bogus lock stealing case
> > d0d95bf mutex-torture: Add test for disallowed lock stealing
> > 9ef976e RTDM: Restrict use of rtdm_rt_capable
> > 6b75977 uitron: Fix skin debug option
> > bc3fefd Move schedule_delayed_work into wrapping header
> > 41b1eca RTDM: Drop __exit from rtdm_dev_cleanup
> > 4f3d3f2 bootstrap
> > 78acd8c Merge commit 'jan'
> > 700a9fd arm: add a generic-vfp architecture, which enables vfp and
> > compiles for armv5
> > 8337fc5 RTDM: Use non-atomic bitops for used_fildes
> > 
> > Seems you forgot to rebase?
> > 
> 
> Oops, incomplete rebase. Fixed.
> 

I was worried about any implication regarding v2.4.x, so I checked. It
turned out that such bug has been introduced by the FASTSYNCH code, with
the advent of xnsynch_acquire(). This code has added a fastpath that did
not exist initially for returning to the caller, which overlooked the
WAKEN/ROBBED semantics.

The basic assumptions were:

- XNWAKEN+XNROBBED bits are inconditionally cleared by
xnpod_suspend_thread().
- wwake makes sense only in a XNWAKEN context (therefore, you don't have
to clear it until you actually exit from xnsynch_sleep_on, and you may
only test it whenever XNWAKEN is raised).
- the only way to exit from xnsynch_sleep_on() used to be via the
unlock_and_exit path, which did clear the relevant bits, along with
wwake.

The first two assumptions are still valid, fortunately.

So, the good news is that v2.4.x is fine. And good news are a nice way
to relax, which is another good news.


-- 
Philippe.



