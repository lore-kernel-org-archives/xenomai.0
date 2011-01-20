Message-ID: <4D387148.3030306@domain.hid>
Date: Thu, 20 Jan 2011 18:30:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF1911EB62.67FE0A4E-ONC125781E.0029C740-C125781E.002C4F5B@LocalDomain>
	<alpine.DEB.1.10.1101200922440.1211@domain.hid>
	<4D384CC9.2040303@domain.hid>
	<alpine.DEB.1.10.1101201702340.1990@domain.hid>
	<4D386922.5080807@domain.hid>
	<alpine.DEB.1.10.1101201811090.1990@domain.hid>
In-Reply-To: <alpine.DEB.1.10.1101201811090.1990@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] debug posix skin - pthread_cond_wait return EPERM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenoka09@domain.hid
Cc: xenomai@xenomai.org

Kolja Waschk wrote:
>>> file cond-torture-posix
>> Ok. On my side: I call set solib-absolute-prefix to where the debug
>> binaries for the target filesystem are. And I call
>> handle SIG34 nostop noprint pass.
>>
>> Coud you try and do the same?
> 
> Is SIG34 the same on blackfin? I do not remember ever having seen SIG34, only
> SIG32 ("Real-time event 32")
> 
> Independent of that, the result is always the same SEGV. I cannot use the absolute-prefix currently, as the directory layout is different on the target. So my script is now

Ok. I tried cond-torture-posix without set-solib-absolute prefix, or
without handle SIG34, added the "break main". Everything runs fine.

So, I am afraid you are on you own if you want to debug this.

> 
> set solib-absolute-prefix notexistent
> set solib-search-path /opt/uClinux/blackfin-linux-dist/staging/usr/lib:/opt/uClinux/bfin-linux-uclibc/bfin-linux-uclibc/runtime/lib
> file cond-torture-posix
> handle SIG34 nostop noprint pass
> target remote 10.0.10.9:2222
> 
> And regardless whether I add an "break main", the SEGV will occur immediately after telling gdb to "cont".
> 
> Does my "try.c" always succeed (all errbits=0x0010) in your environment?

I was reluctant to try, because for me cond-torture-posix should be the
reference, and the program is bogus in the way it handles
pthread_cond_wait errors, as I already explained, and may have bugs
which may escape at first sight (for instance, there is a race with the
sleep(1) and the time it takes to start the threads, which may well byte
you when running under gdb). Anyway, I tried, and it works like a charm,
however it appears to me now that you are clearly mis-compiling this
program, since you should be using #include <pthread.h>, instead of
#include <posix/pthread.h>, and more importantly, this program is
missing a call to mlockall without which it can not possibly run under
Xenomai.

So, to settle the matters, could you post here the result of
"bfin-linux-uclibc-nm -s try".
?

-- 
                                                                Gilles.

