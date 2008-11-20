Date: Thu, 20 Nov 2008 15:02:33 +0100
From: "stephane ancelot" <sancelot@domain.hid>
Content-Type: multipart/mixed; boundary=----------98JtEDjFB10ixZoXPqBKft
MIME-Version: 1.0
References: <42B0FA09DE79461986CBEE046DEF3B87@domain.hid>
	<492429F8.2090309@domain.hid>
	<90cf07d8d7a97433c26e9b773ae87423.squirrel@domain.hid>
Message-ID: <op.ukw7yjpfnuwxn3@domain.hid>
In-Reply-To: <90cf07d8d7a97433c26e9b773ae87423.squirrel@domain.hid>
Subject: Re: [Xenomai-help] Does Valgrind work with Xenomai?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, rpm@xenomai.org
Cc: xenomai@xenomai.org, rob@domain.hid

------------98JtEDjFB10ixZoXPqBKft
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: quoted-printable

wLe Thu, 20 Nov 2008 14:24:30 +0100, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> a =C3=A9crit:

>
> Philippe Gerum wrote:
>> Robert McCullough wrote:
>>> Hi,
>>>
>>>
>>>
>>> I currently have a C++ application that is using 5 RTDM drivers, 2
>>> Xenomai real-time user-space threads and several non-real-time Linux
>>> threads.
>>>
>>> This application seems to have a memory leak because after running fo=
r
>>> several hours the OOM-Killer kills this application.
>>>
>>> I am looking for a memory leak detection tool to help find the leak.
>>>
>>>
>>>
>>> Two years ago in the following mail it was mentioned that making
>>> Valgrind aware of Xenomai syscalls was on the todo list.
>>>
>>> http://article.gmane.org/gmane.linux.real-time.xenomai.users/1805
>>>
>>>
>>>
>>> Has this been done?
>>>
>>
>> No news.
>>
>>> Does Valgrind work with Xenomai?
>>>
>>
>> Nope.
>
> Another way around, at least if you are using the posix skin, is to
> compile your application for Linux without Xenomai. If you are using a
> legacy API, you can do this with Xenomai/SOLO. If you are using the =20
> native
> API, then maybe you can ask gently Philippe to write a native skin for
> Xenomai/SOLO.
>
> Now, about valgrind, I spent some time thinking about it. A first
> modification of valgrind, is to allow dynamic syscall tables, such as =20
> what
> Xenomai use. This should be an easy task.
>
> The next task is to rewrite all xenomai syscalls in valgrind language
> (that is mainly to identify memory reads and writes), this is not a har=
d
> task, but a rather long one. So, my idea (which remains an idea for now=
)
> was to write the interface of the syscalls in IDL, and to generate
> automatically the code for valgrind.
>


I would tell, no , it does not ... after spending time with it .

enclosed is a patch of my work against valgrind 3.3.0


Best Regards
Steph
------------98JtEDjFB10ixZoXPqBKft
Content-Disposition: attachment; filename=valgrind-3.3.0patch.txt
Content-Type: text/plain; name=valgrind-3.3.0patch.txt
Content-Transfer-Encoding: quoted-printable

diff -uNr -x '*supp' -x '*html' -x '*txt' -x vg_regtest -x vg_perf -x lib=
vex_guest_offsets.h -x genoffsets ./coregrind/m_syswrap/syswrap-linux.c .=
./../valgrind-3.3.0/coregrind/m_syswrap/syswrap-linux.c
--- ./coregrind/m_syswrap/syswrap-linux.c	2007-12-11 00:18:43.000000000 +=
0100
+++ ../../valgrind-3.3.0/coregrind/m_syswrap/syswrap-linux.c	2008-05-21 1=
4:55:59.338660493 +0200
@@ -2797,6 +2797,7 @@
    }
 }
=20
+
 /* ---------------------------------------------------------------------
    ioprio_ wrappers
    ------------------------------------------------------------------ */
@@ -2822,6 +2823,9 @@
       PRE_MEM_READ( "utimensat(tvp)", ARG3, sizeof(struct vki_timespec) =
);
 }
=20
+
+
+
 #undef PRE
 #undef POST
=20
diff -uNr -x '*supp' -x '*html' -x '*txt' -x vg_regtest -x vg_perf -x lib=
vex_guest_offsets.h -x genoffsets ./coregrind/m_syswrap/syswrap-x86-linux=
.c ../../valgrind-3.3.0/coregrind/m_syswrap/syswrap-x86-linux.c
--- ./coregrind/m_syswrap/syswrap-x86-linux.c	2007-12-11 00:18:43.0000000=
00 +0100
+++ ../../valgrind-3.3.0/coregrind/m_syswrap/syswrap-x86-linux.c	2008-05-=
21 15:44:59.578280281 +0200
@@ -788,6 +788,8 @@
 DECL_TEMPLATE(x86_linux, sys_vm86old);
 DECL_TEMPLATE(x86_linux, sys_vm86);
 DECL_TEMPLATE(x86_linux, sys_syscall223);
+DECL_TEMPLATE(x86_linux, xeno_bind_skin);
+DECL_TEMPLATE(x86_linux, xn_shadow_sys_info);
=20
 PRE(old_select)
 {
@@ -1816,6 +1818,26 @@
                                       ARG4, ARG5, ARG6 );
 }
=20
+PRE(xeno_bind_skin)
+{
+  PRINT("skin pre");
+}
+
+POST(xeno_bind_skin)
+{
+  PRINT("rt_skin_bind pre");
+}
+PRE(xn_shadow_sys_info)
+{
+  PRINT("xn_shadow_sys_info");
+}
+
+POST(xn_shadow_sys_info)
+{
+  PRINT("xn_shadow_sys_info");
+}
+
+
 #undef PRE
 #undef POST
=20
@@ -1827,8 +1849,18 @@
 /* Add an x86-linux specific wrapper to a syscall table. */
 #define PLAX_(sysno, name)    WRAPPER_ENTRY_X_(x86_linux, sysno, name)=20
 #define PLAXY(sysno, name)    WRAPPER_ENTRY_XY(x86_linux, sysno, name)
-
-
+/* Xenomai multiplexer syscall. */
+#define __xn_sys_mux        555	/* Must fit within 15bit */
+/* Xenomai nucleus syscalls. */
+#define __xn_sys_bind       0	/* muxid =3D bind_to_interface(magic,featd=
ep,abirev) */
+#define __xn_sys_completion 1	/* xnshadow_completion(&completion) */
+#define __xn_sys_migrate    2	/* switched =3D xnshadow_relax/harden() */
+#define __xn_sys_barrier    3	/* started =3D xnshadow_wait_barrier(&entr=
y,&cookie) */
+#define __xn_sys_info       4	/* xnshadow_get_info(muxid,&info) */
+#define __xn_sys_arch       5	/* r =3D xnarch_local_syscall(args) */
+#define __xn_sys_trace      6	/* r =3D xntrace_xxx(...) */
+#define __xn_mux_code(shifted_id,op) ((op << 24)|shifted_id|(__xn_sys_mu=
x & 0x7fff))
+#define XENOMAI_SYSCALL(op) __xn_mux_code(0,op)
 // This table maps from __NR_xxx syscall numbers (from
 // linux/include/asm-i386/unistd.h) to the appropriate PRE/POST sys_foo(=
)
 // wrappers on x86 (as per sys_call_table in linux/arch/i386/kernel/entr=
y.S).
@@ -2218,6 +2250,9 @@
    LINXY(__NR_get_robust_list,	 sys_get_robust_list),  // 312
=20
    LINX_(__NR_utimensat,         sys_utimensat),        // 320
+//   LINXY(__xn_sys_mux,         rt_heap_bind),        // 555
+   PLAXY(__xn_sys_mux,           xeno_bind_skin),        // 555
+   PLAXY(XENOMAI_SYSCALL(__xn_sys_info),xn_shadow_sys_info),       =20
 };
=20
 const UInt ML_(syscall_table_size) =3D=20
diff -uNr -x '*supp' -x '*html' -x '*txt' -x vg_regtest -x vg_perf -x lib=
vex_guest_offsets.h -x genoffsets ./include/vki/vki-scnums-x86-linux.h ..=
/../valgrind-3.3.0/include/vki/vki-scnums-x86-linux.h
--- ./include/vki/vki-scnums-x86-linux.h	2007-12-11 00:18:25.000000000 +0=
100
+++ ../../valgrind-3.3.0/include/vki/vki-scnums-x86-linux.h	2008-05-16 16=
:15:34.286985343 +0200
@@ -353,6 +353,8 @@
 #define __NR_vmsplice		316
 #define __NR_utimensat		320
=20
+#define __xn_sys_mux            555
+
 #endif /* __VKI_SCNUMS_X86_LINUX_H */
=20
 /*--------------------------------------------------------------------*/

------------98JtEDjFB10ixZoXPqBKft--


