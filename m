Date: Tue, 12 Apr 2011 11:42:23 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110412094223.GA3006@domain.hid>
References: <20110409184122.GA11908@domain.hid>
	<20110409185503.GB11908@domain.hid>
	<4DA0B580.4070602@domain.hid> <4DA0B878.9010106@domain.hid>
	<20110410065250.GA28869@domain.hid>
	<4DA17996.3010103@domain.hid>
	<20110411171437.GA3715@domain.hid>
	<4DA37209.4000503@domain.hid>
	<20110412054348.GA2973@domain.hid>
	<4DA3FC97.10807@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DA3FC97.10807@domain.hid>
Subject: Re: [Xenomai-core] arm ixp: more trouble with recent xenomai
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Apr 12, 2011 at 09:17:43AM +0200, Gilles Chanteperdrix wrote:
> What compiler are you using by the way?

I compiled this one myself using crosstool-ng. At the time I had first
tried gcc 4.3, but you advised me that it would not work for xenomai.

Target: armeb-unknown-linux-gnueabi

Configured with:
/home/cochran/abul-gnueabi/targets/src/gcc-4.2.4/configure
--build=i486-build_pc-linux-gnu --host=i486-build_pc-linux-gnu
--target=armeb-unknown-linux-gnueabi
--prefix=/home/cochran/x-tools/armeb-unknown-linux-gnueabi
--with-sysroot=/home/cochran/x-tools/armeb-unknown-linux-gnueabi/armeb-unknown-linux-gnueabi//sys-root
--enable-languages=c,c++ --disable-multilib --with-arch=armv5te
--with-cpu=xscale --with-tune=xscale --with-float=soft
--with-gmp=/home/cochran/x-tools/armeb-unknown-linux-gnueabi
--with-mpfr=/home/cochran/x-tools/armeb-unknown-linux-gnueabi
--disable-sjlj-exceptions --enable-__cxa_atexit
--with-local-prefix=/home/cochran/x-tools/armeb-unknown-linux-gnueabi/armeb-unknown-linux-gnueabi//sys-root
--disable-nls --enable-threads=posix --enable-symvers=gnu --enable-c99
--enable-long-long --enable-target-optspace

Thread model: posix
gcc version 4.2.4

Thanks,

Richard

