Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Problem building MVM: "error: The X11 library
	'-lX11' could not be found"
Date: Thu, 1 Dec 2005 14:34:18 +0200
Message-ID: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFDE3@domain.hid>
From: "Ashri, Sarit" <Sashri@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

>=20
> Ashri, Sarit wrote:
> > Hi Philippe,
> >=20
> > I did read the files. What I don't understand is how to build the=20
> > Xenomai With Simulator support?
> > When I build Xenomai without simulator support - everything=20
> works just=20
> > fine (crossed compiled to work on PPC with Linux 2.6.13.4).
> > As soon as I mark Simulator->Minute Virtual Machine I get that error
> > (X11 library..).
> > I understood from reading previous mails on the internet=20
> that I should=20
> > be able to build the MVM on my host computer which is NOT=20
> patched by=20
> > Adeos (RHEL3.0 Linux on i686) through Regular Xenomai=20
> CROSS_COMPILING=20
> > and installation.
>=20
> Try this:
>=20
> - Build your target system first without the simulator using=20
> cross-compilation for ppc. Let's say that you installed the=20
> results under /usr/realtime, which is the default.
>=20
> - Then, build the simulator separately for the host:
>=20
> $ mkdir sim-build && cd sim-build
> $ .../xenomai/sim/configure --with-xeno-dir=3D/usr/realtime
> --with-gcc-tarball=3D/something/gcc-2.95.3.tar.bz2
> $ make install
>=20
Everything compiled fine, but when I tried to compile the native demo
for the
Simulator I received the following error:
cd .../skins/native/demos
[demos]$ /usr/realtime/bin/gcic -o satch_s.o -c satch.c -g -I
/opt/nfs_root/usr/realtime/include
In file included from
/opt/nfs_root/usr/realtime/include/nucleus/asm/atomic.h:23,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/system.h:33,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/asm-generic/system.h:560,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/asm/system.h:23,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/types.h:40,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/queue.h:23,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:23,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:23,
                 from
/opt/nfs_root/usr/realtime/include/native/task.h:26,
                 from satch.c:4:
/usr/include/asm/atomic.h:40: warning: #warning Using kernel header in
userland program. BAD!
In file included from
/opt/nfs_root/usr/realtime/include/nucleus/system.h:33,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/asm-generic/system.h:560,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/asm/system.h:23,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/types.h:40,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/queue.h:23,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:23,
                 from
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:23,
                 from
/opt/nfs_root/usr/realtime/include/native/task.h:26,
                 from satch.c:4:
/opt/nfs_root/usr/realtime/include/nucleus/asm/atomic.h: In function
`atomic_set_mask':
/opt/nfs_root/usr/realtime/include/nucleus/asm/atomic.h:191: unknown
register name `r5' in `asm'
/opt/nfs_root/usr/realtime/include/nucleus/asm/atomic.h: In function
`atomic_clear_mask':
/opt/nfs_root/usr/realtime/include/nucleus/asm/atomic.h:205: unknown
register name `r5' in `asm'
In file included from
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:23,
                 from
/opt/nfs_root/usr/realtime/include/native/task.h:26,
                 from satch.c:4:
/opt/nfs_root/usr/realtime/include/nucleus/timer.h: At top level:
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:79: syntax error
before `XNARCH_DECL_DISPLAY_CONTEXT'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:79: warning: no
semicolon at end of struct or union
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:81: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:93: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h: In function
`xntimer_active_p':
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:94: `timer'
undeclared (first use in this function)
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:94: (Each undeclared
identifier is reported only once
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:94: for each function
it appears in.)
/opt/nfs_root/usr/realtime/include/nucleus/timer.h: At top level:
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:97: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h: In function
`xntimer_running_p':
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:98: `timer'
undeclared (first use in this function)
/opt/nfs_root/usr/realtime/include/nucleus/timer.h: At top level:
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:105: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:108: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:109: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:110: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:111: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:122: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:123: `xntimer_init'
declared as function returning a function
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:124: syntax error
before `void'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:126: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:128: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:155: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h: In function
`xntimer_stop':
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:157: `timer'
undeclared (first use in this function)
/opt/nfs_root/usr/realtime/include/nucleus/timer.h: At top level:
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:163: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/timer.h:165: syntax error
before `*'
In file included from
/opt/nfs_root/usr/realtime/include/native/task.h:26,
                 from satch.c:4:
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:106: syntax error
before `xnarchtcb_t'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:106: warning: no
semicolon at end of struct or union
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:112: syntax error
before `affinity'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:112: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:134: syntax error
before `rtimer'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:134: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:136: syntax error
before `ptimer'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:136: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:182: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:184: syntax error
before `}'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:184: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:197: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:243: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:249: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:253: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/thread.h: In function
`xnthread_get_timeout':
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:257: `thread'
undeclared (first use in this function)
/opt/nfs_root/usr/realtime/include/nucleus/thread.h:262: `now'
undeclared (first use in this function)
In file included from
/opt/nfs_root/usr/realtime/include/native/task.h:27,
                 from satch.c:4:
/opt/nfs_root/usr/realtime/include/nucleus/synch.h: At top level:
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:67: syntax error
before `XNARCH_DECL_DISPLAY_CONTEXT'
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:67: warning: no
semicolon at end of struct or union
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:69: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:82: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:88: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/synch.h: In function
`xnsynch_set_owner':
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:89: `synch'
undeclared (first use in this function)
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:89: `thread'
undeclared (first use in this function)
/opt/nfs_root/usr/realtime/include/nucleus/synch.h: At top level:
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:92: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:95: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:97: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:100: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/synch.h:109: syntax error
before `*'
In file included from satch.c:4:
/opt/nfs_root/usr/realtime/include/native/task.h:110: syntax error
before `xntimer_t'
/opt/nfs_root/usr/realtime/include/native/task.h:110: warning: no
semicolon at end of struct or union
/opt/nfs_root/usr/realtime/include/native/task.h:112: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/native/task.h:120: syntax error
before `affinity'
/opt/nfs_root/usr/realtime/include/native/task.h:120: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/native/task.h:150: syntax error
before `mrecv'
/opt/nfs_root/usr/realtime/include/native/task.h:151: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/native/task.h:156: syntax error
before `}'
/opt/nfs_root/usr/realtime/include/native/task.h:156: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/native/task.h:158: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:158: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h: In function
`thread2rtask':
/opt/nfs_root/usr/realtime/include/native/task.h:160: `t' undeclared
(first use in this function)
/opt/nfs_root/usr/realtime/include/native/task.h:160: syntax error
before `)'
/opt/nfs_root/usr/realtime/include/native/task.h:160: syntax error
before `)'
/opt/nfs_root/usr/realtime/include/native/task.h: At top level:
/opt/nfs_root/usr/realtime/include/native/task.h:221: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:227: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:228: `rt_task_start'
declared as function returning a function
/opt/nfs_root/usr/realtime/include/native/task.h:229: syntax error
before `void'
/opt/nfs_root/usr/realtime/include/native/task.h:231: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:233: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:235: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:239: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:245: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:252: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:254: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:259: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:266: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:266: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/native/task.h:268: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:273: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:286: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/task.h:291: `rt_task_spawn'
declared as function returning a function
/opt/nfs_root/usr/realtime/include/native/task.h:292: syntax error
before `void'
In file included from
/opt/nfs_root/usr/realtime/include/native/queue.h:26,
                 from satch.c:5:
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:98: syntax error
before `xnarch_heapcb_t'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:98: warning: no
semicolon at end of struct or union
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:100: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:102: syntax error
before `}'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:102: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:104: syntax error
before `kheap'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:104: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:156: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:161: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:162: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:165: `xnheap_destroy'
declared as function returning a function
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:168: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:172: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:175: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:177: syntax error
before `)'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:179: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:182: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:186: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:188: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/nucleus/heap.h: In function
`xnheap_finalize_free':
/opt/nfs_root/usr/realtime/include/nucleus/heap.h:190: `heap' undeclared
(first use in this function)
In file included from satch.c:5:
/opt/nfs_root/usr/realtime/include/native/queue.h: At top level:
/opt/nfs_root/usr/realtime/include/native/queue.h:78: syntax error
before `xnsynch_t'
/opt/nfs_root/usr/realtime/include/native/queue.h:78: warning: no
semicolon at end of struct or union
/opt/nfs_root/usr/realtime/include/native/queue.h:82: syntax error
before `bufpool'
/opt/nfs_root/usr/realtime/include/native/queue.h:82: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/native/queue.h:96: syntax error
before `}'
/opt/nfs_root/usr/realtime/include/native/queue.h:96: warning: data
definition has no type or storage class
/opt/nfs_root/usr/realtime/include/native/queue.h:149: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/queue.h:155: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/queue.h:157: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/queue.h:160: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/queue.h:163: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/queue.h:168: syntax error
before `*'
/opt/nfs_root/usr/realtime/include/native/queue.h:172: syntax error
before `*'
satch.c:37: syntax error before `producer_task'
satch.c:38: warning: data definition has no type or storage class


>=20
> Philippe.
>=20

Thanks a lot for you help,
Sarit.
*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

