MIME-Version: 1.0
Date: Tue, 15 May 2012 16:43:27 +0200
Message-ID: <CAGq8jPhw7HbA2tJxt9GnJfGDoqCTtJfQ-9jDij9vd7jwKcQkEQ@mail.gmail.com>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=20cf303f6bb6bbf8d304c0143959
Subject: [Xenomai-core] rt_dev_write function caused memory leak
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--20cf303f6bb6bbf8d304c0143959
Content-Type: text/plain; charset=ISO-8859-1

hello everybody,

When i make run cross-link program, i don't understand why there is a leak
memory. After looking the cross-link code,  i think the problem comes from
rt_dev_write().

I observe the leak memory by the command *'top'* in linux terminal. i wait
the *used memory* to be stable, and then i launch the cross-link program

Here, i copy the screen of my computer after the command *'top'*, the *used
memory* don't stop to increase constantly. I believe that i run any other
programs.

top - 12:04:23 up 43 min,  4 users,  load average: 0.01, 0.02, 0.05
Tasks: 119 total,   1 running, 118 sleeping,   0 stopped,   0 zombie
Cpu(s):  6.7%us, 21.7%sy,  0.0%ni, 71.7%id,  0.0%wa,  0.0%hi,  0.0%si,
 0.0%st
*Mem:    949708k total,   595568k used,   354140k free*,    18572k buffers
Swap:  1873916k total,        0k used,  1873916k free,   367128k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND

 1329 root      20   0  163m  74m 6720 S 11.0  8.1   1:16.19 Xorg

 2007 giang     20   0  209m  15m  10m S  4.7  1.7   0:12.21 gnome-terminal

    1 root      20   0  8404  764  636 S  0.0  0.1   0:03.36 init

    2 root      20   0     0    0    0 S  0.0  0.0   0:00.00 kthreadd

    3 root      20   0     0    0    0 S  0.0  0.0   0:00.03 ksoftirqd/0

    6 root      RT   0     0    0    0 S  0.0  0.0   0:00.00 migration/0

    7 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 cpuset

    8 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 khelper

    9 root       0 -20     0    0    0 S  0.0  0.0   0:00.00 netns

   10 root      20   0     0    0    0 S  0.0  0.0   0:00.00 sync_supers


Thanks,

my configuration is Debian6.04, linux 2.6.38, xenomai 2.6.

--20cf303f6bb6bbf8d304c0143959
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello everybody,<div><br></div><div><span style>When i make run cross-link =
program, i=A0</span><span style>don&#39;t understand why there is a leak me=
mory. After looking the cross-link code,=A0</span><span style>=A0</span><sp=
an style>i think the=A0</span><span style>problem comes from rt_dev_write()=
.=A0</span></div>
<div><span style><br></span></div><div><span style>I</span><span style>=A0o=
bserve the leak memory by the command <b>&#39;top&#39;</b> in linux termina=
l. i wait the <b>used memory</b> to be stable, and then i launch the cross-=
link program</span></div>
<div><span style><br></span></div><div><span style>Here, i copy the screen =
of my computer after the command <b>&#39;top&#39;</b>, the <b>used memory</=
b> don&#39;t stop to increase constantly. I believe that i run any other pr=
ograms.</span><br style>
<br style><div class=3D"gmail_extra" style><div class=3D"gmail_extra">top -=
 12:04:23 up 43 min, =A04 users, =A0load average: 0.01, 0.02, 0.05</div><di=
v class=3D"gmail_extra">Tasks: 119 total, =A0 1 running, 118 sleeping, =A0 =
0 stopped, =A0 0 zombie</div>
<div class=3D"gmail_extra">Cpu(s): =A06.7%us, 21.7%sy, =A00.0%ni, 71.7%id, =
=A00.0%wa, =A00.0%hi, =A00.0%si, =A00.0%st</div><div class=3D"gmail_extra">=
<b>Mem: =A0 =A0949708k total, =A0 595568k used, =A0 354140k free</b>, =A0 =
=A018572k buffers</div><div class=3D"gmail_extra">
Swap: =A01873916k total, =A0 =A0 =A0 =A00k used, =A01873916k free, =A0 3671=
28k cached</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ex=
tra">=A0 PID USER =A0 =A0 =A0PR =A0NI =A0VIRT =A0RES =A0SHR S %CPU %MEM =A0=
 =A0TIME+ =A0COMMAND =A0 =A0 =A0 =A0 =A0 =A0 =A0</div>
<div class=3D"gmail_extra">=A01329 root =A0 =A0 =A020 =A0 0 =A0163m =A074m =
6720 S 11.0 =A08.1 =A0 1:16.19 Xorg =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0</div=
><div class=3D"gmail_extra">=A02007 giang =A0 =A0 20 =A0 0 =A0209m =A015m =
=A010m S =A04.7 =A01.7 =A0 0:12.21 gnome-terminal =A0 =A0 =A0=A0</div>
<div class=3D"gmail_extra">=A0 =A0 1 root =A0 =A0 =A020 =A0 0 =A08404 =A076=
4 =A0636 S =A00.0 =A00.1 =A0 0:03.36 init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=A0</div><div class=3D"gmail_extra">=A0 =A0 2 root =A0 =A0 =A020 =A0 0 =A0 =
=A0 0 =A0 =A00 =A0 =A00 S =A00.0 =A00.0 =A0 0:00.00 kthreadd =A0 =A0 =A0 =
=A0 =A0 =A0=A0</div>
<div class=3D"gmail_extra">=A0 =A0 3 root =A0 =A0 =A020 =A0 0 =A0 =A0 0 =A0=
 =A00 =A0 =A00 S =A00.0 =A00.0 =A0 0:00.03 ksoftirqd/0 =A0 =A0 =A0 =A0 =A0<=
/div><div class=3D"gmail_extra">=A0 =A0 6 root =A0 =A0 =A0RT =A0 0 =A0 =A0 =
0 =A0 =A00 =A0 =A00 S =A00.0 =A00.0 =A0 0:00.00 migration/0 =A0 =A0 =A0 =A0=
 =A0</div>
<div class=3D"gmail_extra">=A0 =A0 7 root =A0 =A0 =A0 0 -20 =A0 =A0 0 =A0 =
=A00 =A0 =A00 S =A00.0 =A00.0 =A0 0:00.00 cpuset =A0 =A0 =A0 =A0 =A0 =A0 =
=A0=A0</div><div class=3D"gmail_extra">=A0 =A0 8 root =A0 =A0 =A0 0 -20 =A0=
 =A0 0 =A0 =A00 =A0 =A00 S =A00.0 =A00.0 =A0 0:00.00 khelper =A0 =A0 =A0 =
=A0 =A0 =A0 =A0</div>
<div class=3D"gmail_extra">=A0 =A0 9 root =A0 =A0 =A0 0 -20 =A0 =A0 0 =A0 =
=A00 =A0 =A00 S =A00.0 =A00.0 =A0 0:00.00 netns =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0</div><div class=3D"gmail_extra">=A0 =A010 root =A0 =A0 =A020 =A0 0 =A0=
 =A0 0 =A0 =A00 =A0 =A00 S =A00.0 =A00.0 =A0 0:00.00 sync_supers =A0</div><=
div class=3D"gmail_extra">
<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">T=
hanks,</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"=
>my configuration is Debian6.04, linux 2.6.38, xenomai 2.6.</div></div></di=
v>

--20cf303f6bb6bbf8d304c0143959--

