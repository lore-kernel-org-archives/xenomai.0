MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <54F73E7A.2070100@xenomai.org>
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
 <54F5CD4D.8080004@xenomai.org>
 <CAKk99t22fhrbc0GwURNJjdUfVfwmBvVyAWYYArVMgJfh4_JF+Q@mail.gmail.com>
 <54F5D6C6.40908@xenomai.org>
 <CAKk99t13XsRYBA15ws6ZbUsrqe5+b7D1xRM5NGKrUkvrLJWPCw@mail.gmail.com>
 <54F5E958.2090701@xenomai.org> <54F5EA06.4040104@xenomai.org>
 <CAKk99t1DtxOFmTpf2ZgJ2coh_tNqMPY4VX0pAdEJZB6oGvko3g@mail.gmail.com>
 <54F60A62.3020708@xenomai.org> <54F60C16.5070500@xenomai.org>
 <CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>
 <54F614EF.7040307@xenomai.org>
 <CAKk99t0Xh01uxG7jd=oEDD71LBHvTnbCnejwiP2bzGN63Yo-ZA@mail.gmail.com>
 <54F6C50F.5040301@xenomai.org>
 <CAKk99t1LaQg9HJkXuiXbi09Mhr5H2EXqcmHw5PPTN4=V7mT3Dg@mail.gmail.com>
 <54F6EF2E.1090705@xenomai.org>
 <CAKk99t3K=+Eo+Z_+nPEgi6FNWzg8gigZGfMnVW3Ap+XkVb5aTg@mail.gmail.com>
 <54F716CC.1010600@xenomai.org>
 <CAKk99t14auR=Ez-9k6bSxDQt5iNbTjvYtxeaAyGzMPuwQi_nnQ@mail.gmail.com>
 <54F73E7A.2070100@xenomai.org>
Date: Wed, 4 Mar 2015 23:30:47 +0000
Message-ID: <CAKk99t0z4Tq==LTzFK_9cmbrDTZ+RFt2vo=ur56VbVG3sso_iQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

ok.
Here is the backtrace of "binder" process with gdb:

root@debian:~/xenomaiRegistryCheck# gdb binder
GNU gdb (GDB) 7.4.1-debian
Copyright (C) 2012 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html
>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i486-linux-gnu".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /root/xenomaiRegistryCheck/binder...done.
(gdb) r
Starting program: /root/xenomaiRegistryCheck/binder
[Thread debugging using libthread_db enabled]
Using host libthread_db library
"/lib/i386-linux-gnu/i686/cmov/libthread_db.so.1".
[New Thread 0xb7fdeb70 (LWP 4409)]
[New Thread 0xb7cb5b70 (LWP 4410)]

Program received signal SIGSEGV, Segmentation fault.
0xb76cdc10 in ?? ()
(gdb) bt
#0  0xb76cdc10 in ?? ()
#1  0xb7fafa29 in hash_search (t=0xb7cd9110, key=key@entry=0xb7fca217,
len=12)
    at hash.c:193
#2  0xb7fa5015 in cluster_init (c=c@entry=0xb7fcddfc,
    name=name@entry=0xb7fca217 "alchemy.task") at cluster.c:118
#3  0xb7fa526a in syncluster_init (sc=0xb7fcddfc,
    name=name@entry=0xb7fca217 "alchemy.task") at cluster.c:214
#4  0xb7fc25c9 in alchemy_init () at init.c:102
#5  0xb7fa6ea3 in copperplate_init (argcp=argcp@entry=0xbffffc10,
    argvp=argvp@entry=0xbffffc14) at init.c:635
#6  0xb7fa75d3 in copperplate_main (argc=1, argv=0xbffffcb4) at main.c:27
#7  0xb7df8e46 in __libc_start_main ()
   from /lib/i386-linux-gnu/i686/cmov/libc.so.6
#8  0x080484f1 in _start ()
(gdb)




On 4 March 2015 at 17:18, Philippe Gerum <rpm@xenomai.org> wrote:

> On 03/04/2015 04:26 PM, Helder Daniel wrote:
> > I reinstall xenomai enabling debug support:
> >
> > /usr/xenomai/sbin/version -a
> > Xenomai/mercury v3.0-rc3 --
> > Target: i686-pc-linux-gnu
> > Compiler: gcc version 4.7.2 (Debian 4.7.2-5)
> > Build args:  '--with-core=mercury' '--enable-registry'
> > '--enable-pshared' '--prefix=/usr/xenomai' '--enable-debug'
> >
>
> Looks good.
>
> > Then I removed all the code from the second process (binder.c), now
> > main() its empty.
> >
> > Running binder.c while creator.c is running, still gives a segmentation
> > fault.
> >
> > Since now there is no code in binder.c I compile it with no Xenomai
> > support, just gcc binder.c -o binder.
> > This way it runs (of course does nothing) without segmentation fault.
> >
> > So it must be something in the initialization of the Xenomai app.
>
> Ack.
>
> > And only happens when another Xenomai app (creator.c) is running.
> >
>
> In shared mode, it seems.
>
> > I did not backtrace it with gdbg yet, but I recompile it (main() still
> > empty) with Xenomai support and make an strace -f (while creator.c is
> > still running).
>
> gdb will pinpoint the exact location of this fault.
>
> > It seems that the segmentation fault happens when trying to lock memory
> > pages in RAM (called by the initialization code):
> >
> > [pid  3907] mlockall(MCL_CURRENT|MCL_FUTURE) = 0
> > [pid  3907] --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> > [pid  3908] +++ killed by SIGSEGV +++
> > [pid  3909] +++ killed by SIGSEGV +++
>
> strace only reports system calls, with mlockall returning a success
> status, so the segfault happens later.
>
> I'll build your test case and dig this issue tomorrow. Thanks for your
> patient reports, this will help fixing up the rough edges.
>
> --
> Philippe.
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
