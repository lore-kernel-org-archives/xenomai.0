From: Lowell Gilbert <kludge@be-well.ilk.org>
References: <44eflvcaft.fsf@lowell-desk.lan>
 <31210f5e-1137-54e8-9e22-7562de250614@xenomai.org>
 <115c0698-ad5f-2dae-4ed4-1e027839eae1@xenomai.org>
 <44d11e1akp.fsf@be-well.ilk.org> <44o9kumikv.fsf@lowell-desk.lan>
 <99BAB48E90E86D42AD41F0BCE3225AEB019FBEC572@GRZSMS582.andritz.com>
Date: Mon, 12 Feb 2018 11:32:01 -0500
In-Reply-To: <99BAB48E90E86D42AD41F0BCE3225AEB019FBEC572@GRZSMS582.andritz.com>
 (Lange Norbert's message of "Mon, 12 Feb 2018 14:25:45 +0000")
Message-ID: <44zi4ekw3i.fsf@lowell-desk.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Xenomai] rtdm_timer_start latency?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Lange Norbert <norbert.lange@andritz.com> writes:

> this seems identical to an issue I have. I wanted to start a
> millisecond tick, aligned to seconds, but used the POSIX
> timerfd_settime.  Under Linux this works as intendent, under cobalt it
> doesn't.
>
> I expect that the first timeout would be somewhat close to the call,
> on a "whole" millisecond.
>
> What happens is that the timer-function convert the (Nano-)seconds to
> the internal resolution. This has a small error, which normally won't
> matter for short timespans.  The problem here is, that the absolute
> time will get converted with a big (absolute) error - growing bigger
> the longer your system is up.
>
> What you could do, is reading the current time and fixing it up to a
> whole tick close to it, name this prev_secondtime, then use this as
> initial value.  Now the driver will have to fixup nothing or only a
> small amount, keeping the error low.

It seems like a different problem to me, because I'm working in relative
mode, so such rounding shouldn't have a chance to get very large.

Also, I have a hardware timer that allows me to kick off much more often
than the system tick. Once the timer starts, it fires quite accurately
as often as every 10 microseconds.

