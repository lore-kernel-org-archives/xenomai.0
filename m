Message-ID: <4D860E5D.90102@domain.hid>
Date: Sun, 20 Mar 2011 15:25:33 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.25.1300532408.23962.xenomai@xenomai.org>	<AANLkTimXw7wO=JzNNHDVtY_86R1qxLZjexVatmMPjoKw@domain.hid>	<AANLkTin5j_zFQbzb6gh5uq_eETGh3wQO+pc+L87_nr7H@mail.gmail.com>	<4D860094.6060304@domain.hid>
	<AANLkTikvuJTDc4JwxU_6BE3QUOVfWAYwkrB6Q-2wWpSH@mail.gmail.com>
In-Reply-To: <AANLkTikvuJTDc4JwxU_6BE3QUOVfWAYwkrB6Q-2wWpSH@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai-core Digest, Vol 66, Issue 9
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: alamo hwuang <lovealamo@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

alamo hwuang wrote:
> Hi gilles,
> 
> the toolchain of building xenomai and kernel is gcc 4.3.4.
> 
> linux-xkps1:~/Desktop # gcc -v
> Using built-in specs.
> Target: x86_64-suse-linux
> Configured with: ../configure --prefix=/usr --infodir=/usr/share/info
> --mandir=/usr/share/man --libdir=/usr/lib64 --libexecdir=/usr/lib64
> --enable-languages=c,c++,objc,fortran,obj-c++,java,ada
> --enable-checking=release --with-gxx-include-dir=/usr/include/c++/4.3
> --enable-ssp --disable-libssp
> --with-bugurl=http://bugs.opensuse.org/--with-pkgversion='SUSE Linux'
> --disable-libgcj --disable-libmudflap
> --with-slibdir=/lib64 --with-system-zlib --enable-__cxa_atexit
> --enable-libstdcxx-allocator=new --disable-libstdcxx-pch
> --enable-version-specific-runtime-libs --program-suffix=-4.3
> --enable-linux-futex --without-system-libunwind --with-cpu=generic
> --build=x86_64-suse-linux
> Thread model: posix
> gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux)
>  My application is building by icc 11-072.
> 
> The latency is just like below.

Ok. So latency works, the problem is in the application. If you are not
compiling the application with gcc, try using gcc. If it still does not
work, try and reduce the application to a simple test case exhibiting
the issue you are seeing, then post this test case here.

-- 
                                                                Gilles.

