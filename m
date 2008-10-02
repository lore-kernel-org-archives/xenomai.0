Message-ID: <48E4B927.6010706@domain.hid>
Date: Thu, 02 Oct 2008 14:05:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E4A6C3.3080508@domain.hid>
In-Reply-To: <48E4A6C3.3080508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] cross-compiling
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Malek <souf_oued@domain.hid>
Cc: xenomai@xenomai.org

Malek wrote:
> Hi all,
> 
> 1)
> I am newbe in Xenomai, i try to cross-compile xenomai using Buildroot, my 
> configuration is:
> Xenomai 2.4.5
> GCC 4.2.4
> uClibc 0.9.29
> Binutils 2.18.50.0.1
> Busybox
> 
> Xenomai: ./configure -disable-smp --disable-x86-sep --enable-x86-tsc

I do not understand what you mean, for cross-compiling, you should pass
a --host option to configure. If you do not pass a --host option, the
build machine compiler is used.

> 
> but every time I get this error:
> 
> ead_rt_la-shm.lo -MD -MP -MF .deps/libpthread_rt_la-shm.Tpo -c shm.c  -fPIC 
> -DPIC -o .libs/libpthread_rt_la-shm.o
> shm.c: In function '__wrap_mmap':
> shm.c:98: error: impossible register constraint in 'asm'
> shm.c:98: error: impossible register constraint in 'asm'
> shm.c:98: error: impossible register constraint in 'asm'
> make[4]: *** [libpthread_rt_la-shm.lo] Erreur 1
> 
> Is there a solution to this problem ?

Probably, but you do not give us enough information, what architecture
is your build machine ? What version of the compiler, etc...

> 
> 2)
> Is there an option to disable some skins (--disable-vxworks...) ?

No, it is useless, the compilation of Xenomai user-space support is
really fast, so, you simply have to not copy on your target the
libraries that you do not use.

-- 
                                                 Gilles.

