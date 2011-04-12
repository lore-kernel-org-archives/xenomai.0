MIME-Version: 1.0
Sender: madjsw@domain.hid
Date: Tue, 12 Apr 2011 09:27:19 -0500
Message-ID: <BANLkTikTWM75UZknkYRt=MeOUDJVsNmLAA@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=00163683340a61c00a04a0b97d0a
Subject: [Xenomai-help] pthread exit and PTHREAD_WARNSW
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--00163683340a61c00a04a0b97d0a
Content-Type: text/plain; charset=ISO-8859-1

>From testing, I found that if I enable PTHREAD_WARNSW for a pthread, I must
explicitly disable this mode before the thread terminates, or the thread
draws a signal 24 SIGXCPU.

I've tried to simplify my thread terminations by pushing a function which
calls pthread_set_mode_np(PTHREAD_WARNSW, 0) onto the thread cleanup stack,
and always terminating the thread via pthread_exit().  However, this method
still draws a signal 24 SIGXCPU.    Here's a sample backtrace:

Program terminated with signal 24, CPU time limit exceeded.
#0  0xffffe424 in __kernel_vsyscall ()
(gdb) bt full
#0  0xffffe424 in __kernel_vsyscall ()
No symbol table info available.
#1  0xb781d561 in pthread_once () from /lib/libpthread.so.0
No symbol table info available.
#2  0xb76e0450 in ?? () from /lib/libgcc_s.so.1
No symbol table info available.
#3  0xb76e09de in _Unwind_ForcedUnwind () from /lib/libgcc_s.so.1
No symbol table info available.
#4  0xb7821032 in _Unwind_ForcedUnwind () from /lib/libpthread.so.0
No symbol table info available.
#5  0xb781ea97 in __pthread_unwind () from /lib/libpthread.so.0
No symbol table info available.
#6  0xb7818a5e in pthread_exit () from /lib/libpthread.so.0
No symbol table info available.
#7  0x0804969b in my program termination code

Am I coding this incorrectly, or is this just the way pthreads interacts
with Xenomai?

my config:
# xeno-config --version
2.5.6
# ldd ./mq_test
        linux-gate.so.1 =>  (0xffffe000)
        libpthread_rt.so.1 => /usr/xenomai/lib/libpthread_rt.so.1
(0xb778b000)
        libxenomai.so.0 => /usr/xenomai/lib/libxenomai.so.0 (0xb7785000)
        libpthread.so.0 => /lib/libpthread.so.0 (0xb776a000)
        librt.so.1 => /lib/librt.so.1 (0xb7760000)
        librtdk.so.0 => /usr/xenomai/lib/librtdk.so.0 (0xb775a000)
        libstdc++.so.6 => /usr/lib/libstdc++.so.6 (0xb766a000)
        libm.so.6 => /lib/libm.so.6 (0xb7640000)
        libgcc_s.so.1 => /lib/libgcc_s.so.1 (0xb7622000)
        libc.so.6 => /lib/libc.so.6 (0xb74b7000)
        /lib/ld-linux.so.2 (0xb77b4000)
#> rpm -qf /lib/libpthread.so.0
glibc-2.11.2-3.1.1.i686
# uname -a
Linux xeno2 2.6.37.3-xeno-2.5.6-smp #1 SMP PREEMPT Fri Mar 11 12:43:02 CST
2011 i686 i686 i386 GNU/Linux


TIA,
Jeff

--00163683340a61c00a04a0b97d0a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

>From testing, I found that if I enable=A0PTHREAD_WARNSW for a pthread, I mu=
st explicitly disable this mode before the thread terminates, or the thread=
 draws=A0a signal 24 SIGXCPU.<div><br></div><div>I&#39;ve tried to simplify=
 my thread terminations by pushing a function which calls=A0pthread_set_mod=
e_np(PTHREAD_WARNSW, 0) onto the thread cleanup stack, and always terminati=
ng the thread via pthread_exit(). =A0However, this method still draws a sig=
nal 24 SIGXCPU. =A0 =A0Here&#39;s a sample backtrace:</div>
<div><br></div><div><div>Program terminated with signal 24, CPU time limit =
exceeded.</div><div>#0 =A00xffffe424 in __kernel_vsyscall ()</div><div>(gdb=
) bt full</div><div>#0 =A00xffffe424 in __kernel_vsyscall ()</div><div>No s=
ymbol table info available.</div>
<div>#1 =A00xb781d561 in pthread_once () from /lib/libpthread.so.0</div><di=
v>No symbol table info available.</div><div>#2 =A00xb76e0450 in ?? () from =
/lib/libgcc_s.so.1</div><div>No symbol table info available.</div><div>#3 =
=A00xb76e09de in _Unwind_ForcedUnwind () from /lib/libgcc_s.so.1</div>
<div>No symbol table info available.</div><div>#4 =A00xb7821032 in _Unwind_=
ForcedUnwind () from /lib/libpthread.so.0</div><div>No symbol table info av=
ailable.</div><div>#5 =A00xb781ea97 in __pthread_unwind () from /lib/libpth=
read.so.0</div>
<div>No symbol table info available.</div><div>#6 =A00xb7818a5e in pthread_=
exit () from /lib/libpthread.so.0</div><div>No symbol table info available.=
</div><div>#7 =A00x0804969b in my program termination code
</div></div><div><br></div><div>Am I coding this incorrectly, or is this ju=
st the way pthreads interacts with Xenomai?</div><div><br></div><div>my con=
fig:</div><div><div># xeno-config --version</div><div>2.5.6</div><div>
# ldd ./mq_test</div><div>=A0=A0 =A0 =A0 =A0linux-gate.so.1 =3D&gt; =A0(0xf=
fffe000)</div><div>=A0=A0 =A0 =A0 =A0libpthread_rt.so.1 =3D&gt; /usr/xenoma=
i/lib/libpthread_rt.so.1 (0xb778b000)</div><div>=A0=A0 =A0 =A0 =A0libxenoma=
i.so.0 =3D&gt; /usr/xenomai/lib/libxenomai.so.0 (0xb7785000)</div>
<div>=A0=A0 =A0 =A0 =A0libpthread.so.0 =3D&gt; /lib/libpthread.so.0 (0xb776=
a000)</div><div>=A0=A0 =A0 =A0 =A0librt.so.1 =3D&gt; /lib/librt.so.1 (0xb77=
60000)</div><div>=A0=A0 =A0 =A0 =A0librtdk.so.0 =3D&gt; /usr/xenomai/lib/li=
brtdk.so.0 (0xb775a000)</div><div>
=A0=A0 =A0 =A0 =A0libstdc++.so.6 =3D&gt; /usr/lib/libstdc++.so.6 (0xb766a00=
0)</div><div>=A0=A0 =A0 =A0 =A0libm.so.6 =3D&gt; /lib/libm.so.6 (0xb7640000=
)</div><div>=A0=A0 =A0 =A0 =A0libgcc_s.so.1 =3D&gt; /lib/libgcc_s.so.1 (0xb=
7622000)</div><div>=A0=A0 =A0 =A0 =A0libc.so.6 =3D&gt; /lib/libc.so.6 (0xb7=
4b7000)</div>
<div>=A0=A0 =A0 =A0 =A0/lib/ld-linux.so.2 (0xb77b4000)</div><div>#&gt; rpm =
-qf /lib/libpthread.so.0</div><div>glibc-2.11.2-3.1.1.i686</div></div><div>=
#=A0uname -a</div><div>Linux xeno2 2.6.37.3-xeno-2.5.6-smp #1 SMP PREEMPT F=
ri Mar 11 12:43:02 CST 2011 i686 i686 i386 GNU/Linux</div>
<div><br></div><div><br></div><div>TIA,</div><div>Jeff</div><div><br></div>

--00163683340a61c00a04a0b97d0a--

