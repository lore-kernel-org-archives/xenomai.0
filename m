Message-ID: <45AE0C86.9080101@domain.hid>
Date: Wed, 17 Jan 2007 12:46:14 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] special glibc support for Xenomai?
References: <45AE059C.9050605@domain.hid> <1169033628.17493.35.camel@domain.hid>
In-Reply-To: <1169033628.17493.35.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
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
Cc: xenomai@xenomai.org

Philippe,

>> I wonder if I would need a special glibc support in order to build and run
>> xenomai applications.
> 
> In short, no. You could use the oldish linuxthreads, or the NPTL as you
> see fit, from any glibc version...
Thanks.

> ... Hi-res timing is provided by the
> Xenomai nucleus directly, and it is implicitely made available by the
> Xenomai APIs to the bound applications.

But that would need some low level support for my special platform? Cause
hrtimers are platform specific. Right?

> In the particular POSIX case, calling e.g. nanosleep() over a Xenomai
> thread context already gives you a microsecond-level precision for
> timings. 
Ok.

> You just need to make sure to compile/link with the hardened
> Xenomai POSIX library, try running:
> $ xeno-config --posix-cflags|--posix-ldflags.
What does it do?
Can I use it for cross-compiling as well?

Steven

