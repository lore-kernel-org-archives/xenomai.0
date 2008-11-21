Message-ID: <4926BE0A.8000505@domain.hid>
Date: Fri, 21 Nov 2008 14:56:26 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4926A240.6040709@domain.hid>
In-Reply-To: <4926A240.6040709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Automatic shadowing in POSIX lib constructor
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Gilles,
> 
> as indicated in an earlier post, my customer managed to reveal some
> issues around dlopen'ing Xenomai libs, more precisely libs that were
> linked against libpthread_rt. The constructor of the POSIX lib has
> several problems here, and I think some are not fixable:
> 
>  o it auto-maps the constructor's caller even if it is not the main
>    thread, and before main() was called
> 
>  o it ignores the caller's priority and sched policy, overwriting it
>    with SCHED_OTHER
> 
>  o it removes mlockall from the process even if it was locked on entry
> 
> At least the last thing seems to be very hard to fix, but also for the
> first item (testing if we are executed on application startup or later)
> I see no solution right now.
> 
> So I propose to control automatic mapping as follows:
>  - rebrand --without-__thread as --enable-dlopen, keeping it off by
>    default
>  - continue to check for platform support of initial-exec TLS, only
>    use it when available *and* --enable-dlopen is not selected
>  - don't perform auto-mapping in __init_posix_interface if
>    --enable-dlopen is selected
> 
> This is build around the assumption that the user intentionally sets
> --enable-dlopen because (s)he actually wants to use Xenomai libs like
> that. And in that case (s)he is also expected to has a custom approach
> which threads are shadowed (and with which priority) and which maybe not.
> 
> Comments? Better suggestions?

The libtpthread_rt constructor is clearly written for the most common
case. I agree with your idea. Nevertheless, I think that when we detect
the failing case (I do not know yet how), we should issue a clear
message directing the use to the --enable-dlopen option.

-- 
                                                 Gilles.

