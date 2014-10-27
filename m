Date: Mon, 27 Oct 2014 14:31:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20141027133114.GB13005@sisyphus.hd.free.fr>
References: <314E5ECDAA86314791309FA670550F89C674EE64@SINTEFEXMBX05.sintef.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <314E5ECDAA86314791309FA670550F89C674EE64@SINTEFEXMBX05.sintef.no>
Subject: Re: [Xenomai] Compiling drivers for Xenomai 2.6.4 on Beaglebone
	Black
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Terje =?utf-8?Q?Fr=C3=B8ysa?= <Terje.Froysa@sintef.no>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Mon, Oct 27, 2014 at 01:21:00PM +0000, Terje Frøysa wrote:
> Dear Sirs,
> 
> I have successfully installed the Xenomai 2.6.4 on a Beaglebone Black (Linux 3.8.13-bone67) by following the these recipes :
> http://elinux.org/Talk:EBC_Xenomai
> http://elinux.org/EBC_Installing_Kernel_Source

Well, the official Xenomai installation instructions are here:
http://xenomai.org/installing-xenomai-2-x/

This is the only page we maintain and we know about.

> 
> I can run the latency and klatency tests without problems.
> The exercises from Nijmegen (http://www.cs.ru.nl/lab/xenomai/) compiles and runs nicely.

Again, this page is not maintained by us, we do not know if what it
contains compiles with Xenomai, and we do not particularly try to
avoid breaking the examples it contains.

> 
> My problem now is the lack of drivers under Xenomai. I found the
> following: https://github.com/nradulovic/xdrv-spi
> https://github.com/nradulovic/xdrv-16c750a According to README
> these drivers are designed for AM335X and Xenomai 2.6.2.1
> 
> The problem seem to be that the Makefiles stems from quite a different Xenomai environment.
> The ${LINUX_SRC} is not defined and the -Iinclude/xenomai does not exist.
> 
> Trying to mend this makes only the problems escalate.
> 
> Question:
> Is it possible to make these drivers comply with the Xenomai 2.6.4 environment on the BBB?

There should be no difference between 2.6.2.1 and 2.6.4 that could
break building drivers. I suspect the problem is rather that you
should pass the right variables to this driver Makefile to indicate
where you have the patched Linux kernel, or that this driver is
meant to be cross-compiled and you are trying to compile it on
target, or vice versa.

-- 
					    Gilles.

