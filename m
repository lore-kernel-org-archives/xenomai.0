MIME-Version: 1.0
Date: Thu, 1 Sep 2011 09:49:55 +0800
Message-ID: <CAHoMn5p1K5c=f-WWTsK6S3pTULtFVAbszUaqaDp-CGteu=6SDw@domain.hid>
From: yi zheng <yizheng23@domain.hid>
Content-Type: multipart/alternative; boundary=001636ed6c7121f53b04abd776f9
Subject: [Xenomai-help] cann't find head file
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

--001636ed6c7121f53b04abd776f9
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi all
       I want to compile a kernel module.The source code file ,written by
native skin, prepared to compile is named "kernel-test.c".The comment of
makefile is described as follows=A3=BA
       ifneq ($(KERNELRELEASE),)
obj-m :=3Dkernel-test.o
else
KSRC ?=3D/usr/src/xenomai/linux-2.6.31.8
PWD     :=3D$(shell pwd)
default:
$(MAKE) -C  $(KSRC)    M=3D$(PWD)        modules
endif
        I tried to compile kernel module.Then I got:
make -I/usr/xenomai/include/  ARCH=3Darm CROSS_COMPILE=3Darm-linux-
make -C  /usr/src/xenomai/linux-2.6.31.8
 M=3D/home/zhengyi/xenomai-program/kernel        modules
make[1]: Entering directory `/usr/src/xenomai/linux-2.6.31.8'
  CC [M]  /home/zhengyi/xenomai-program/kernel/kernel-test.o
/home/zhengyi/xenomai-program/kernel/kernel-test.c:1:25: native/task.h: No
such file or directory
/home/zhengyi/xenomai-program/kernel/kernel-test.c:5: error: parse error
before "task_desc"
/home/zhengyi/xenomai-program/kernel/kernel-test.c:5: warning: type default=
s
to `int' in declaration of `task_desc'
/home/zhengyi/xenomai-program/kernel/kernel-test.c:5: warning: data
definition has no type or storage class
/home/zhengyi/xenomai-program/kernel/kernel-test.c: In function `task_body'=
:
/home/zhengyi/xenomai-program/kernel/kernel-test.c:9: error: implicit
declaration of function `printk'
/home/zhengyi/xenomai-program/kernel/kernel-test.c: In function
`init_module':
/home/zhengyi/xenomai-program/kernel/kernel-test.c:17: error: implicit
declaration of function `rt_task_create'
/home/zhengyi/xenomai-program/kernel/kernel-test.c:21: error: `T_FPU'
undeclared (first use in this function)
/home/zhengyi/xenomai-program/kernel/kernel-test.c:21: error: (Each
undeclared identifier is reported only once
/home/zhengyi/xenomai-program/kernel/kernel-test.c:21: error: for each
function it appears in.)
/home/zhengyi/xenomai-program/kernel/kernel-test.c:21: error: implicit
declaration of function `T_CPU'
/home/zhengyi/xenomai-program/kernel/kernel-test.c:23: error: implicit
declaration of function `rt_task_start'
/home/zhengyi/xenomai-program/kernel/kernel-test.c:23: error: `NULL'
undeclared (first use in this function)
/home/zhengyi/xenomai-program/kernel/kernel-test.c:24: error: implicit
declaration of function `pause'
/home/zhengyi/xenomai-program/kernel/kernel-test.c: In function
`cleanup_module':
/home/zhengyi/xenomai-program/kernel/kernel-test.c:29: error: implicit
declaration of function `rt_task_delete'
make[2]: *** [/home/zhengyi/xenomai-program/kernel/kernel-test.o] error 1
make[1]: *** [_module_/home/zhengyi/xenomai-program/kernel] error 2
make[1]: Leaving directory `/usr/src/xenomai/linux-2.6.31.8'
make: *** [default] error 2

It seems that my problem is caused by  Xenomai head file directory.How to
solve my proble?Thank you.
regards
yizheng

--001636ed6c7121f53b04abd776f9
Content-Type: text/html; charset=GB2312
Content-Transfer-Encoding: quoted-printable

Hi all<div>&nbsp; &nbsp; &nbsp; &nbsp;I want to compile a kernel module.The=
 source code file ,written by native skin, prepared to compile is named &qu=
ot;kernel-test.c&quot;.The comment of makefile is described as follows=A3=
=BA</div><div>&nbsp; &nbsp; &nbsp;&nbsp;<span class=3D"Apple-tab-span" styl=
e=3D"white-space:pre">	</span>ifneq ($(KERNELRELEASE),)</div>
<div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>obj-m=
 :=3Dkernel-test.o</div><div>else</div><div><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>KSRC ?=3D/usr/src/xenomai/linux-2.6.31.8<=
/div><div>
<span class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>PWD &nbsp;=
 &nbsp; :=3D$(shell pwd)</div><div>default:</div><div><span class=3D"Apple-=
tab-span" style=3D"white-space:pre">	</span>$(MAKE) -C &nbsp;$(KSRC) &nbsp;=
 &nbsp;M=3D$(PWD) &nbsp; &nbsp; &nbsp; &nbsp;modules</div>
<div>endif</div><div>&nbsp; &nbsp; &nbsp; &nbsp; I tried to compile kernel =
module.Then I got:</div><div><div>make -I/usr/xenomai/include/ &nbsp;ARCH=
=3Darm CROSS_COMPILE=3Darm-linux-</div><div>make -C &nbsp;/usr/src/xenomai/=
linux-2.6.31.8 &nbsp; &nbsp;M=3D/home/zhengyi/xenomai-program/kernel &nbsp;=
 &nbsp; &nbsp; &nbsp;modules</div>
<div>make[1]: Entering directory `/usr/src/xenomai/linux-2.6.31.8&#39;</div=
><div>&nbsp; CC [M] &nbsp;/home/zhengyi/xenomai-program/kernel/kernel-test.=
o</div><div>/home/zhengyi/xenomai-program/kernel/kernel-test.c:1:25: native=
/task.h: No such file or directory</div>
<div>/home/zhengyi/xenomai-program/kernel/kernel-test.c:5: error: parse err=
or before &quot;task_desc&quot;</div><div>/home/zhengyi/xenomai-program/ker=
nel/kernel-test.c:5: warning: type defaults to `int&#39; in declaration of =
`task_desc&#39;</div>
<div>/home/zhengyi/xenomai-program/kernel/kernel-test.c:5: warning: data de=
finition has no type or storage class</div><div>/home/zhengyi/xenomai-progr=
am/kernel/kernel-test.c: In function `task_body&#39;:</div><div>/home/zheng=
yi/xenomai-program/kernel/kernel-test.c:9: error: implicit declaration of f=
unction `printk&#39;</div>
<div>/home/zhengyi/xenomai-program/kernel/kernel-test.c: In function `init_=
module&#39;:</div><div>/home/zhengyi/xenomai-program/kernel/kernel-test.c:1=
7: error: implicit declaration of function `rt_task_create&#39;</div><div>
/home/zhengyi/xenomai-program/kernel/kernel-test.c:21: error: `T_FPU&#39; u=
ndeclared (first use in this function)</div><div>/home/zhengyi/xenomai-prog=
ram/kernel/kernel-test.c:21: error: (Each undeclared identifier is reported=
 only once</div>
<div>/home/zhengyi/xenomai-program/kernel/kernel-test.c:21: error: for each=
 function it appears in.)</div><div>/home/zhengyi/xenomai-program/kernel/ke=
rnel-test.c:21: error: implicit declaration of function `T_CPU&#39;</div>
<div>/home/zhengyi/xenomai-program/kernel/kernel-test.c:23: error: implicit=
 declaration of function `rt_task_start&#39;</div><div>/home/zhengyi/xenoma=
i-program/kernel/kernel-test.c:23: error: `NULL&#39; undeclared (first use =
in this function)</div>
<div>/home/zhengyi/xenomai-program/kernel/kernel-test.c:24: error: implicit=
 declaration of function `pause&#39;</div><div>/home/zhengyi/xenomai-progra=
m/kernel/kernel-test.c: In function `cleanup_module&#39;:</div><div>/home/z=
hengyi/xenomai-program/kernel/kernel-test.c:29: error: implicit declaration=
 of function `rt_task_delete&#39;</div>
<div>make[2]: *** [/home/zhengyi/xenomai-program/kernel/kernel-test.o] erro=
r 1</div><div>make[1]: *** [_module_/home/zhengyi/xenomai-program/kernel] e=
rror 2</div><div>make[1]: Leaving directory `/usr/src/xenomai/linux-2.6.31.=
8&#39;</div>
<div>make: *** [default] error 2</div></div><div><br></div><div>It seems th=
at my problem is caused by &nbsp;Xenomai head file directory.How to solve m=
y proble?Thank you.</div><div>regards</div><div>yizheng</div>

--001636ed6c7121f53b04abd776f9--

