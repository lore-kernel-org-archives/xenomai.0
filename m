MIME-Version: 1.0
Sender: madjsw@domain.hid
Date: Mon, 17 Jan 2011 14:15:59 -0600
Message-ID: <AANLkTi=w67oJVc+iwJdN3znbje0PMiEcjtEUic3xMcNj@domain.hid>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016367fb44fc9240e049a107306
Subject: [Xenomai-help] segfault sharing mutex from kernel space to user
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
To: xenomai@xenomai.org

--0016367fb44fc9240e049a107306
Content-Type: text/plain; charset=ISO-8859-1

I get a segfault when attempting to rt_mutex_acquire a mutex created in
kernel space.  I've reduced the issue to the following sample code.
Help finding my mistake is appreciated.

TIA,
Jeff


Kernel space Code:
#include <linux/module.h>
#include <linux/init.h>
#include <native/mutex.h>
#include "testAPI.h"  /* defines MTXNAME */

#define MODNAME  "XenoTest"

static RT_MUTEX sMtx;

static int __init mymodule_init(void)
{
    int status;

    status = rt_mutex_create(&sMtx, MTXNAME);
    if (status) {
    printk ("rt_mutex_create: %d\n", status);
        return 1;
    }

    printk ("loaded module %s\n", MODNAME);
    return 0;
}

static void __exit mymodule_exit(void)
{
    rt_mutex_delete(&sMtx);

    printk ("unloaded module %s\n", MODNAME);
    return;
}

module_init(mymodule_init);
module_exit(mymodule_exit);

MODULE_LICENSE("GPL");



User space Code:
#include <stdio.h>
#include <sys/mman.h>
#include <native/mutex.h>
#include <native/task.h>

#include "testAPI.h"    /* defines MTXNAME */

#define PRIO    0
#define MODE    0

int main(void)
{
    RT_MUTEX mtx;
    RT_TASK  tsk;
    RT_MUTEX_INFO info;
    int status;

    mlockall(MCL_CURRENT|MCL_FUTURE);

    status = rt_task_shadow(&tsk, NULL, PRIO, MODE);
    if (status) {
        fprintf(stderr, "rt_task_shadow: %d\n", status);
        return 1;
    }

    status = rt_mutex_bind(&mtx, MTXNAME, TM_INFINITE);
    if (status) {
        fprintf(stderr, "rt_mutex_bind: %d\n", status);
        return 1;
    }

    status = rt_mutex_inquire(&mtx, &info);
    if (status) {
        fprintf(stderr, "rt_mutex_inquire: %d\n", status);
        return 1;
    }

    status = rt_mutex_acquire(&mtx, TM_INFINITE); /* SEGFAULT HERE! */
    if (status) {
        fprintf(stderr, "rt_mutex_acquire: %d\n", status);
        return 1;
    }

    status = rt_mutex_release(&mtx);
    if (status) {
        fprintf(stderr, "rt_mutex_release: %d\n", status);
        return 1;
    }

    printf("test success\n");   // back to primary mode
    return 0;
}

my kernel

backtrace:
Program terminated with signal 11, Segmentation fault.
#0  0xb770077a in xnarch_atomic_cmpxchg (v=0xb777ac00, old=0, newval=21)
    at ../../../src/include/asm/xenomai/atomic.h:95
95              __asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
(gdb) bt full
#0  0xb770077a in xnarch_atomic_cmpxchg (v=0xb777ac00, old=0, newval=21)
    at ../../../src/include/asm/xenomai/atomic.h:95
        ptr = 0xb777ac00
        prev = 4294967295
#1  0xb7700815 in xnsynch_fast_acquire (fastlock=0xb777ac00, new_ownerh=21)
    at ../../../include/nucleus/synch.h:52
        lock_state = 3077595124
#2  0xb7700c3a in rt_mutex_acquire_inner (mutex=0xbfecd690, timeout=0,
    mode=XN_RELATIVE) at mutex.c:83
        err = 134513420
        cur = 21
#3  0xb7700e01 in rt_mutex_acquire (mutex=0xbfecd690, timeout=0) at
mutex.c:129
No locals.
#4  0x0804884a in main () at uspace.c:38
        mtx = {opaque = 19, fastlock = 0xb777ac00, lockcnt = 0}
        tsk = {opaque = 21, opaque2 = 3075921616}
        info = {locked = 0, nwaiters = 0,
          name = "TestMtx\000\000\000\060\000@domain.hid%", '\000'
<repeats 12 times>,
          owner =
"\000\000\000\000\364\036\331\336\020\037\331\336\365Pd\340\005\005UU\000\037\331\336\000\000\000\000\023\000\000"}
        status = 0

my config:
arch: x86
linux: 2.6.35.10
xenomai: 2.5.5.2

BTW: I did a checkout of git tag v2.5.5.2, and XENO_VERSION_STRING is
"2.5.5.1"

--0016367fb44fc9240e049a107306
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I get a segfault when attempting to rt_mutex_acquire a mutex created in ker=
nel space.=A0 I&#39;ve reduced the issue to the following sample code.<br>H=
elp finding my mistake is appreciated.<br><br>TIA,<br>Jeff<br><br><br>Kerne=
l space Code:<br>
#include &lt;linux/module.h&gt;<br>#include &lt;linux/init.h&gt;<br>#includ=
e &lt;native/mutex.h&gt;<br>#include &quot;testAPI.h&quot;=A0  /* defines M=
TXNAME */<br><br>#define MODNAME=A0 &quot;XenoTest&quot;<br><br>static RT_M=
UTEX sMtx;<br>
<br>static int __init mymodule_init(void)<br>{<br>=A0=A0=A0 int status;<br>=
<br>=A0=A0=A0 status =3D rt_mutex_create(&amp;sMtx, MTXNAME);<br>=A0=A0=A0 =
if (status) {<br>=A0=A0=A0 printk (&quot;rt_mutex_create: %d\n&quot;, statu=
s);<br>=A0=A0=A0=A0=A0=A0=A0 return 1;<br>
=A0=A0=A0 }<br><br>=A0=A0=A0 printk (&quot;loaded module %s\n&quot;, MODNAM=
E);<br>=A0=A0=A0 return 0;<br>}<br><br>static void __exit mymodule_exit(voi=
d)<br>{<br>=A0=A0=A0 rt_mutex_delete(&amp;sMtx);<br><br>=A0=A0=A0 printk (&=
quot;unloaded module %s\n&quot;, MODNAME);<br>
=A0=A0=A0 return;<br>}<br><br>module_init(mymodule_init);<br>module_exit(my=
module_exit);<br><br>MODULE_LICENSE(&quot;GPL&quot;);<br><br><br><br>User s=
pace Code:<br>#include &lt;stdio.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#i=
nclude &lt;native/mutex.h&gt;<br>
#include &lt;native/task.h&gt;<br><br>#include &quot;testAPI.h&quot;=A0=A0=
=A0 /* defines MTXNAME */<br><br>#define PRIO=A0=A0=A0 0<br>#define MODE=A0=
=A0=A0 0<br><br>int main(void)<br>{<br>=A0=A0=A0 RT_MUTEX mtx;<br>=A0=A0=A0=
 RT_TASK=A0 tsk;<br>=A0=A0=A0 RT_MUTEX_INFO info;<br>
=A0=A0=A0 int status;<br><br>=A0=A0=A0 mlockall(MCL_CURRENT|MCL_FUTURE);<br=
><br>=A0=A0=A0 status =3D rt_task_shadow(&amp;tsk, NULL, PRIO, MODE);<br>=
=A0=A0=A0 if (status) {<br>=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, &quot;rt_t=
ask_shadow: %d\n&quot;, status);<br>=A0=A0=A0=A0=A0=A0=A0 return 1;<br>
=A0=A0=A0 }<br><br>=A0=A0=A0 status =3D rt_mutex_bind(&amp;mtx, MTXNAME, TM=
_INFINITE);<br>=A0=A0=A0 if (status) {<br>=A0=A0=A0=A0=A0=A0=A0 fprintf(std=
err, &quot;rt_mutex_bind: %d\n&quot;, status);<br>=A0=A0=A0=A0=A0=A0=A0 ret=
urn 1;<br>=A0=A0=A0 }<br><br>=A0=A0=A0 status =3D rt_mutex_inquire(&amp;mtx=
, &amp;info);<br>
=A0=A0=A0 if (status) {<br>=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, &quot;rt_m=
utex_inquire: %d\n&quot;, status);<br>=A0=A0=A0=A0=A0=A0=A0 return 1;<br>=
=A0=A0=A0 }<br><br>=A0=A0=A0 status =3D rt_mutex_acquire(&amp;mtx, TM_INFIN=
ITE); /* SEGFAULT HERE! */<br>=A0=A0=A0 if (status) {<br>
=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr, &quot;rt_mutex_acquire: %d\n&quot;, s=
tatus);<br>=A0=A0=A0=A0=A0=A0=A0 return 1;<br>=A0=A0=A0 }<br><br>=A0=A0=A0 =
status =3D rt_mutex_release(&amp;mtx);<br>=A0=A0=A0 if (status) {<br>=A0=A0=
=A0=A0=A0=A0=A0 fprintf(stderr, &quot;rt_mutex_release: %d\n&quot;, status)=
;<br>
=A0=A0=A0=A0=A0=A0=A0 return 1;<br>=A0=A0=A0 }<br><br>=A0=A0=A0 printf(&quo=
t;test success\n&quot;);=A0=A0 // back to primary mode<br>=A0=A0=A0 return =
0;<br>}<br><br>my kernel <br><br>backtrace:<br>Program terminated with sign=
al 11, Segmentation fault.<br>#0=A0 0xb770077a in xnarch_atomic_cmpxchg (v=
=3D0xb777ac00, old=3D0, newval=3D21)<br>
=A0=A0=A0 at ../../../src/include/asm/xenomai/atomic.h:95<br>95=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 __asm__ __volatile__(LOCK_PREFIX &quot;cmpxchgl=
 %1,%2&quot;<br>(gdb) bt full<br>#0=A0 0xb770077a in xnarch_atomic_cmpxchg =
(v=3D0xb777ac00, old=3D0, newval=3D21)<br>
=A0=A0=A0 at ../../../src/include/asm/xenomai/atomic.h:95<br>=A0=A0=A0=A0=
=A0=A0=A0 ptr =3D 0xb777ac00<br>=A0=A0=A0=A0=A0=A0=A0 prev =3D 4294967295<b=
r>#1=A0 0xb7700815 in xnsynch_fast_acquire (fastlock=3D0xb777ac00, new_owne=
rh=3D21)<br>=A0=A0=A0 at ../../../include/nucleus/synch.h:52<br>
=A0=A0=A0=A0=A0=A0=A0 lock_state =3D 3077595124<br>#2=A0 0xb7700c3a in rt_m=
utex_acquire_inner (mutex=3D0xbfecd690, timeout=3D0,<br>=A0=A0=A0 mode=3DXN=
_RELATIVE) at mutex.c:83<br>=A0=A0=A0=A0=A0=A0=A0 err =3D 134513420<br>=A0=
=A0=A0=A0=A0=A0=A0 cur =3D 21<br>#3=A0 0xb7700e01 in rt_mutex_acquire (mute=
x=3D0xbfecd690, timeout=3D0) at mutex.c:129<br>
No locals.<br>#4=A0 0x0804884a in main () at uspace.c:38<br>=A0=A0=A0=A0=A0=
=A0=A0 mtx =3D {opaque =3D 19, fastlock =3D 0xb777ac00, lockcnt =3D 0}<br>=
=A0=A0=A0=A0=A0=A0=A0 tsk =3D {opaque =3D 21, opaque2 =3D 3075921616}<br>=
=A0=A0=A0=A0=A0=A0=A0 info =3D {locked =3D 0, nwaiters =3D 0,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0 name =3D &quot;TestMtx\000\000\000\060\000@domain.hid=
i\340\000\177%&quot;, &#39;\000&#39; &lt;repeats 12 times&gt;,<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 owner =3D &quot;\000\000\000\000\364\036\331\336\020\037=
\331\336\365Pd\340\005\005UU\000\037\331\336\000\000\000\000\023\000\000&qu=
ot;}<br>
=A0=A0=A0=A0=A0=A0=A0 status =3D 0<br><br>my config:<br>arch: x86<br>linux:=
 2.6.35.10<br>xenomai: 2.5.5.2 <br><br>BTW: I did a checkout of git tag v2.=
5.5.2, and XENO_VERSION_STRING is &quot;2.5.5.1&quot;<br><br>

--0016367fb44fc9240e049a107306--

