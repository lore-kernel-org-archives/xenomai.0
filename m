Date: Tue, 31 May 2016 13:32:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160531113216.GD5951@hermes.click-hack.org>
References: <E1b7OM2-0000oL-Q7@sd-51317.xenomai.org>
 <20160530152043.GE17483@hermes.click-hack.org>
 <574D702F.6000303@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <574D702F.6000303@siemens.com>
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Provide
 RT-capable usleep
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On Tue, May 31, 2016 at 01:06:23PM +0200, Jan Kiszka wrote:
> On 2016-05-30 17:20, Gilles Chanteperdrix wrote:
> > On Mon, May 30, 2016 at 04:39:42PM +0200, git repository hosting wrote:
> >> Module: xenomai-jki
> >> Branch: for-forge
> >> Commit: ec9a8c81944d4a3e3f50af314fa58ade68dd28c2
> >> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=ec9a8c81944d4a3e3f50af314fa58ade68dd28c2
> >>
> >> Author: Jan Kiszka <jan.kiszka@siemens.com>
> >> Date:   Mon May 30 14:58:07 2016 +0200
> >>
> >> lib/cobalt: Provide RT-capable usleep
> >>
> >> User may expect this (probably last) sleeping service to be available
> >> under Cobalt just like sleep, nanosleep & Co.
> > 
> > CONFORMING TO
> >        4.3BSD,  POSIX.1-2001.   POSIX.1-2001  declares this function obsolete;
> >        use nanosleep(2) instead.  POSIX.1-2008 removes  the  specification  of
> >        usleep().
> 
> Do you expect people - and specifically Linux - to follow this soon?
> 
> The idea here is to reduce the level of surprise, and as long as using
> usleep in your app doesn't cause an "undefined symbol" error, this risk
> persists.

The thing is adding services do not come for free: it incurs a
maintenance cost. From my point of view, one of the imperatives of
the Xenomai project is to keep the code base small (and simple) so
that it remains possible to maintain it with the little work force
we have. From this point of view, adding a wrapper for a service
that has been deprecated for 15 years, and removed from the POSIX
specification for 8 years does not look like a smart move. And every
time we want to add a service, we should wonder if it is worth the
maintenance burden it incurs, this is the reason why I questioned
adding pthread_setschedprio too.

That being said, I am not opposed to this, and will happily let
other people decide. I just wanted to make sure that everyone
realized that usleep has been dead a long time.

If people use usleep, they will get a switch to secondary mode and
realize they should not use it, it is not as if it could cause a
crash or something. We might even document that somewhere.

-- 
					    Gilles.
https://click-hack.org

