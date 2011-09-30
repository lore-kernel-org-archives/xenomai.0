MIME-Version: 1.0
Sender: patrickdepinguin@domain.hid
Date: Fri, 30 Sep 2011 21:53:23 +0200
Message-ID: <CAAXf6LXwqMUOrmHQX4O6hk2ar95Sym8A9vu9MSBtjE4G6Sq0ag@domain.hid>
From: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] xenomai-forge: cast to pointer from integer of
	different size
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

Hi,

I'm trying to compile xenomai-forge on powerpc, but am facing
compilation problems:

libtool: compile:
/repo/tdescham/reborn/buildroot-08-eglibc-test-toolchain/output/host/usr/bin/powerpc-linux-gcc
-DHAVE_CONFIG_H -I. -I../../lib/include -O2 -D_GNU_SOURCE -D_REENTRANT
-Wall -pipe -Wstrict-prototypes -Wmissing-prototypes -Wno-long-long
-Wno-unused-parameter -Werror -D__XENO__ -D__IN_XENO__
-Wstrict-prototypes -I../../include -pipe -Os -D_LARGEFILE_SOURCE
-D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -MT
libcopperplate_la-cluster.lo -MD -MP -MF
.deps/libcopperplate_la-cluster.Tpo -c cluster.c  -fPIC -DPIC -o
.libs/libcopperplate_la-cluster.o
cc1: warnings being treated as errors
In file included from cluster.c:89:
../../include/copperplate/heapobj.h: In function 'mainheap_ptr':
../../include/copperplate/heapobj.h:82: error: cast to pointer from
integer of different size
../../include/copperplate/heapobj.h: In function 'mainheap_off':
../../include/copperplate/heapobj.h:87: error: cast from pointer to
integer of different size
cc1: warnings being treated as errors

The C library we are using for this build is eglibc.

The offending code is:
static inline void *mainheap_ptr(off_t off)
{
        return off ? (void *)__memptr(__pshared_heap, off) : NULL;
}

static inline off_t mainheap_off(void *addr)
{
        return addr ? (off_t)__memoff(__pshared_heap, addr) : 0;
}

Since glibc/eglibc has large file support, the size of off_t is 8
bytes (I confirmed this from the preprocessor output).
However, on this 32-bit powerpc platform, a void pointer is only 4
bytes, hence the compiler error.

Is my assumption correct that you are developing xenomai-forge on a
64-bit platform?

What is the proper solution here?

Thanks,
Thomas

