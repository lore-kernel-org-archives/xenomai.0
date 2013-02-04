Message-ID: <51102316.9090107@xenomai.org>
Date: Mon, 04 Feb 2013 22:07:34 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <510FFDE0.4080703@icid.cu> <510FFE7C.1090601@xenomai.org>
	<51100A6B.90701@icid.cu> <5110122C.2090807@xenomai.org>
	<511021FC.7080906@icid.cu>
In-Reply-To: <511021FC.7080906@icid.cu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] about switchtest ...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: raespi <raespi@icid.cu>
Cc: Xenomai <xenomai@xenomai.org>

On 02/04/2013 10:02 PM, raespi wrote:

>  Right, I'm using these tools and options:
> 
> *- toolchain:*
> 4.6.3 (Sourcery CodeBench Lite 2012.03-57)
> 
> *- configure options ( Running under buildroot, no special recipe, it
> comes with one for the 2.6.0 version ):*
> $ ./configure --target=arm-linux --host=arm-linux
> --build=i686-pc-linux-gnu --prefix=/usr --exec-prefix=/usr
> --sysconfdir=/etc --program-prefix= --disable-gtk-doc --enable-ipv6
> --enable-static --enable-shared --includedir=/usr/include/xenomai/
> 
> *- Prepin' the kernel:*
> $(XENOMAI_DIR)/scripts/prepare-kernel.sh --linux=$(LINUX_DIR) --arch=arm
> --adeos=adeos-ipipe-3.1.10-arm-001.patch
> 
> I think I saw the problem.   Buildroot doesn't pass the " -march=armv4t
> -msoft-float"  CFLAGS and LDFLAGS options to the xenomai configure line
> for the s3c24xx.  At least the *xeno-test* is running now ...


Good news. It is strange that not passing these options does not cause
other run-time errors though (like invalid instructions).

> 
> Thanks for your time, are you interested in the complete patch for the
> 3.1.10 version ?? ...


Yes, that is interesting, but 3.1 is a bit old, I am not sure you have
all the fixes, any reason for not using 3.2?

Please keep the mailing list in CC.

-- 
                                                                Gilles.

