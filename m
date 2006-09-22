From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17684.19490.88293.797591@domain.hid>
Date: Fri, 22 Sep 2006 22:48:34 +0200
Subject: Re: [Xenomai-help] Running more than one "skin" at the same time?
In-Reply-To: <1158950010.5175.103.camel@domain.hid>
References: <F75B1CC921BD8E43B7D0484C9AB4C490450F9F@SJEX2003CL1.gmi.domain>
	<1158950010.5175.103.camel@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org, David Betz <david.betz@domain.hid>

Philippe Gerum wrote:
 > On Fri, 2006-09-22 at 10:37 -0700, David Betz wrote: 
 > > Is it possible to run more than one skin on top of the nucleus at the
 > > same time? For instance, can I run the pSOS skin at the same time as
 > > the Xenomai Native API?
 > 
 > In short, not yet. There is a timing mode compatibility issue between
 > the native/POSIX skins and the pSOS module. This particular issue will
 > be fixed somewhere in the 2.3.x series. You might still mix both now
 > with a bit of hacking, but this would require that timeout values passed
 > to pSOS calls be rescaled as counts of nanoseconds instead of ticks,
 > which might not be an option for you.

It is also possible to run the native and POSIX skins in periodic mode.

 > > If so, would all of the calls from a single user mode process have to
 > > be to one of the skins or could calls be mixed? In other words, could
 > > a single thread in a user mode process at one point block on a pSOS
 > > semaphore and later block on a Native API semaphore? What are the
 > > rules for mixing and matching API calls?
 > > 
 > 
 > The rule of thumb is that blocking syscalls would require to be invoked
 > from threads created by the same skin, e.g. a pSOS sema4 would only
 > allow pSOS tasks to pend on it, but would allow any kind of task to post
 > it. The same goes for all calls that directly affect particular skin
 > properties (e.g. sending signals through ev_send() must target a pSOS
 > task). But for instance, a native task would be allowed to suspend or
 > resume a pSOS one, since the only thing that needs to be known at that
 > point is the target task identifier, and we basically don't care of the
 > caller's nature.

A word about the posix skin: only services related to signals and
cancellation absolutely require posix skin threads, all other services,
including synchronization objects and message queues are accessible from
other skins threads.


-- 


					    Gilles Chanteperdrix.

