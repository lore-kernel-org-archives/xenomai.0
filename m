Message-ID: <46160D3D.8010703@domain.hid>
Date: Fri, 06 Apr 2007 11:05:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Error at compilation of examples
References: <17941.63222.407172.361683@domain.hid>
In-Reply-To: <17941.63222.407172.361683@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: Quoted-Printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Beno=EEt_CAMUS?= <benoit.camus@domain.hid>
Cc: xenomai@xenomai.org

Beno=EEt CAMUS wrote:
>>The most simple way to compile an example for Xenomai posix skin is to
>>use the xeno-config script as installed by Xenomai. If you have run
>>Xenomai installation with DESTDIR set, pass the same DESTDIR in
>>xeno-config environment. Examples usually come with Makefiles that do s=
o.
>=20
>=20
>>What version of Xenomai are you using ?
>=20
>=20
> I'm using xenomai last version (2.3.1),=20
> and have the same error using makefile with XENO parameter

I just tried compiling the examples and found two reasons why it might
not compile:
- the patched Linux kernel sources must have been compiled (so that the
include/asm symlink is created)
- if you are cross-compiling, you must pass the proper ARCH variable at
make invocation for compiling the kernel modules.

The last problem I have is the link order, but to solve this, I guess
the Makefiles should be changed.

Here is what I get:

make[1]: Entering directory
`/home/gcx/build/xenomai-examples/rtdm/profiles/serial'
gcc -m32 -I/usr/xenomai-2.3.1/include -D_GNU_SOURCE -D_REENTRANT
-L/usr/xenomai-2.3.1/lib -lpthread  -lnative -lrtdm -Xlinker -rpath
-Xlinker /usr/xenomai-2.3.1/lib  cross-link.c   -o cross-link
/tmp/ccQMPxBI.o(.text+0x19): In function `close_file':
cross-link.c: undefined reference to `rt_dev_close'
/tmp/ccQMPxBI.o(.text+0x5e):cross-link.c: undefined reference to
`rt_task_sleep'
/tmp/ccQMPxBI.o(.text+0x136): In function `cleanup_all':
cross-link.c: undefined reference to `rt_task_delete'
/tmp/ccQMPxBI.o(.text+0x169):cross-link.c: undefined reference to
`rt_task_delete'
/tmp/ccQMPxBI.o(.text+0x1bc): In function `write_task_proc':
cross-link.c: undefined reference to `rt_timer_ns2ticks'
/tmp/ccQMPxBI.o(.text+0x1e0):cross-link.c: undefined reference to
`rt_task_set_periodic'
/tmp/ccQMPxBI.o(.text+0x217):cross-link.c: undefined reference to
`rt_task_wait_period'
/tmp/ccQMPxBI.o(.text+0x244):cross-link.c: undefined reference to
`rt_timer_read'
/tmp/ccQMPxBI.o(.text+0x266):cross-link.c: undefined reference to
`rt_dev_write'
/tmp/ccQMPxBI.o(.text+0x372): In function `read_task_proc':
cross-link.c: undefined reference to `rt_dev_ioctl'
/tmp/ccQMPxBI.o(.text+0x3cb):cross-link.c: undefined reference to
`rt_dev_read'
/tmp/ccQMPxBI.o(.text+0x3df):cross-link.c: undefined reference to
`rt_timer_read'
/tmp/ccQMPxBI.o(.text+0x54e): In function `main':
cross-link.c: undefined reference to `rt_dev_open'
/tmp/ccQMPxBI.o(.text+0x5be):cross-link.c: undefined reference to
`rt_dev_ioctl'
/tmp/ccQMPxBI.o(.text+0x609):cross-link.c: undefined reference to
`rt_dev_open'
/tmp/ccQMPxBI.o(.text+0x679):cross-link.c: undefined reference to
`rt_dev_ioctl'
/tmp/ccQMPxBI.o(.text+0x6dc):cross-link.c: undefined reference to
`rt_task_create'
/tmp/ccQMPxBI.o(.text+0x74c):cross-link.c: undefined reference to
`rt_task_create'
/tmp/ccQMPxBI.o(.text+0x7b8):cross-link.c: undefined reference to
`rt_task_start'
/tmp/ccQMPxBI.o(.text+0x808):cross-link.c: undefined reference to
`rt_task_start'
collect2: ld returned 1 exit status
make[1]: *** [cross-link] Error 1

IMHO, the command line should be:
gcc -m32 -I/usr/xenomai-2.3.1/include -D_GNU_SOURCE -D_REENTRANT
cross-link.c  -L/usr/xenomai-2.3.1/lib -lpthread  -lnative -lrtdm
-Xlinker -rpath -Xlinker /usr/xenomai-2.3.1/lib  -o cross-link

--=20
                                                 Gilles Chanteperdrix

