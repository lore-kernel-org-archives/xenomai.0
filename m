MIME-Version: 1.0
Date: Tue, 13 Dec 2011 12:08:45 +0800
Message-ID: <CAO0Fu5C6rX5wuFJkbdagJ-8z6txACSYX3zewS+Bxnp_8utbwWg@domain.hid>
From: Lifeng Wang <lfwangcn@domain.hid>
Content-Type: multipart/alternative; boundary=e89a8fb2043e5014d104b3f168bf
Subject: [Xenomai-help] When startup the preemptive priority-base scheduling,
 at the start pont, I observed the output with wrong order.
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

--e89a8fb2043e5014d104b3f168bf
Content-Type: text/plain; charset=ISO-8859-1

########################################################
[root@domain.hid examples]# make
--xeno-cflags is deprecated, use --skin=name --cflags instead
--xeno-ldflags is deprecated, use --skin=name --ldflags instead
gcc -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall
-Werror-implicit-function-declaration -pipe -D__XENO__   -L/usr/xenomai/lib
-lxenomai -lpthread -lrt  -lnative -Xlinker -rpath -Xlinker
/usr/xenomai/lib  test.c   -o test

[root@domain.hid examples]# ./test

Please press Ctrl-c to end the program
Xenomai: Initialization successed

Multi-tasking creat and start now.
Task_00: Creat and Start now.
Task_01: Creat and Start now.
Task_02: Creat and Start now.
Task_03: Creat and Start now.
Task_04: Creat and Start now.
Task_05: Creat and Start now.
Task_06: Creat and Start now.
Task_07: Creat and Start now.

Multi-tasking scheduling now. Have fun.
Task_00 is runned:1times; Task_00_Prio:90
Task_01 is runned:1times; Task_01_Prio:80
Task_02 is runned:1times; Task_02_Prio:70
Task_05 is runned:1times; Task_05_Prio:40
Task_03 is runned:1times; Task_03_Prio:60
Task_06 is runned:1times; Task_06_Prio:30
Task_04 is runned:1times; Task_04_Prio:50
Task_07 is runned:1times; Task_07_Prio:20

Task_00 is runned:2times; Task_00_Prio:90
Task_01 is runned:2times; Task_01_Prio:80
Task_02 is runned:2times; Task_02_Prio:70
Task_03 is runned:2times; Task_03_Prio:60
Task_04 is runned:2times; Task_04_Prio:50
Task_05 is runned:2times; Task_05_Prio:40
Task_06 is runned:2times; Task_06_Prio:30
Task_07 is runned:2times; Task_07_Prio:20

Task_00 is runned:3times; Task_00_Prio:90
Task_01 is runned:3times; Task_01_Prio:80
Task_02 is runned:3times; Task_02_Prio:70
Task_03 is runned:3times; Task_03_Prio:60
Task_04 is runned:3times; Task_04_Prio:50
Task_05 is runned:3times; Task_05_Prio:40
Task_06 is runned:3times; Task_06_Prio:30
Task_07 is runned:3times; Task_07_Prio:20

^C
[root@domain.hid examples]#

##################################################################
Fedora 14 Linux kernel-2.6.35.9
Xenomai-2.6.0

This example program contains eight tasks with different prioities.
The Task_00 has the highest priority. The Task_07 has the lowest priority.
Each task can run and delay the same time of 1 second.

My question is that. When startup the preemptive priority-base
scheduling,at the start pont,
I observed the output:
Multi-tasking scheduling now. Have fun.
Task_00 is runned:1times; Task_00_Prio:90
Task_01 is runned:1times; Task_01_Prio:80
Task_02 is runned:1times; Task_02_Prio:70
Task_05 is runned:1times; Task_05_Prio:40  :Why?
Task_03 is runned:1times; Task_03_Prio:60  :Why?
Task_06 is runned:1times; Task_06_Prio:30  :Why?
Task_04 is runned:1times; Task_04_Prio:50  :Why?
Task_07 is runned:1times; Task_07_Prio:20

But I think that,the correct output shoud be that and must be that:
Task_00 is runned:1times; Task_00_Prio:90
Task_01 is runned:1times; Task_01_Prio:80
Task_02 is runned:1times; Task_02_Prio:70
Task_03 is runned:1times; Task_03_Prio:60
Task_04 is runned:1times; Task_04_Prio:50
Task_05 is runned:1times; Task_05_Prio:40
Task_06 is runned:1times; Task_06_Prio:30
Task_07 is runned:1times; Task_07_Prio:20

Why is it not?
Can someone tell me why and tell me how to write the correct code for the
preemptive priority-base scheduling.

Happy new year to everyone.

Wang Lifeng
lfwangcn@domain.hid
>From Suzhou,China

--e89a8fb2043e5014d104b3f168bf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span class=3D"Apple-style-span" style=3D"font-family:arial,sans-serif;font=
-size:13px;border-collapse:collapse">######################################=
##################<br>[root@domain.hid examples]# make<br>--xeno-cflags is depre=
cated, use --skin=3Dname --cflags instead<br>
--xeno-ldflags is deprecated, use --skin=3Dname --ldflags instead<br>gcc -I=
/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall<br>-Werror-implicit-f=
unction-declaration -pipe -D__XENO__ =A0 -L/usr/xenomai/lib<br>-lxenomai -l=
pthread -lrt =A0-lnative -Xlinker -rpath -Xlinker<br>
/usr/xenomai/lib =A0test.c =A0 -o test<br><br>[root@domain.hid examples]# ./test=
<br><br>Please press Ctrl-c to end the program<br>Xenomai: Initialization s=
uccessed<br><br>Multi-tasking creat and start now.<br>Task_00: Creat and St=
art now.<br>
Task_01: Creat and Start now.<br>Task_02: Creat and Start now.<br>Task_03: =
Creat and Start now.<br>Task_04: Creat and Start now.<br>Task_05: Creat and=
 Start now.<br>Task_06: Creat and Start now.<br>Task_07: Creat and Start no=
w.<br>
<br>Multi-tasking scheduling now. Have fun.<br>Task_00 is runned:1times; Ta=
sk_00_Prio:90<br>Task_01 is runned:1times; Task_01_Prio:80<br>Task_02 is ru=
nned:1times; Task_02_Prio:70<br>Task_05 is runned:1times; Task_05_Prio:40<b=
r>
Task_03 is runned:1times; Task_03_Prio:60<br>Task_06 is runned:1times; Task=
_06_Prio:30<br>Task_04 is runned:1times; Task_04_Prio:50<br>Task_07 is runn=
ed:1times; Task_07_Prio:20<br><br>Task_00 is runned:2times; Task_00_Prio:90=
<br>
Task_01 is runned:2times; Task_01_Prio:80<br>Task_02 is runned:2times; Task=
_02_Prio:70<br>Task_03 is runned:2times; Task_03_Prio:60<br>Task_04 is runn=
ed:2times; Task_04_Prio:50<br>Task_05 is runned:2times; Task_05_Prio:40<br>
Task_06 is runned:2times; Task_06_Prio:30<br>Task_07 is runned:2times; Task=
_07_Prio:20<br><br>Task_00 is runned:3times; Task_00_Prio:90<br>Task_01 is =
runned:3times; Task_01_Prio:80<br>Task_02 is runned:3times; Task_02_Prio:70=
<br>
Task_03 is runned:3times; Task_03_Prio:60<br>Task_04 is runned:3times; Task=
_04_Prio:50<br>Task_05 is runned:3times; Task_05_Prio:40<br>Task_06 is runn=
ed:3times; Task_06_Prio:30<br>Task_07 is runned:3times; Task_07_Prio:20<br>
<br>^C<br>[root@domain.hid examples]#<br><br>###################################=
###############################<br>Fedora 14 Linux kernel-2.6.35.9<br>Xenom=
ai-2.6.0<br><br>This example program contains eight tasks with different pr=
ioities.<br>
The Task_00 has the highest priority. The Task_07 has the lowest priority.<=
br>Each task can run and delay the same time of 1 second.<br><br>My questio=
n is that. When startup the preemptive priority-base<br>scheduling,at the s=
tart pont,<br>
I observed the output:<br>Multi-tasking scheduling now. Have fun.<br>Task_0=
0 is runned:1times; Task_00_Prio:90<br>Task_01 is runned:1times; Task_01_Pr=
io:80<br>Task_02 is runned:1times; Task_02_Prio:70<br>Task_05 is runned:1ti=
mes; Task_05_Prio:40 =A0:Why?<br>
Task_03 is runned:1times; Task_03_Prio:60 =A0:Why?<br>Task_06 is runned:1ti=
mes; Task_06_Prio:30 =A0:Why?<br>Task_04 is runned:1times; Task_04_Prio:50 =
=A0:Why?<br>Task_07 is runned:1times; Task_07_Prio:20<br><br>But I think th=
at,the correct output shoud be that and must be that:<br>
Task_00 is runned:1times; Task_00_Prio:90<br>Task_01 is runned:1times; Task=
_01_Prio:80<br>Task_02 is runned:1times; Task_02_Prio:70<br>Task_03 is runn=
ed:1times; Task_03_Prio:60<br>Task_04 is runned:1times; Task_04_Prio:50<br>
Task_05 is runned:1times; Task_05_Prio:40<br>Task_06 is runned:1times; Task=
_06_Prio:30<br>Task_07 is runned:1times; Task_07_Prio:20<br><br>Why is it n=
ot?<br>Can someone tell me why and tell me how to write the correct code fo=
r the<br>
preemptive priority-base scheduling.<br><br>Happy new year to everyone.<br>=
<br>Wang Lifeng<br><a href=3D"mailto:lfwangcn@domain.hid" style=3D"color:rgb=
(0,0,204)">lfwangcn@domain.hid</a><br>&gt;From Suzhou,China</span>

--e89a8fb2043e5014d104b3f168bf--

