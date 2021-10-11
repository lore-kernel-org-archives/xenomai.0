References: <7bfa02a9-b59b-2457-06cb-2a6aae7457c4@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: alchemy: *_timed API all wrongly documented?
Date: Mon, 11 Oct 2021 19:37:32 +0200
In-reply-to: <7bfa02a9-b59b-2457-06cb-2a6aae7457c4@siemens.com>
Message-ID: <87v923v4qy.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> Hi Philippe,
>
> it looks to me like all those *_timed functions are at least confusingly
> documented - or broken. They all carry
>
>  * @param abs_timeout An absolute date expressed in clock ticks,
>
> and
>
>  * @note @a abs_timeout is interpreted as a multiple of the Alchemy
>  * clock resolution (see --alchemy-clock-resolution option, defaults
>  * to 1 nanosecond).
>

This is a left over due to copy/pasting the original documentation of
the services taking a legacy RTIME argument instead of the current
timespec version. This should be dropped for all *_timed calls, which
indeed take a plain secs,nanosecs argument representing an absolute date
based on CLOCK_COPPERPLATE - no conversion is done on that one.

> However, they also all take a timespec argument as argument, means
> seconds and nanoseconds, not "ticks" that will be multiplied by some
> resolution. What was the intended API here? Or what should actually be
> written here? "Absolute timeout in nanoseconds based on
> CLOCK_COPPERPLATE, to be rounded according to that clock's resolution"?
>


-- 
Philippe.

