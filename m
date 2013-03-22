Message-ID: <514CC54F.5020008@xenomai.org>
Date: Fri, 22 Mar 2013 21:55:43 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <514C8FD5.90507@geomar.de>
In-Reply-To: <514C8FD5.90507@geomar.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Problems Crosscompiling for Foxboard G20
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mwollatz-vogt <mwollatz-vogt@geomar.de>
Cc: xenomai@xenomai.org

On 03/22/2013 06:07 PM, mwollatz-vogt wrote:

> Hi List,


Hi.

> 
> I?m following the howto
> http://www.federicololli.com/xenomaifoxg20.htm


This URL is unreachable.

> 
> i?m working with ubuntu 12 in a virtual-box. i downloaded
> linux-2.6.35.9 and patched it with Federico?s patch then i run make
> to compile the kernel. i got the uImage to get the armel-root i run
> the gen_root3.sh (btw. i had to change in gen_root3.sh the rep?s in
> archieve and also add mkdir etc and mkdir dev )
> 
> i installed xenomai-2.5.6 (this worked only after adding CFLAGS
> "-marm"


Xenomai 2.5.6 is outdated, please consider installing xenomai 2.6.2.1.

> so i run ./configure --host=arm-linux-gnueabi --enable-arm-eabi 
> --enable-arm-mach=at91sam89 --disable-arm-tsc *CFLAGS="-marm"*


It should be --enable-arm-mach=at91sam9g20, if you are using a 9g20.
Adding -marm should only be necessary for ompilers compiling by default
for thumb2 mode. If the compiler you use compiles by default for thumb2
mode, it is certainly not a recommended toolchain for at91sam9g20, as
this processor does not support thumb2 mode.

Passing --enable-arm-tsc will result in lower latencies when accessing
high resolution counter.

Finally, if you install xenomai 2.6.2.1, you will not need any of these
options, as the default should work (except for -marm). Note that
Xenomai 2.6.2.1 will run with any previous version of the I-pipe patch,
so should work with the I-pipe patch for 2.6.35, if you insist on using
this version, but newer versions should still support at91sam9g20, if
you are ready to try.

> and make DESTDIR=/ install now i got in /usr/xenomai the files


If you are not compiling on the sam9g20, make DESTDIR=/ is almost not
the right thing to do. DESTDIR should point to the place on your disk
where the rootfs for the target board is installed.

> 
> now i want to compile the examples so i followed the
> http://www.xenomai.org/index.php/Examples


That is not the first thing to do. The first thing to do is to run the
latency test by running "xeno latency" on the target.

> 
> *question:* how to crosscompile the examples?
> 
> i tried this:
> 
> DESTDIR=/ make XENO=/usr/xenomai ARCH=ARM
> KSRC=/home/martin/xenomai/xenomai-2.5.6/ksrc
> 
> and this:
> 
> DESTDIR=/ make XENO=/usr/xenomai ARCH=ARM
> CROSS_COMPILE=arm-none-linux
> KSRC=/home/martin/xenomai/xenomai-2.5.6/ksrc
> 
> it is compiling with errors :


The Examples are made for the current version of Xenomai, in order to
get them to compile with older versions, you may have to do some
adaptations to the Makefiles.

-- 
                                                                Gilles.

