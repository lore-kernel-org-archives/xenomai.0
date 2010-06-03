MIME-Version: 1.0
Date: Thu, 3 Jun 2010 14:28:52 -0400
Message-ID: <AANLkTilGfScF7HgA0za7_VQ_dbPeOc6ifGJ42n42XY_O@mail.gmail.com>
From: Yenan Zhu <yxz107@domain.hid>
Content-Type: multipart/alternative; boundary=000e0cd7080eea5e50048824602e
Subject: [Xenomai-help] RTXI installation issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--000e0cd7080eea5e50048824602e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

When trying to install RTXI (http://www.rtxi.org/) I get the following
error.

In file included from /usr/xenomai/include/nucleus/
trace.h:52,
                 from /usr/xenomai/include/nucleus/system.h:27,
                 from /usr/xenomai/include/asm/xenomai/system_32.h:130,
                 from /usr/xenomai/include/asm/xenomai/system.h:2,
                 from /usr/xenomai/include/nucleus/types.h:40,
                 from /usr/xenomai/include/nucleus/thread.h:25,
                 from /usr/xenomai/include/nucleus/sched.h:31,
                 from /usr/xenomai/include/native/task.h:25,
                 from ../src/rt_os-xenomai.cpp:25:
/usr/xenomai/include/asm/xenomai/syscall.h:42: error: field =91sigs=92 has
incomplete type
In file included from /usr/xenomai/include/nucleus/system.h:27,
                 from /usr/xenomai/include/asm/xenomai/system_32.h:130,
                 from /usr/xenomai/include/asm/xenomai/system.h:2,
                 from /usr/xenomai/include/nucleus/types.h:40,
                 from /usr/xenomai/include/nucleus/thread.h:25,
                 from /usr/xenomai/include/nucleus/sched.h:31,
                 from /usr/xenomai/include/native/task.h:25,
                 from ../src/rt_os-xenomai.cpp:25:
/usr/xenomai/include/nucleus/trace.h: In function =91int
xntrace_max_begin(long unsigned int)=92:
/usr/xenomai/include/nucleus/trace.h:56: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:56: error: =91__xn_sys_trace=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h:56: error: =91__xn_sys_mux=92 was not
declared in this scope
/usr/xenomai/include/nucleus/trace.h:56: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:56: error: =91xnsig_dispatch=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h: In function =91int xntrace_max_end(lo=
ng
unsigned int)=92:
/usr/xenomai/include/nucleus/trace.h:61: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:61: error: =91__xn_sys_trace=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h:61: error: =91__xn_sys_mux=92 was not
declared in this scope
/usr/xenomai/include/nucleus/trace.h:61: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:61: error: =91xnsig_dispatch=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h: In function =91int xntrace_max_reset(=
)=92:
/usr/xenomai/include/nucleus/trace.h:66: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:66: error: =91__xn_sys_trace=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h:66: error: =91__xn_sys_mux=92 was not
declared in this scope
/usr/xenomai/include/nucleus/trace.h:66: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:66: error: =91xnsig_dispatch=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h: In function =91int
xntrace_user_start()=92:
/usr/xenomai/include/nucleus/trace.h:71: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:71: error: =91__xn_sys_trace=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h:71: error: =91__xn_sys_mux=92 was not
declared in this scope
/usr/xenomai/include/nucleus/trace.h:71: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:71: error: =91xnsig_dispatch=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h: In function =91int
xntrace_user_stop(long unsigned int)=92:
/usr/xenomai/include/nucleus/trace.h:76: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:76: error: =91__xn_sys_trace=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h:76: error: =91__xn_sys_mux=92 was not
declared in this scope
/usr/xenomai/include/nucleus/trace.h:76: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:76: error: =91xnsig_dispatch=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h: In function =91int
xntrace_user_freeze(long unsigned int, int)=92:
/usr/xenomai/include/nucleus/trace.h:81: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:82: error: =91__xn_sys_trace=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h:82: error: =91__xn_sys_mux=92 was not
declared in this scope
/usr/xenomai/include/nucleus/trace.h:82: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:82: error: =91xnsig_dispatch=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h: In function =91int
xntrace_special(unsigned char, long unsigned int)=92:
/usr/xenomai/include/nucleus/trace.h:87: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:87: error: =91__xn_sys_trace=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h:87: error: =91__xn_sys_mux=92 was not
declared in this scope
/usr/xenomai/include/nucleus/trace.h:87: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:87: error: =91xnsig_dispatch=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h: In function =91int
xntrace_special_u64(unsigned char, long long unsigned int)=92:
/usr/xenomai/include/nucleus/trace.h:92: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:94: error: =91__xn_sys_trace=92 was no=
t
declared in this scope
/usr/xenomai/include/nucleus/trace.h:94: error: =91__xn_sys_mux=92 was not
declared in this scope
/usr/xenomai/include/nucleus/trace.h:94: error: =91struct frame=92 has no m=
ember
named =91sigs=92
/usr/xenomai/include/nucleus/trace.h:94: error: =91xnsig_dispatch=92 was no=
t
declared in this scope
make[1]: *** [rt_os-xenomai.o] Error 1
make[1]: Leaving directory `/usr/src/rtxi-1.1.2/rtxi'
make: *** [install-recursive] Error 1

Thanks ahead of time.

--000e0cd7080eea5e50048824602e
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

When trying to install RTXI (<a href=3D"http://www.rtxi.org/" target=3D"_bl=
ank">http://www.rtxi.org/</a>) I get the following error.<br><br>In
 file included from /usr/xenomai/include/nucleus/<div id=3D":14o" class=3D"=
ii gt">trace.h:52,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 from /usr/xenomai/include/nucleus/system.h:27,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from /usr/xenomai/include/=
asm/xenomai/system_32.h:130,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0
 from /usr/xenomai/include/asm/xenomai/system.h:2,<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0
 from /usr/xenomai/include/nucleus/types.h:40,<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=20
from /usr/xenomai/include/nucleus/thread.h:25,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from /usr/xenomai/include/=
nucleus/sched.h:31,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 from /usr/xenomai/include/native/task.h:25,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=20
from ../src/rt_os-xenomai.cpp:25:<br>/usr/xenomai/include/asm/xenomai/sysca=
ll.h:42:
 error: field =91sigs=92 has incomplete type<br>
In file included from /usr/xenomai/include/nucleus/system.h:27,<br>=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 from /usr/xenomai/include/asm/xenomai/system_32.h:130,<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 from /usr/xenomai/include/asm/xenomai/system.h:2,<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0
 from /usr/xenomai/include/nucleus/types.h:40,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 from /usr/xenomai/include/=
nucleus/thread.h:25,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
 from /usr/xenomai/include/nucleus/sched.h:31,<br>=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=20
from /usr/xenomai/include/native/task.h:25,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=20
from ../src/rt_os-xenomai.cpp:25:<br>
/usr/xenomai/include/nucleus/trace.h: In function =91int=20
xntrace_max_begin(long unsigned int)=92:<br>/usr/xenomai/include/nucleus/tr=
ace.h:56:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:56:
 error: =91__xn_sys_trace=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h:56: error: =91__xn_sys_mux=92 was=20
not declared in this scope<br>/usr/xenomai/include/nucleus/trace.h:56:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:56:
 error: =91xnsig_dispatch=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h: In function =91int=20
xntrace_max_end(long unsigned int)=92:<br>/usr/xenomai/include/nucleus/trac=
e.h:61:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:61:
 error: =91__xn_sys_trace=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h:61: error: =91__xn_sys_mux=92 was=20
not declared in this scope<br>/usr/xenomai/include/nucleus/trace.h:61:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:61:
 error: =91xnsig_dispatch=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h: In function =91int=20
xntrace_max_reset()=92:<br>/usr/xenomai/include/nucleus/trace.h:66:=20
error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/in=
clude/nucleus/trace.h:66:
 error: =91__xn_sys_trace=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h:66: error: =91__xn_sys_mux=92 was=20
not declared in this scope<br>/usr/xenomai/include/nucleus/trace.h:66:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:66:
 error: =91xnsig_dispatch=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h: In function =91int=20
xntrace_user_start()=92:<br>/usr/xenomai/include/nucleus/trace.h:71:=20
error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/in=
clude/nucleus/trace.h:71:
 error: =91__xn_sys_trace=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h:71: error: =91__xn_sys_mux=92 was=20
not declared in this scope<br>/usr/xenomai/include/nucleus/trace.h:71:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:71:
 error: =91xnsig_dispatch=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h: In function =91int=20
xntrace_user_stop(long unsigned int)=92:<br>/usr/xenomai/include/nucleus/tr=
ace.h:76:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:76:
 error: =91__xn_sys_trace=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h:76: error: =91__xn_sys_mux=92 was=20
not declared in this scope<br>/usr/xenomai/include/nucleus/trace.h:76:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:76:
 error: =91xnsig_dispatch=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h: In function =91int=20
xntrace_user_freeze(long unsigned int, int)=92:<br>/usr/xenomai/include/nuc=
leus/trace.h:81:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:82:
 error: =91__xn_sys_trace=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h:82: error: =91__xn_sys_mux=92 was=20
not declared in this scope<br>/usr/xenomai/include/nucleus/trace.h:82:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:82:
 error: =91xnsig_dispatch=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h: In function =91int=20
xntrace_special(unsigned char, long unsigned int)=92:<br>/usr/xenomai/inclu=
de/nucleus/trace.h:87:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:87:
 error: =91__xn_sys_trace=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h:87: error: =91__xn_sys_mux=92 was=20
not declared in this scope<br>/usr/xenomai/include/nucleus/trace.h:87:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:87:
 error: =91xnsig_dispatch=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h: In function =91int=20
xntrace_special_u64(unsigned char, long long unsigned int)=92:<br>/usr/xeno=
mai/include/nucleus/trace.h:92:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:94:
 error: =91__xn_sys_trace=92 was not declared in this scope<br>
/usr/xenomai/include/nucleus/trace.h:94: error: =91__xn_sys_mux=92 was=20
not declared in this scope<br>/usr/xenomai/include/nucleus/trace.h:94:
 error: =91struct frame=92 has no member named =91sigs=92<br>/usr/xenomai/i=
nclude/nucleus/trace.h:94:
 error: =91xnsig_dispatch=92 was not declared in this scope<br>
make[1]: *** [rt_os-xenomai.o] Error 1<br>make[1]: Leaving directory=20
`/usr/src/rtxi-1.1.2/rtxi&#39;<br>make: *** [install-recursive] Error 1<br>=
<br>Thanks ahead of time.</div>

--000e0cd7080eea5e50048824602e--


