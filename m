MIME-Version: 1.0
Sender: madjsw@domain.hid
In-Reply-To: <4D34B900.4050604@domain.hid>
References: <AANLkTi=w67oJVc+iwJdN3znbje0PMiEcjtEUic3xMcNj@domain.hid>
	<4D34B900.4050604@domain.hid>
Date: Mon, 17 Jan 2011 16:44:06 -0600
Message-ID: <AANLkTim41OwqX03WKCKwacwHjGBdJYFm++FEwa97tmqO@mail.gmail.com>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016367b5e1e799a28049a12859e
Subject: Re: [Xenomai-help] segfault sharing mutex from kernel space to user
	space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--0016367b5e1e799a28049a12859e
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 17, 2011 at 3:47 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Jeff Weber wrote:
> > I get a segfault when attempting to rt_mutex_acquire a mutex created in
> > kernel space.  I've reduced the issue to the following sample code.
> > Help finding my mistake is appreciated.
> >
> > TIA,
> > Jeff
> >
> >
> > Kernel space Code:
> > #include <linux/module.h>
> > #include <linux/init.h>
> > #include <native/mutex.h>
> > #include "testAPI.h"  /* defines MTXNAME */
> >
> > #define MODNAME  "XenoTest"
> >
> > static RT_MUTEX sMtx;
> >
> > static int __init mymodule_init(void)
> > {
> >     int status;
> >
> >     status = rt_mutex_create(&sMtx, MTXNAME);
> >     if (status) {
> >     printk ("rt_mutex_create: %d\n", status);
> >         return 1;
> >     }
> >
> >     printk ("loaded module %s\n", MODNAME);
> >     return 0;
> > }
> >
> > static void __exit mymodule_exit(void)
> > {
> >     rt_mutex_delete(&sMtx);
> >
> >     printk ("unloaded module %s\n", MODNAME);
> >     return;
> > }
> >
> > module_init(mymodule_init);
> > module_exit(mymodule_exit);
> >
> > MODULE_LICENSE("GPL");
> >
> >
> >
> > User space Code:
> > #include <stdio.h>
> > #include <sys/mman.h>
> > #include <native/mutex.h>
> > #include <native/task.h>
> >
> > #include "testAPI.h"    /* defines MTXNAME */
> >
> > #define PRIO    0
> > #define MODE    0
> >
> > int main(void)
> > {
> >     RT_MUTEX mtx;
> >     RT_TASK  tsk;
> >     RT_MUTEX_INFO info;
> >     int status;
> >
> >     mlockall(MCL_CURRENT|MCL_FUTURE);
> >
> >     status = rt_task_shadow(&tsk, NULL, PRIO, MODE);
> >     if (status) {
> >         fprintf(stderr, "rt_task_shadow: %d\n", status);
> >         return 1;
> >     }
> >
> >     status = rt_mutex_bind(&mtx, MTXNAME, TM_INFINITE);
> >     if (status) {
> >         fprintf(stderr, "rt_mutex_bind: %d\n", status);
> >         return 1;
> >     }
> >
> >     status = rt_mutex_inquire(&mtx, &info);
> >     if (status) {
> >         fprintf(stderr, "rt_mutex_inquire: %d\n", status);
> >         return 1;
> >     }
> >
> >     status = rt_mutex_acquire(&mtx, TM_INFINITE); /* SEGFAULT HERE! */
> >     if (status) {
> >         fprintf(stderr, "rt_mutex_acquire: %d\n", status);
> >         return 1;
> >     }
> >
> >     status = rt_mutex_release(&mtx);
> >     if (status) {
> >         fprintf(stderr, "rt_mutex_release: %d\n", status);
> >         return 1;
> >     }
> >
> >     printf("test success\n");   // back to primary mode
> >     return 0;
> > }
> >
> > my kernel
> >
> > backtrace:
> > Program terminated with signal 11, Segmentation fault.
> > #0  0xb770077a in xnarch_atomic_cmpxchg (v=0xb777ac00, old=0, newval=21)
> >     at ../../../src/include/asm/xenomai/atomic.h:95
> > 95              __asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
> > (gdb) bt full
> > #0  0xb770077a in xnarch_atomic_cmpxchg (v=0xb777ac00, old=0, newval=21)
> >     at ../../../src/include/asm/xenomai/atomic.h:95
> >         ptr = 0xb777ac00
> >         prev = 4294967295
> > #1  0xb7700815 in xnsynch_fast_acquire (fastlock=0xb777ac00,
> new_ownerh=21)
> >     at ../../../include/nucleus/synch.h:52
> >         lock_state = 3077595124
> > #2  0xb7700c3a in rt_mutex_acquire_inner (mutex=0xbfecd690, timeout=0,
> >     mode=XN_RELATIVE) at mutex.c:83
> >         err = 134513420
> >         cur = 21
> > #3  0xb7700e01 in rt_mutex_acquire (mutex=0xbfecd690, timeout=0) at
> > mutex.c:129
> > No locals.
> > #4  0x0804884a in main () at uspace.c:38
> >         mtx = {opaque = 19, fastlock = 0xb777ac00, lockcnt = 0}
> >         tsk = {opaque = 21, opaque2 = 3075921616}
> >         info = {locked = 0, nwaiters = 0,
> >           name = "TestMtx\000\000\000\060\000@domain.hid%",
> '\000'
> > <repeats 12 times>,
> >           owner =
> >
> "\000\000\000\000\364\036\331\336\020\037\331\336\365Pd\340\005\005UU\000\037\331\336\000\000\000\000\023\000\000"}
> >         status = 0
> >
> > my config:
> > arch: x86
> > linux: 2.6.35.10
> > xenomai: 2.5.5.2
>
> 32 bits? 64 bits? uniprocessor? multiprocessor?
>
> --
>                                                                 Gilles.
>

32-bit uniprocessor

Jeff

--0016367b5e1e799a28049a12859e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Jan 17, 2011 at 3:47 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-le=
ft: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">Jeff Weber wrote:<br>
&gt; I get a segfault when attempting to rt_mutex_acquire a mutex created i=
n<br>
&gt; kernel space. =A0I&#39;ve reduced the issue to the following sample co=
de.<br>
&gt; Help finding my mistake is appreciated.<br>
&gt;<br>
&gt; TIA,<br>
&gt; Jeff<br>
&gt;<br>
&gt;<br>
&gt; Kernel space Code:<br>
&gt; #include &lt;linux/module.h&gt;<br>
&gt; #include &lt;linux/init.h&gt;<br>
&gt; #include &lt;native/mutex.h&gt;<br>
&gt; #include &quot;testAPI.h&quot; =A0/* defines MTXNAME */<br>
&gt;<br>
&gt; #define MODNAME =A0&quot;XenoTest&quot;<br>
&gt;<br>
&gt; static RT_MUTEX sMtx;<br>
&gt;<br>
&gt; static int __init mymodule_init(void)<br>
&gt; {<br>
&gt; =A0 =A0 int status;<br>
&gt;<br>
&gt; =A0 =A0 status =3D rt_mutex_create(&amp;sMtx, MTXNAME);<br>
&gt; =A0 =A0 if (status) {<br>
&gt; =A0 =A0 printk (&quot;rt_mutex_create: %d\n&quot;, status);<br>
&gt; =A0 =A0 =A0 =A0 return 1;<br>
&gt; =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 printk (&quot;loaded module %s\n&quot;, MODNAME);<br>
&gt; =A0 =A0 return 0;<br>
&gt; }<br>
&gt;<br>
&gt; static void __exit mymodule_exit(void)<br>
&gt; {<br>
&gt; =A0 =A0 rt_mutex_delete(&amp;sMtx);<br>
&gt;<br>
&gt; =A0 =A0 printk (&quot;unloaded module %s\n&quot;, MODNAME);<br>
&gt; =A0 =A0 return;<br>
&gt; }<br>
&gt;<br>
&gt; module_init(mymodule_init);<br>
&gt; module_exit(mymodule_exit);<br>
&gt;<br>
&gt; MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; User space Code:<br>
&gt; #include &lt;stdio.h&gt;<br>
&gt; #include &lt;sys/mman.h&gt;<br>
&gt; #include &lt;native/mutex.h&gt;<br>
&gt; #include &lt;native/task.h&gt;<br>
&gt;<br>
&gt; #include &quot;testAPI.h&quot; =A0 =A0/* defines MTXNAME */<br>
&gt;<br>
&gt; #define PRIO =A0 =A00<br>
&gt; #define MODE =A0 =A00<br>
&gt;<br>
&gt; int main(void)<br>
&gt; {<br>
&gt; =A0 =A0 RT_MUTEX mtx;<br>
&gt; =A0 =A0 RT_TASK =A0tsk;<br>
&gt; =A0 =A0 RT_MUTEX_INFO info;<br>
&gt; =A0 =A0 int status;<br>
&gt;<br>
&gt; =A0 =A0 mlockall(MCL_CURRENT|MCL_FUTURE);<br>
&gt;<br>
&gt; =A0 =A0 status =3D rt_task_shadow(&amp;tsk, NULL, PRIO, MODE);<br>
&gt; =A0 =A0 if (status) {<br>
&gt; =A0 =A0 =A0 =A0 fprintf(stderr, &quot;rt_task_shadow: %d\n&quot;, stat=
us);<br>
&gt; =A0 =A0 =A0 =A0 return 1;<br>
&gt; =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 status =3D rt_mutex_bind(&amp;mtx, MTXNAME, TM_INFINITE);<br>
&gt; =A0 =A0 if (status) {<br>
&gt; =A0 =A0 =A0 =A0 fprintf(stderr, &quot;rt_mutex_bind: %d\n&quot;, statu=
s);<br>
&gt; =A0 =A0 =A0 =A0 return 1;<br>
&gt; =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 status =3D rt_mutex_inquire(&amp;mtx, &amp;info);<br>
&gt; =A0 =A0 if (status) {<br>
&gt; =A0 =A0 =A0 =A0 fprintf(stderr, &quot;rt_mutex_inquire: %d\n&quot;, st=
atus);<br>
&gt; =A0 =A0 =A0 =A0 return 1;<br>
&gt; =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 status =3D rt_mutex_acquire(&amp;mtx, TM_INFINITE); /* SEGFAUL=
T HERE! */<br>
&gt; =A0 =A0 if (status) {<br>
&gt; =A0 =A0 =A0 =A0 fprintf(stderr, &quot;rt_mutex_acquire: %d\n&quot;, st=
atus);<br>
&gt; =A0 =A0 =A0 =A0 return 1;<br>
&gt; =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 status =3D rt_mutex_release(&amp;mtx);<br>
&gt; =A0 =A0 if (status) {<br>
&gt; =A0 =A0 =A0 =A0 fprintf(stderr, &quot;rt_mutex_release: %d\n&quot;, st=
atus);<br>
&gt; =A0 =A0 =A0 =A0 return 1;<br>
&gt; =A0 =A0 }<br>
&gt;<br>
&gt; =A0 =A0 printf(&quot;test success\n&quot;); =A0 // back to primary mod=
e<br>
&gt; =A0 =A0 return 0;<br>
&gt; }<br>
&gt;<br>
&gt; my kernel<br>
&gt;<br>
&gt; backtrace:<br>
&gt; Program terminated with signal 11, Segmentation fault.<br>
&gt; #0 =A00xb770077a in xnarch_atomic_cmpxchg (v=3D0xb777ac00, old=3D0, ne=
wval=3D21)<br>
&gt; =A0 =A0 at ../../../src/include/asm/xenomai/atomic.h:95<br>
&gt; 95 =A0 =A0 =A0 =A0 =A0 =A0 =A0__asm__ __volatile__(LOCK_PREFIX &quot;c=
mpxchgl %1,%2&quot;<br>
&gt; (gdb) bt full<br>
&gt; #0 =A00xb770077a in xnarch_atomic_cmpxchg (v=3D0xb777ac00, old=3D0, ne=
wval=3D21)<br>
&gt; =A0 =A0 at ../../../src/include/asm/xenomai/atomic.h:95<br>
&gt; =A0 =A0 =A0 =A0 ptr =3D 0xb777ac00<br>
&gt; =A0 =A0 =A0 =A0 prev =3D 4294967295<br>
&gt; #1 =A00xb7700815 in xnsynch_fast_acquire (fastlock=3D0xb777ac00, new_o=
wnerh=3D21)<br>
&gt; =A0 =A0 at ../../../include/nucleus/synch.h:52<br>
&gt; =A0 =A0 =A0 =A0 lock_state =3D 3077595124<br>
&gt; #2 =A00xb7700c3a in rt_mutex_acquire_inner (mutex=3D0xbfecd690, timeou=
t=3D0,<br>
&gt; =A0 =A0 mode=3DXN_RELATIVE) at mutex.c:83<br>
&gt; =A0 =A0 =A0 =A0 err =3D 134513420<br>
&gt; =A0 =A0 =A0 =A0 cur =3D 21<br>
&gt; #3 =A00xb7700e01 in rt_mutex_acquire (mutex=3D0xbfecd690, timeout=3D0)=
 at<br>
&gt; mutex.c:129<br>
&gt; No locals.<br>
&gt; #4 =A00x0804884a in main () at uspace.c:38<br>
&gt; =A0 =A0 =A0 =A0 mtx =3D {opaque =3D 19, fastlock =3D 0xb777ac00, lockc=
nt =3D 0}<br>
&gt; =A0 =A0 =A0 =A0 tsk =3D {opaque =3D 21, opaque2 =3D 3075921616}<br>
&gt; =A0 =A0 =A0 =A0 info =3D {locked =3D 0, nwaiters =3D 0,<br>
&gt; =A0 =A0 =A0 =A0 =A0 name =3D &quot;TestMtx\000\000\000\060\000@domain.hid=
40\000\177%&quot;, &#39;\000&#39;<br>
&gt; &lt;repeats 12 times&gt;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 owner =3D<br>
&gt; &quot;\000\000\000\000\364\036\331\336\020\037\331\336\365Pd\340\005\0=
05UU\000\037\331\336\000\000\000\000\023\000\000&quot;}<br>
&gt; =A0 =A0 =A0 =A0 status =3D 0<br>
&gt;<br>
&gt; my config:<br>
&gt; arch: x86<br>
&gt; linux: 2.6.35.10<br>
&gt; xenomai: 2.5.5.2<br>
<br>
</div></div>32 bits? 64 bits? uniprocessor? multiprocessor?<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>32-bit uniprocessor<br><br>Jeff<br>

--0016367b5e1e799a28049a12859e--

