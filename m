Subject: Re: [Xenomai-help] Running more than one "skin" at the same time?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17684.19490.88293.797591@domain.hid>
References: <F75B1CC921BD8E43B7D0484C9AB4C490450F9F@SJEX2003CL1.gmi.domain>
	<1158950010.5175.103.camel@domain.hid>
	<17684.19490.88293.797591@domain.hid>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 00:45:21 +0200
Message-Id: <1158965121.5175.116.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, David Betz <david.betz@domain.hid>

On Fri, 2006-09-22 at 22:48 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Fri, 2006-09-22 at 10:37 -0700, David Betz wrote: 
>  > > Is it possible to run more than one skin on top of the nucleus at the
>  > > same time? For instance, can I run the pSOS skin at the same time as
>  > > the Xenomai Native API?
>  > 
>  > In short, not yet. There is a timing mode compatibility issue between
>  > the native/POSIX skins and the pSOS module. This particular issue will
>  > be fixed somewhere in the 2.3.x series. You might still mix both now
>  > with a bit of hacking, but this would require that timeout values passed
>  > to pSOS calls be rescaled as counts of nanoseconds instead of ticks,
>  > which might not be an option for you.
> 
> It is also possible to run the native and POSIX skins in periodic mode.
> 

It really depends on which skin provides the time base. If it's pSOS,
then every skin would be happy to use the periodic mode as the pSOS
emulator does. If you implement services over the native/posix skin
requiring precise timing such as for accurate data sampling that feeds
data to the pSOS application in turn, then periodic timing for all won't
fly, at least until the periodic mode is eventually emulated over the
oneshot mode as planned.

>  > > If so, would all of the calls from a single user mode process have to
>  > > be to one of the skins or could calls be mixed? In other words, could
>  > > a single thread in a user mode process at one point block on a pSOS
>  > > semaphore and later block on a Native API semaphore? What are the
>  > > rules for mixing and matching API calls?
>  > > 
>  > 
>  > The rule of thumb is that blocking syscalls would require to be invoked
>  > from threads created by the same skin, e.g. a pSOS sema4 would only
>  > allow pSOS tasks to pend on it, but would allow any kind of task to post
>  > it. The same goes for all calls that directly affect particular skin
>  > properties (e.g. sending signals through ev_send() must target a pSOS
>  > task). But for instance, a native task would be allowed to suspend or
>  > resume a pSOS one, since the only thing that needs to be known at that
>  > point is the target task identifier, and we basically don't care of the
>  > caller's nature.
> 
> A word about the posix skin: only services related to signals and
> cancellation absolutely require posix skin threads, all other services,
> including synchronization objects and message queues are accessible from
> other skins threads.

Unfortunately, we cannot do that on the same scale for the native one,
since many synchronization objects there require to hold some data in
the native task control block, and we could not reasonably stuff them
into the control block of the underlying generic nucleus threads. So
David, unless you are absolutely fond of the native API, you may want to
consider using the POSIX skin instead; this would likely ease your work.

> 
> 
-- 
Philippe.



