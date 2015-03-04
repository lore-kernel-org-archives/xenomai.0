Message-ID: <54F73E7A.2070100@xenomai.org>
Date: Wed, 04 Mar 2015 18:18:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<54F5CD4D.8080004@xenomai.org>	<CAKk99t22fhrbc0GwURNJjdUfVfwmBvVyAWYYArVMgJfh4_JF+Q@mail.gmail.com>	<54F5D6C6.40908@xenomai.org>	<CAKk99t13XsRYBA15ws6ZbUsrqe5+b7D1xRM5NGKrUkvrLJWPCw@mail.gmail.com>	<54F5E958.2090701@xenomai.org>	<54F5EA06.4040104@xenomai.org>	<CAKk99t1DtxOFmTpf2ZgJ2coh_tNqMPY4VX0pAdEJZB6oGvko3g@mail.gmail.com>	<54F60A62.3020708@xenomai.org>	<54F60C16.5070500@xenomai.org>	<CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>	<54F614EF.7040307@xenomai.org>	<CAKk99t0Xh01uxG7jd=oEDD71LBHvTnbCnejwiP2bzGN63Yo-ZA@mail.gmail.com>	<54F6C50F.5040301@xenomai.org>	<CAKk99t1LaQg9HJkXuiXbi09Mhr5H2EXqcmHw5PPTN4=V7mT3Dg@mail.gmail.com>	<54F6EF2E.1090705@xenomai.org>	<CAKk99t3K=+Eo+Z_+nPEgi6FNWzg8gigZGfMnVW3Ap+XkVb5aTg@mail.gmail.com>	<54F716CC.1010600@xenomai.org>
 <CAKk99t14auR=Ez-9k6bSxDQt5iNbTjvYtxeaAyGzMPuwQi_nnQ@mail.gmail.com>
In-Reply-To: <CAKk99t14auR=Ez-9k6bSxDQt5iNbTjvYtxeaAyGzMPuwQi_nnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Helder Daniel <hdaniel@ualg.pt>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 03/04/2015 04:26 PM, Helder Daniel wrote:
> I reinstall xenomai enabling debug support:
> 
> /usr/xenomai/sbin/version -a
> Xenomai/mercury v3.0-rc3 -- 
> Target: i686-pc-linux-gnu
> Compiler: gcc version 4.7.2 (Debian 4.7.2-5) 
> Build args:  '--with-core=mercury' '--enable-registry'
> '--enable-pshared' '--prefix=/usr/xenomai' '--enable-debug'
>

Looks good.

> Then I removed all the code from the second process (binder.c), now
> main() its empty.
> 
> Running binder.c while creator.c is running, still gives a segmentation
> fault.
> 
> Since now there is no code in binder.c I compile it with no Xenomai
> support, just gcc binder.c -o binder.
> This way it runs (of course does nothing) without segmentation fault.
> 
> So it must be something in the initialization of the Xenomai app.

Ack.

> And only happens when another Xenomai app (creator.c) is running.
>

In shared mode, it seems.

> I did not backtrace it with gdbg yet, but I recompile it (main() still
> empty) with Xenomai support and make an strace -f (while creator.c is
> still running).

gdb will pinpoint the exact location of this fault.

> It seems that the segmentation fault happens when trying to lock memory
> pages in RAM (called by the initialization code):
> 
> [pid  3907] mlockall(MCL_CURRENT|MCL_FUTURE) = 0
> [pid  3907] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> [pid  3908] +++ killed by SIGSEGV +++
> [pid  3909] +++ killed by SIGSEGV +++

strace only reports system calls, with mlockall returning a success
status, so the segfault happens later.

I'll build your test case and dig this issue tomorrow. Thanks for your
patient reports, this will help fixing up the rough edges.

-- 
Philippe.

