Message-ID: <517EF940.4030501@xenomai.org>
Date: Tue, 30 Apr 2013 00:50:40 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <A46EF8CF1BBB8E4B8A27B73E177C4664EFC670@MAIL-SINTERS-01.sinters-int.fr>,
	<517E5A11.7040206@xenomai.org>
	<A46EF8CF1BBB8E4B8A27B73E177C4664EFD6A3@MAIL-SINTERS-01.sinters-int.fr>
In-Reply-To: <A46EF8CF1BBB8E4B8A27B73E177C4664EFD6A3@MAIL-SINTERS-01.sinters-int.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RE : Xenomai : incompatible feature set (APF27)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Younes CHALABI <y.chalabi@sinters.fr>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/29/2013 04:10 PM, Younes CHALABI wrote:

> Hi,
> 
> Here is the display I had, when applying the --enable-arm-tsc option with "--enable-arm-tsc=imx" :
> 
> younes@younes-Latitude-E6530:~/APF27/armadeus-xeno0/buildroot/output/build/xenomai-2.6.2.1$ ./configure --enable-arm-tsc=imx
> checking build system type... i686-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu


Stop here, you are configuring for x86, --enable-arm-tsc is specific to
the ARM architecture.

What you have done at this point is prepared Xenomai compilation for
x86. Subsequent "make" command would generate binaries for the x86
architecture. So, I doubt you have done that and copied the files on
the target, else you would not have had the same error.

I suspect you have then re-started buildroot, hoping that the effect of
running configure would be kept. That is not the way it works, every
time you run configure, you override what was done before and re-create
a new build tree, and buildroot probably re-runs configure. So, in order
to add the --enable-arm-tsc on configure command line, you have to see
in buildroot menu if there is not an option, and add it if it not there.

To understand a bit more what is this "configure" script, I suggest you
read some documentation about the autotools. The classic reference is
the "autobook" (or goat book), available online:
http://sourceware.org/autobook/autobook/autobook.html

But it is a bit outdated, but chapter 3 is still relevant, and shows you
a bit more how it works.

At some point, I tried to write a tutorial for the autotools for my
co-workers, it may be outdated too, and maybe a bit too enthusiastic:
http://sisyphus.hd.free.fr/~gilles/pub/autotools/autotools.txt
The package files used as example are available in the same directory:
http://sisyphus.hd.free.fr/~gilles/pub/autotools/

-- 
                                                                Gilles.

