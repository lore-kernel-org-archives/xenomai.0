Subject: Re: Problem with gdb
References: <e393e320-54ea-7a16-d645-3441c80cdc0c@mitrol.it>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <23d1e027-2e62-8d52-de94-0e9d53b6aa5c@siemens.com>
Date: Sun, 26 Apr 2020 10:33:46 +0200
MIME-Version: 1.0
In-Reply-To: <e393e320-54ea-7a16-d645-3441c80cdc0c@mitrol.it>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paolo Minazzi <Paolo.Minazzi@mitrol.it>, xenomai@xenomai.org

On 25.04.20 09:18, Paolo Minazzi via Xenomai wrote:
> I'm Paolo Minazzi.
> I am working on an ARM board with iMX6SX.
>=20
> Linux kernel : 4.9
> Ipipe=A0=A0=A0=A0=A0=A0=A0 : ipipe-core-4.9.38-arm-3.patch

Can you cross-check with ipipe-core-4.19.114-cip24-arm-08? 4.9 is=20
unmaintained regarding I-pipe.

> Xenomai=A0=A0=A0=A0=A0 : 3.1
>=20
> All works well.
> I have a problem debugging with GDB (both native and remote).
> The problem is that before an alchemy small demo starts, I have the hit=20
> 2 times CTRL-C and use "c" command.
>=20
> Details:
> [1] gdb demo
> [2] I use the "r" command to run.
>  =A0=A0=A0 gdb remain blocked
> [3] I press CTRL-C, then "c" command.
>  =A0=A0=A0 gdb remain blocked
> [4] I press CTRL-C, then "c" command.
>  =A0=A0=A0 Then demo start correctly
>=20
> Can you help me ?
>=20

How did you build Xenomai (configure options)? How are you building your=20
demo?

Jan

> Kind regards,
> Paolo Minazzi
>=20
>=20
> EXTRA DETAILS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> GDB SESSION
>  =A0=A0=A0=A0=A0=A0=A0 GNU gdb (GDB) 7.12
>  =A0=A0=A0=A0=A0=A0=A0 Copyright (C) 2016 Free Software Foundation, Inc.
>  =A0=A0=A0=A0=A0=A0=A0 License GPLv3+: GNU GPL version 3 or later=20
> <http://gnu.org/licenses/gpl.html>
>  =A0=A0=A0=A0=A0=A0=A0 This is free software: you are free to change and =
redistribute it.
>  =A0=A0=A0=A0=A0=A0=A0 There is NO WARRANTY, to the extent permitted by l=
aw. Type=20
> "show copying"
>  =A0=A0=A0=A0=A0=A0=A0 and "show warranty" for details.
>  =A0=A0=A0=A0=A0=A0=A0 This GDB was configured as "arm-linux-gnueabihf".
>  =A0=A0=A0=A0=A0=A0=A0 Type "show configuration" for configuration detail=
s.
>  =A0=A0=A0=A0=A0=A0=A0 For bug reporting instructions, please see:
>  =A0=A0=A0=A0=A0=A0=A0 <http://www.gnu.org/software/gdb/bugs/>.
>  =A0=A0=A0=A0=A0=A0=A0 Find the GDB manual and other documentation resour=
ces online at:
>  =A0=A0=A0=A0=A0=A0=A0 <http://www.gnu.org/software/gdb/documentation/>.
>  =A0=A0=A0=A0=A0=A0=A0 For help, type "help".
>  =A0=A0=A0=A0=A0=A0=A0 Type "apropos word" to search for commands related=
 to "word"...
>  =A0=A0=A0=A0=A0=A0=A0 Reading symbols from demo...done.
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (gdb) r
>  =A0=A0=A0=A0=A0=A0=A0 Starting program: /demo
>  =A0=A0=A0=A0=A0=A0=A0 [Thread debugging using libthread_db enabled]
>  =A0=A0=A0=A0=A0=A0=A0 Using host libthread_db library "/lib/libthread_db=
.so.1".
>  =A0=A0=A0=A0=A0=A0=A0 [New Thread 0xb6c61470 (LWP 432)]
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <<< BLOCKED. I press CTRL-=
C >>>
>  =A0=A0=A0=A0=A0=A0=A0 Thread 1 "demo" received signal SIGINT, Interrupt.
>  =A0=A0=A0=A0=A0=A0=A0 0xb6fa4d08 in __wrap_pthread_mutex_lock () from=20
> /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (gdb) c
>  =A0=A0=A0=A0=A0=A0=A0 Continuing.
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <<< BLOCKED. I press CTRL-=
C >>>
>  =A0=A0=A0=A0=A0=A0=A0 Thread 1 "demo" received signal SIGINT, Interrupt.
>  =A0=A0=A0=A0=A0=A0=A0 0xb6fa4d08 in __wrap_pthread_mutex_lock () from=20
> /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (gdb) c
>  =A0=A0=A0=A0=A0=A0=A0 Continuing.
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 <<< NOW DEMO RUN CORRECTLY=
 >>>
>=20
> BACKTRACE
>  =A0=A0=A0=A0=A0=A0=A0 If at [3] I use backtrace gdb command:
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (gdb) backtrace
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #0=A0 0xb6fa4d08 in __wrap=
_pthread_mutex_lock () from=20
> /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #1=A0 0xb6fa8cb2 in add_ex=
tent () from /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #2=A0 0xb6fa9122 in heapme=
m_init () from /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #3=A0 0xb6fc0db2 in heapob=
j_pkg_init_private () from=20
> /lib/libcopperplate.so.0
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #4=A0 0xb6fbe9d4 in copper=
plate_init () from=20
> /lib/libcopperplate.so.0
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #5=A0 0xb6fa9ae2 in __xeno=
mai_init () from=20
> /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #6=A0 0xb6fa9fbe in xenoma=
i_init () from /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #7=A0 0x00008928 in xenoma=
i_bootstrap ()
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #8=A0 0x00008b64 in __libc=
_csu_init ()
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #9=A0 0xb6e7af98 in __libc=
_start_main () from /lib/libc.so.6
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #10 0x00008966 in _start ()
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Backtrace stopped: previou=
s frame identical to this=20
> frame (corrupt stack?)
>=20
>  =A0=A0=A0=A0=A0=A0=A0 If at [4] I use backtrace gdb command:
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (gdb) backtrace
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #0=A0 0xb6fa4d08 in __wrap=
_pthread_mutex_lock () from=20
> /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #1=A0 0xb6fa8d9a in heapme=
m_alloc () from=20
> /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #2=A0 0xb6fbfaec in __thre=
adobj_alloc () from=20
> /lib/libcopperplate.so.0
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #3=A0 0xb6fc0318 in thread=
obj_pkg_init () from=20
> /lib/libcopperplate.so.0
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #4=A0 0xb6fbea28 in copper=
plate_init () from=20
> /lib/libcopperplate.so.0
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #5=A0 0xb6fa9ae2 in __xeno=
mai_init () from=20
> /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #6=A0 0xb6fa9fbe in xenoma=
i_init () from /lib/libcobalt.so.2
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #7=A0 0x00008928 in xenoma=
i_bootstrap ()
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #8=A0 0x00008b64 in __libc=
_csu_init ()
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #9=A0 0xb6e7af98 in __libc=
_start_main () from /lib/libc.so.6
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 #10 0x00008966 in _start ()
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Backtrace stopped: previou=
s frame identical to this=20
> frame (corrupt stack?)
>=20
>=20
> /proc/xenomai/sched
>  =A0=A0=A0=A0=A0=A0=A0 When gdb is blocked ([3] and [4]) I always have th=
is situation:
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /# cat /proc/xenomai/sched=
/stat
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 CPU=A0 PID=A0=A0=A0 MSW=A0=
=A0=A0=A0=A0=A0=A0 CSW=A0=A0=A0=A0=A0=A0=A0 XSC=A0=A0=A0=A0=A0=A0=A0 PF=20
> STAT=A0=A0=A0=A0=A0=A0 %CPU=A0 NAME
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0 0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 779=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 0=20
> 00018000=A0 100.0=A0 [ROOT]
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0 19165=A0 1=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 1=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=20
> 00460040=A0=A0=A0 0.0=A0 demo
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0 0=A0=A0=A0=A0=
=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 39725=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 0=20
> 00000000=A0=A0=A0 0.0=A0 [IRQ16: [timer]]
>=20
>=20
> DEMO.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =A0=A0=A0=A0=A0=A0=A0 #include <stdio.h>
>  =A0=A0=A0=A0=A0=A0=A0 #include <alchemy/task.h>
>=20
>  =A0=A0=A0=A0=A0=A0=A0 RT_TASK rt_task;
>  =A0=A0=A0=A0=A0=A0=A0 volatile unsigned int cnt;
>=20
>  =A0=A0=A0=A0=A0=A0=A0 void rt_inc_fn(void *dummy) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while(1) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cn=
t++;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rt=
_task_sleep(100*1000*1000);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0 }
>=20
>  =A0=A0=A0=A0=A0=A0=A0 int main(int argc, char **argv) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int ret;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D rt_task_create(&rt=
_task, "demo", 0, 50, 0);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 assert(ret=3D=3D0);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D rt_task_start(&rt_=
task, &rt_inc_fn, NULL);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 assert(ret=3D=3D0);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while(1) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 us=
leep(1000000);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr=
intf("%d\n", cnt);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0 }
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

