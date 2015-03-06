MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Fri, 6 Mar 2015 09:28:31 +0000
Message-ID: <CAKk99t3_phHv3kUfCZcwr2bqTys3JPL3iaWACLjP+f1yoD_Nag@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Error boilerplate/wrappers.h no found trying to compile
 RTDM module on 3.x-rc3 cobalt
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I am trying to compile a simple RTDM driver that rtdm_printks a message
when IRQ 12 (PS2 mouse) is up.

It's a Debian 32 bit system on top of a 64 bit core 2 duo P8600 processor,
however I already installed g++multilib package which get me rid of other
related errors with missing libc versions.

I am using a Makefile that works for Xenomai 2.5.x series, but I get an
error: "boilerplate/wrappers.h: No such file or directory"
and lot's of other. (Complete list of errors is at the end).

The make file I am using is this:

obj-m +=3D intr.o

EXTRA_CFLAGS :=3D -I/usr/xenomai/include -I/usr/include

all:
make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) modules
clean:
make -C /lib/modules/$(shell uname -r)/build M=3D$(PWD) clean

Maybe I have the wrong dirs in the compiler include path?
If I just set include path as (removing /usr/include):

EXTRA_CFLAGS :=3D -I/usr/xenomai/include

I get just an error:

/usr/xenomai/include/rtdm/rtdm.h:23:19: fatal error: fcntl.h: No such file
or directory

but fcntl.h shouldn't be required only on userland?

May I am including an rtdm.h for user land?
I've found some rtdm.h files in xenomai install dir:

/usr/xenomai/include/trank/rtdm/rtdm.h
/usr/xenomai/include/rtdm/uapi/rtdm.h
/usr/xenomai/include/rtdm/rtdm.h

If so there is one just for kernel space?
I guess for user space is:
/usr/xenomai/include/rtdm/uapi/rtdm.h

for kernel:
/usr/xenomai/include/rtdm/rtdm.h

I am not sure why there is a version in trank?
/usr/xenomai/include/trank/rtdm/rtdm.h

I am including in the module <rtdm/rtdm.h>, so:
 /usr/xenomai/include/rtdm/rtdm.h

My Xenomai version is:

$> /usr/xenomai/sbin/version -a
Xenomai/cobalt v3.0-rc3 --
Target: i686-pc-linux-gnu
Compiler: gcc version 4.7.2 (Debian 4.7.2-5)
Build args:  '--with-core=3Dcobalt' '--enable-registry' '--enable-smp'
'--enable-pshared' '--prefix=3D/usr/xenomai'

Module source code is:

#include <linux/module.h> // Needed by all modules
#include <rtdm/rtdm.h>

#define IRQ 12
#define "PS2MouseIntRT"

rtdm_irq_t;

int irq_handler (rtdm_irq_t *irq_handle) {
rtdm_printk ("IQR12 occurred (RTDM handler)\n");
return RTDM_IRQ_HANDLED;
}

static int __init start(void) {
    //Requets IRQ
    return rtdm_irq_request(&intr, IRQ, irq_handler, 0, name, NULL);
}

static void __exit stop(void) {
    //frees IRQ
rtdm_irq_free (&intr);
}

module_init(start);
module_exit(stop);


Complete output of make file:

make
echo -I/usr/xenomai/include -I/usr/include
-I/usr/xenomai/include -I/usr/include
make -C /lib/modules/3.18.7-rt2/build M=3D/root/prg/01-rtdm_interrupt modul=
es
make[1]: Entering directory `/usr/src/linux-headers-3.18.7-rt2'
  CC [M]  /root/prg/01-rtdm_interrupt/intr.o
In file included from /usr/include/features.h:356:0,
                 from /usr/include/fcntl.h:27,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/sys/cdefs.h:287:0: warning: "__always_inline" redefined
[enabled by default]
In file included from include/linux/compiler.h:54:0,
                 from include/uapi/linux/stddef.h:1,
                 from include/linux/stddef.h:4,
                 from ./include/uapi/linux/posix_types.h:4,
                 from include/uapi/linux/types.h:13,
                 from include/linux/types.h:5,
                 from include/linux/list.h:4,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/compiler-gcc.h:118:0: note: this is the location of the
previous definition
In file included from /usr/include/bits/fcntl.h:25:0,
                 from /usr/include/fcntl.h:34,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/sys/types.h:61:17: error: conflicting types for =E2=80=98dev_t=
=E2=80=99
In file included from include/linux/list.h:4:0,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/types.h:15:25: note: previous declaration of =E2=80=98dev_t=
=E2=80=99 was here
In file included from /usr/include/bits/fcntl.h:25:0,
                 from /usr/include/fcntl.h:34,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/sys/types.h:71:18: error: conflicting types for =E2=80=98mode_=
t=E2=80=99
In file included from include/linux/list.h:4:0,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/types.h:17:26: note: previous declaration of =E2=80=98mode_t=
=E2=80=99 was here
In file included from /usr/include/sys/types.h:133:0,
                 from /usr/include/bits/fcntl.h:25,
                 from /usr/include/fcntl.h:34,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/time.h:104:19: error: conflicting types for =E2=80=98timer_t=
=E2=80=99
In file included from include/linux/list.h:4:0,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/types.h:25:26: note: previous declaration of =E2=80=98timer_t=
=E2=80=99 was
here
In file included from /usr/include/bits/fcntl.h:25:0,
                 from /usr/include/fcntl.h:34,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/sys/types.h:212:0: warning: "__BIT_TYPES_DEFINED__" redefined
[enabled by default]
In file included from include/linux/list.h:4:0,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/types.h:95:0: note: this is the location of the previous
definition
In file included from /usr/include/sys/select.h:44:0,
                 from /usr/include/sys/types.h:220,
                 from /usr/include/bits/fcntl.h:25,
                 from /usr/include/fcntl.h:34,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/time.h:120:8: error: redefinition of =E2=80=98struct timespec=
=E2=80=99
In file included from ./arch/x86/include/asm/preempt.h:6:0,
                 from include/linux/preempt.h:18,
                 from include/linux/spinlock.h:50,
                 from include/linux/seqlock.h:35,
                 from include/linux/time.h:5,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/thread_info.h:13:8: note: originally defined here
In file included from /usr/include/sys/select.h:46:0,
                 from /usr/include/sys/types.h:220,
                 from /usr/include/bits/fcntl.h:25,
                 from /usr/include/fcntl.h:34,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/bits/time.h:75:8: error: redefinition of =E2=80=98struct timev=
al=E2=80=99
In file included from include/linux/time64.h:4:0,
                 from include/linux/time.h:7,
                 from include/linux/stat.h:18,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/time.h:15:8: note: originally defined here
In file included from /usr/include/sys/types.h:220:0,
                 from /usr/include/bits/fcntl.h:25,
                 from /usr/include/fcntl.h:34,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/sys/select.h:78:5: error: conflicting types for =E2=80=98fd_se=
t=E2=80=99
In file included from include/linux/list.h:4:0,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/types.h:14:26: note: previous declaration of =E2=80=98fd_set=
=E2=80=99 was here
In file included from /usr/include/bits/fcntl.h:25:0,
                 from /usr/include/fcntl.h:34,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/sys/types.h:236:20: error: conflicting types for =E2=80=98blkc=
nt_t=E2=80=99
In file included from include/linux/list.h:4:0,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/types.h:131:13: note: previous declaration of =E2=80=98blkcnt=
_t=E2=80=99 was
here
In file included from /usr/include/fcntl.h:41:0,
                 from /usr/xenomai/include/rtdm/rtdm.h:23,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/bits/stat.h:46:8: error: redefinition of =E2=80=98struct stat=
=E2=80=99
In file included from include/linux/stat.h:5:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
./arch/x86/include/uapi/asm/stat.h:9:8: note: originally defined here
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:43:0: warning: "S_IFMT" redefined [enabled by default]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:7:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:44:0: warning: "S_IFDIR" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:12:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:45:0: warning: "S_IFCHR" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:13:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:46:0: warning: "S_IFBLK" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:11:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:47:0: warning: "S_IFREG" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:10:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:49:0: warning: "S_IFIFO" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:14:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:52:0: warning: "S_IFLNK" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:9:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:55:0: warning: "S_IFSOCK" redefined [enabled by
default]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:8:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:60:0: warning: "S_ISUID" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:15:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:61:0: warning: "S_ISGID" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:16:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:65:0: warning: "S_ISVTX" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:17:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:68:0: warning: "S_IRUSR" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:28:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:69:0: warning: "S_IWUSR" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:29:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:70:0: warning: "S_IXUSR" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:30:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:72:0: warning: "S_IRWXU" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:27:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:74:0: warning: "S_IRGRP" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:33:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:75:0: warning: "S_IWGRP" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:34:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:76:0: warning: "S_IXGRP" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:35:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:78:0: warning: "S_IRWXG" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:32:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:80:0: warning: "S_IROTH" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:38:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:81:0: warning: "S_IWOTH" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:39:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:82:0: warning: "S_IXOTH" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:40:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:23:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/fcntl.h:84:0: warning: "S_IRWXO" redefined [enabled by default=
]
In file included from include/linux/stat.h:6:0,
                 from include/linux/module.h:10,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/uapi/linux/stat.h:37:0: note: this is the location of the previous
definition
In file included from /usr/xenomai/include/rtdm/rtdm.h:25:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/stdint.h:129:23: error: conflicting types for =E2=80=98uintptr=
_t=E2=80=99
In file included from include/linux/list.h:4:0,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/types.h:36:24: note: previous declaration of =E2=80=98uintptr=
_t=E2=80=99 was
here
In file included from /usr/xenomai/include/rtdm/rtdm.h:25:0,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/stdint.h:268:0: warning: "SIZE_MAX" redefined [enabled by
default]
In file included from include/linux/list.h:8:0,
                 from include/linux/module.h:9,
                 from /root/prg/01-rtdm_interrupt/intr.c:1:
include/linux/kernel.h:30:0: note: this is the location of the previous
definition
In file included from /usr/include/sys/socket.h:40:0,
                 from /usr/xenomai/include/rtdm/rtdm.h:29,
                 from /root/prg/01-rtdm_interrupt/intr.c:3:
/usr/include/bits/socket.h:431:23: warning: =E2=80=98struct mmsghdr=E2=80=
=99 declared
inside parameter list [enabled by default]
/usr/include/bits/socket.h:431:23: warning: its scope is only this
definition or declaration, which is probably not what you want [enabled by
default]
In file included from /root/prg/01-rtdm_interrupt/intr.c:3:0:
/usr/xenomai/include/rtdm/rtdm.h:30:34: fatal error:
boilerplate/wrappers.h: No such file or directory
compilation terminated.
make[2]: *** [/root/prg/01-rtdm_interrupt/intr.o] Error 1
make[1]: *** [_module_/root/prg/01-rtdm_interrupt] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-3.18.7-rt2'
make: *** [all] Error 2
root@debian:~/prg/01-rtdm_interrupt#
