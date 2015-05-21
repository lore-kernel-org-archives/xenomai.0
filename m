From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Thu, 21 May 2015 16:48:56 -0400
Message-ID: <20150521204856.GV6169@csclub.uwaterloo.ca>
References: <20150521221811.1cc69dcd@crunchbang>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150521221811.1cc69dcd@crunchbang>
Subject: Re: [Xenomai] Raspberry Pi + Xenomai doesn't compile
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Marc =?utf-8?B?TWFyw60=?= <5.markmb.5@gmail.com>
Cc: xenomai@xenomai.org

On Thu, May 21, 2015 at 10:18:11PM +0200, Marc Marí wrote:
> Hello
> 
> I'm trying to put Xenomai 2.6.4 on top of a Raspberry Pi model B with
> kernel version 3.8.13. In theory, it should be straightforward, but I
> don't get it to compile, and I don't know if I'm missing something
> vital or something is broken.
> 
> This is what I executed:
> 
> $ git clone git@github.com:raspberrypi/linux.git
> $ mv linux rpi-xenomai
> $ git checkout rpi-3.8.y
> $ patch -p1 -i \
> ../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberry-pre-2.patch
> $ ../xenomai-2.6.4/scripts/prepare-kernel.sh --arch=arm --linux=./ \
> --adeos=../xenomai-2.6.4/ksrc/arch/arm/patches/ipipe-core-3.8.13-arm-4.patch
> $ patch -p1 -i \
> ../xenomai-2.6.4/ksrc/arch/arm/patches/raspberry/ipipe-core-3.8.13-raspberry-post-2.patch
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcmrpi_defconfig
> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> 
> I get this output:
> 
> kernel/ipipe/core.c: In function ‘ipipe_probe_kernel_read’:
> kernel/ipipe/core.c:1748:2: error: implicit declaration of function
> ‘get_fs’ [-Werror=implicit-function-declaration]
>   mm_segment_t old_fs = get_fs();
>   ^
> kernel/ipipe/core.c:1750:2: error: implicit declaration of function
> ‘set_fs’ [-Werror=implicit-function-declaration]
>   set_fs(KERNEL_DS);
>   ^
> kernel/ipipe/core.c:1750:9: error: ‘KERNEL_DS’ undeclared (first use in
> this function)
>   set_fs(KERNEL_DS);
>          ^
> kernel/ipipe/core.c:1750:9: note: each undeclared identifier is
> reported only once for each function it appears in
> kernel/ipipe/core.c:1753:2: error: implicit declaration of function
> ‘__copy_from_user_inatomic’ [-Werror=implicit-function-declaration]
>   ret = __copy_from_user_inatomic(dst,
>   ^
> kernel/ipipe/core.c: In function ‘ipipe_probe_kernel_write’:
> kernel/ipipe/core.c:1767:9: error: ‘KERNEL_DS’ undeclared (first use in
> this function)
>   set_fs(KERNEL_DS);
>          ^
> kernel/ipipe/core.c:1770:2: error: implicit declaration of function
> ‘__copy_to_user_inatomic’ [-Werror=implicit-function-declaration]
>   ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);
>   ^
> cc1: some warnings being treated as errors
> scripts/Makefile.build:307: recipe for target 'kernel/ipipe/core.o'
> failed
> make[2]: *** [kernel/ipipe/core.o] Error 1
> scripts/Makefile.build:454: recipe for target 'kernel/ipipe' failed
> make[1]: *** [kernel/ipipe] Error 2
> Makefile:791: recipe for target 'kernel' failed
> make: *** [kernel] Error 2
> 
> 
> I tried by including asm/uaccess.h, which solved the issue. But the
> kernel doesn't boot, and there is no message. It just hangs.
> 
> I tried the same kernel without Xenomai patch, and it compiles and
> boots without problem.

Did you enable IPIPE in the config?  After all bcmrpi_defconfig probably
does NOT include IPIPE config, and most releases of ipipe don't compile
if you disable IPIPE support.  I have only ever seen recent versions
actually be able to compile with CONFIG_IPIPE=n.

-- 
Len Sorensen

