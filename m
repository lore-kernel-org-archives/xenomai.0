Subject: Re: [Xenomai-help] special glibc support for Xenomai?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45AE059C.9050605@domain.hid>
References: <45AE059C.9050605@domain.hid>
Content-Type: text/plain
Date: Wed, 17 Jan 2007 12:33:48 +0100
Message-Id: <1169033628.17493.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Steven Scholz <steven.scholz@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-01-17 at 12:16 +0100, Steven Scholz wrote:
> Hi all,
> 
> I wonder if I would need a special glibc support in order to build and run
> xenomai applications.
> 

In short, no. You could use the oldish linuxthreads, or the NPTL as you
see fit, from any glibc version. Hi-res timing is provided by the
Xenomai nucleus directly, and it is implicitely made available by the
Xenomai APIs to the bound applications.

In the particular POSIX case, calling e.g. nanosleep() over a Xenomai
thread context already gives you a microsecond-level precision for
timings. You just need to make sure to compile/link with the hardened
Xenomai POSIX library, try running:
$ xeno-config --posix-cflags|--posix-ldflags.

> Especially I think about high resolution timer support and NTPL thread
> library (which would be need if I'd do plain
> http://people.redhat.com/mingo/realtime-preempt right).
> 
> Thanks a million!
> 
> Steven
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



