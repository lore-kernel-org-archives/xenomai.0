Message-ID: <455993F2.4080609@domain.hid>
Date: Tue, 14 Nov 2006 11:01:22 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH]Build xenomai on Blackfin in FDPIC format
References: <4546494d0611131932q480046e0vfa092f4eaa15f7b5@domain.hid>
In-Reply-To: <4546494d0611131932q480046e0vfa092f4eaa15f7b5@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Li Yi (Adam)" <liyiadam@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Li Yi (Adam) wrote:
> Hi Philippe,
> 
> Since bfin-gcc release 2006-R1, bfin-gcc begins to support "FDPIC"
> format besides "BFLT".
> "FDPIC" supports shared library. Bellow patch makes it possible to build
> xenomai-2.2.5 in FDPIC
> format. In docs.blackfin.uclinux.org/doku.php?id=adeos
> <http://docs.blackfin.uclinux.org/doku.php?id=adeos> there is step by
> step guide.
> 
> Although it is still possible to build xenomai as BFLT in this way:
> 
> configure --host=bfin CC=bfin-uclinux-gcc LDFLAGS=-Wl,-elf2flt
> --disable-shared
> 
> There will be error:
> 
>  bfin-uclinux-gcc -Wl,-elf2flt -o cyclictest
> -Wl,@/home/adam/workspace/xenomai/xenomai_src/xenomai-
> 2.2.5/src/skins/posix/posix.wrappers cyclictest-cyclictest.o 
> ../../skins/posix/.libs/libpthread_rt.a -lpthread -lrt
> /home/adam/workspace/toolchain/1110/bfin-uclinux/bin/../lib/gcc/bfin-uclinux/4.1.1/../../../../bfin-uclinux/lib/libpthread.a(
> specific.o): In function `_pthread_key_delete':
> (.text+0x24e): undefined reference to `___wrap_pthread_mutex_lock'
> /home/adam/workspace/toolchain/1110/bfin-uclinux/bin/../lib/gcc/bfin-uclinux/4.1.1/../../../../bfin-uclinux/lib/libpthread.a(
> specific.o): In function `_pthread_key_delete':
> 
> And this can be fixed like:
> 
> bfin-uclinux-gcc -Wl,-elf2flt -o cyclictest
> -Wl,@/home/adam/workspace/xenomai/xenomai_src/xenomai-2.2.5/src/skins/posix/posix.wrappers
> cyclictest-cyclictest.o -lpthread -lrt
> ../../skins/posix/.libs/libpthread_rt.a

This fix is incorrect. The correct way of linking is to do it in two steps:

bfin-uclinux-ld -r -o cyclictest.part
@/home/adam/workspace/xenomai/xenomai_src/xenomai-2.2.5/src/skins/posix/posix.wrappers
cyclictest-cyclictest.o ../../skins/posix/.libs/libpthread_rt.a

bfin-uclinux-gcc -Wl,-elf2flt -o cyclictest cyclictest.part -lpthread -lrt

-- 
                                                 Gilles Chanteperdrix

