Message-ID: <48E4DB02.4000801@domain.hid>
Date: Thu, 02 Oct 2008 16:30:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48E4A6C3.3080508@domain.hid> <48E4B927.6010706@domain.hid>
	<48E4D3A6.5010401@domain.hid>
In-Reply-To: <48E4D3A6.5010401@domain.hid>
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
Cc: Xenomai help <xenomai@xenomai.org>

Malek wrote:

Hi Malek, please do not drop the list from CC.

>    $ ./configure --target=i686-linux --host=i686-linux --build=i386-pc-linux-gnu 
> --prefix=/usr --exec-prefix=/usr --sysconfdir=/etc --prefix=/usr/xenomai 
> --disable-smp --disable-x86-sep --enable-x86-tsc
> ====================================================================
> (...)
> The architecture of the host is x86 under (cross)uClibc (0.9.29), (cross)GCC: 4.2.4,
> (cross)binutils 2.18.50.0.1, Xenomai 2.4.5.

So, you are compiling on x86 for x86 ? You are not cross-compiling then.

If your host is x86_64 and you are compiling for x86_32, you should pass
the -m32 option to gcc.

Now, line 98 in shm.c is a syscall macro invocation, so there should be
no reason that it works for other skin and does not work for the posix skin.

Please show us a non truncated error message, and if possible the result
of pre-processing shm.c.

>>> ead_rt_la-shm.lo -MD -MP -MF .deps/libpthread_rt_la-shm.Tpo -c shm.c
 -fPIC
>>> >>> -DPIC -o .libs/libpthread_rt_la-shm.o
>>> >>> shm.c: In function '__wrap_mmap':
>>> >>> shm.c:98: error: impossible register constraint in 'asm'
>>> >>> shm.c:98: error: impossible register constraint in 'asm'
>>> >>> shm.c:98: error: impossible register constraint in 'asm'
>>> >>> make[4]: *** [libpthread_rt_la-shm.lo] Erreur 1

Also, what are the CFLAGS, CPPFLAGS, LDFLAGS passed to gcc ? I think I
know what the problem is: are you compiling with LFS options ? In this
case off_t is 64 bits, and passing it in a 32 bits variable can not work.

It should not bee too hard to fix, and since LFS has been the default
for a long time, we should really fix this.

-- 
                                                 Gilles.


