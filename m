Message-ID: <5505B14F.4060107@xenomai.org>
Date: Sun, 15 Mar 2015 17:20:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>	<54F5D6C6.40908@xenomai.org>	<CAKk99t13XsRYBA15ws6ZbUsrqe5+b7D1xRM5NGKrUkvrLJWPCw@mail.gmail.com>	<54F5E958.2090701@xenomai.org>	<54F5EA06.4040104@xenomai.org>	<CAKk99t1DtxOFmTpf2ZgJ2coh_tNqMPY4VX0pAdEJZB6oGvko3g@mail.gmail.com>	<54F60A62.3020708@xenomai.org>	<54F60C16.5070500@xenomai.org>	<CAKk99t0qwyG2wuMAvQ7U-Ed_AR7jJ3vK=Ok4dK5kLj1VbrvxUg@mail.gmail.com>	<54F614EF.7040307@xenomai.org>	<CAKk99t0Xh01uxG7jd=oEDD71LBHvTnbCnejwiP2bzGN63Yo-ZA@mail.gmail.com>	<54F6C50F.5040301@xenomai.org>	<CAKk99t1LaQg9HJkXuiXbi09Mhr5H2EXqcmHw5PPTN4=V7mT3Dg@mail.gmail.com>	<54F6EF2E.1090705@xenomai.org>	<CAKk99t3K=+Eo+Z_+nPEgi6FNWzg8gigZGfMnVW3Ap+XkVb5aTg@mail.gmail.com>	<54F716CC.1010600@xenomai.org>	<CAKk99t14auR=Ez-9k6bSxDQt5iNbTjvYtxeaAyGzMPuwQi_nnQ@mail.gmail.com>	<54F73E7A.2070100@xenomai.org>
 <CAKk99t0z4Tq==LTzFK_9cmbrDTZ+RFt2vo=ur56VbVG3sso_iQ@mail.gmail.com>
In-Reply-To: <CAKk99t0z4Tq==LTzFK_9cmbrDTZ+RFt2vo=ur56VbVG3sso_iQ@mail.gmail.com>
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

On 03/05/2015 12:30 AM, Helder Daniel wrote:
> ok.
> Here is the backtrace of "binder" process with gdb:
>

<snip>

> Program received signal SIGSEGV, Segmentation fault.
> 0xb76cdc10 in ?? ()
> (gdb) bt
> #0  0xb76cdc10 in ?? ()
> #1  0xb7fafa29 in hash_search (t=0xb7cd9110, key=key@entry=0xb7fca217,
> len=12)
>     at hash.c:193
> #2  0xb7fa5015 in cluster_init (c=c@entry=0xb7fcddfc, 
>     name=name@entry=0xb7fca217 "alchemy.task") at cluster.c:118
> #3  0xb7fa526a in syncluster_init (sc=0xb7fcddfc, 
>     name=name@entry=0xb7fca217 "alchemy.task") at cluster.c:214
> #4  0xb7fc25c9 in alchemy_init () at init.c:102
> #5  0xb7fa6ea3 in copperplate_init (argcp=argcp@entry=0xbffffc10, 
>     argvp=argvp@entry=0xbffffc14) at init.c:635
> #6  0xb7fa75d3 in copperplate_main (argc=1, argv=0xbffffcb4) at main.c:27
> #7  0xb7df8e46 in __libc_start_main ()
>    from /lib/i386-linux-gnu/i686/cmov/libc.so.6
> #8  0x080484f1 in _start ()
> (gdb) 
> 
> 

This is now fixed in -next branch, will be part of -rc4.

-- 
Philippe.

