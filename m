Message-ID: <1342503849.55858.YahooMailNeo@web120606.mail.ne1.yahoo.com>
Date: Mon, 16 Jul 2012 22:44:09 -0700 (PDT)
From: Jignesh Patel <jigneshj.patel@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai 2.6.1 examlpe error
Reply-To: Jignesh Patel <jigneshj.patel@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "rgupta108@gmail.com" <rgupta108@gmail.com>, "patelilesh32@gmail.com" <patelilesh32@gmail.com>

Hi,=0A=0AThanks to Francois & everteq for your kind suggestion.=0A=0AI foun=
d CC_STACKPROTECTOR and i disable it so my kernel is compiled successfully.=
=0ANow I trying to execute example/native=0A=0AWhen i enter make command "X=
enomai =0A2.6.1/example/native # make" i found below error..=0A=0A =0A=0A=
=0Aroot@PC:/usr/src/xenomai-2.6.1/examples/native# make=0A=0Agcc -I/usr/xen=
omai/include -D_GNU_SOURCE -D_REENTRANT =0A-D_XENO_ =A0 -lnative -L/usr/xen=
omai/lib -lxenomai -lpthread =0A-lrt =A0-Xlinker -rpath -Xlinker /usr/xenom=
ai/lib =A0trivial-periodic.c =A0 -o trivial-periodic=0A=0A/tmp/ccHeeGhD.o: =
In function =0A`demo':=0A=0Atrivial-periodic.c:(.text+0x2f): undefined =0Ar=
eference to `rt_task_set_periodic'=0A=0Atrivial-periodic.c:(.text+0x34): un=
defined reference to `rt_timer_read'=0A=0Atrivial-periodic.c:(.text+0x46): =
undefined reference to `rt_task_wait_period'=0A=0Atrivial-periodic.c:(.text=
+0x4b): undefined reference to `rt_timer_read'=0A=0A/tmp/ccHeeGhD.o: In =0A=
function `main':=0A=0Atrivial-periodic.c:(.text+0x133): =0Aundefined refere=
nce to `rt_task_create'=0A=0Atrivial-periodic.c:(.text+0x14f): undefined re=
ference to `rt_task_start'=0A=0Atrivial-periodic.c:(.text+0x160): undefined=
 reference to `rt_task_delete'=0A=0Acollect2: ld =0Areturned 1 exit status=
=0A=0Amake: * [trivial-periodic] =0AError 1=0A=0A=0A=0AThanks,=0AJignesh Pa=
tel
