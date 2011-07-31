MIME-Version: 1.0
Date: Sun, 31 Jul 2011 11:53:26 +0200
Message-ID: <CAL+uwv-3zztxa3VKmmN74kwf136J4wmJpvFe092=ckbUCMv9UA@mail.gmail.com>
From: suresh reddy <sureshreddy.balijepalli@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3071cd7e74af5a04a95a7c34
Subject: [Xenomai-help] userspace applications
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--20cf3071cd7e74af5a04a95a7c34
Content-Type: text/plain; charset=ISO-8859-1

Dear Xenomai Team,


below is the simple program i want to run on xenomai ported pandaboard.The
make file iam using is as follows . what exactly i have to do

to compile and link this example to run on the arm based target board with
this make file.






#include <stdio.h>

#include <signal.h>

#include <unistd.h>

#include <sys/mman.h>



#include <native/task.h>

#include <native/timer.h>



#include  <rtdk.h>

RT_TASK demo_task;



void demo(void *arg)

{

  RT_TASK *curtask;

  RT_TASK_INFO curtaskinfo;



  // hello world

  rt_printf("Hello World!\n");



  // inquire current task

  curtask=rt_task_self();

  rt_task_inquire(curtask,&curtaskinfo);



  // print task name

  rt_printf("Task name : %s \n", curtaskinfo.name);

}



int main(int argc, char* argv[])

{

  char  str[10] ;



  // Perform auto-init of rt_print buffers if the task doesn't do so

  rt_print_auto_init(1);



  // Lock memory : avoid memory swapping for this program

  mlockall(MCL_CURRENT|MCL_FUTURE);



  rt_printf("start task\n");



  /*

   * Arguments: &task,

   *            name,

   *            stack size (0=default),

   *            priority,

   *            mode (FPU, start suspended, ...)

   */

  sprintf(str,"hello");

  rt_task_create(&demo_task, str, 0, 50, 0);



  /*

   * Arguments: &task,

   *            task function,

   *            function argument

   */

  rt_task_start(&demo_task, &demo, 0);
}

Make file.

###### CONFIGURATION ######

### List of applications to be build
APPLICATIONS = ex01

### Note: to override the search path for the xeno-config script, use
"make XENO=..."


### List of modules to be build
MODULES =

### Note: to override the kernel source path, use "make KSRC=..."



###### USER SPACE BUILD (no change required normally) ######
ifeq ($(KERNELRELEASE),)
ifneq ($(APPLICATIONS),)

### Default Xenomai installation path
XENO ?= /usr/xenomai

XENOCONFIG=$(shell PATH=$(XENO):$(XENO)/bin:$(PATH) which xeno-config
2>/dev/null)

### Sanity check
ifeq ($(XENOCONFIG),)
all::
	@echo ">>> Invoke make like this: \"make XENO=/path/to/xeno-config\" <<<"
	@echo
endif


CC=$(shell $(XENOCONFIG) --cc)

CFLAGS=$(shell $(XENOCONFIG) --xeno-cflags) $(MY_CFLAGS)

LDFLAGS=$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative

# This includes the library path of given Xenomai into the binary to make live
# easier for beginners if Xenomai's libs are not in any default search path.
LDFLAGS+=-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)

LDFLAGS+= -lrtdk

all:: $(APPLICATIONS)

clean::
	$(RM) $(APPLICATIONS) *.o

endif
endif



###### SPECIAL TARGET RULES ######
rtprint: rtprint.c
	$(CC) $(CFLAGS) $? $(LDFLAGS) -lrtdk -o $@



###### KERNEL MODULE BUILD (no change required normally) ######
ifneq ($(MODULES),)

### Default to sources of currently running kernel
KSRC ?= /lib/modules/$(shell uname -r)/build

OBJS     := ${patsubst %, %.o, $(MODULES)}
CLEANMOD := ${patsubst %, .%*, $(MODULES)}
PWD      := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)

### Kernel 2.6
ifeq ($(findstring 2.6,$(KSRC)),2.6)

obj-m        := $(OBJS)
EXTRA_CFLAGS := -I$(KSRC)/include/xenomai
-I$(KSRC)/include/xenomai/posix $(ADD_CFLAGS)

all::
	$(MAKE) -C $(KSRC) SUBDIRS=$(PWD) modules

### Kernel 2.4
else

ARCH    ?= $(shell uname -i)
INCLUDE := -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat
-I$(KSRC)/include/xenomai/posix
CFLAGS  += $(shell $(MAKE) -s -C $(KSRC) CC=$(CC) ARCH=$(ARCH)
SUBDIRS=$(PWD) modules) $(INCLUDE)

all:: $(OBJS)

endif

## Target for capturing 2.4 module CFLAGS
modules:
	@echo "$(CFLAGS)"

clean::
	$(RM) $(CLEANMOD) *.o *.ko *.mod.c Module*.symvers
	$(RM) -R .tmp*

endif



-- 

Suresh balijepalli
Rosenehim,Baveria.

--20cf3071cd7e74af5a04a95a7c34
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p class=3D"MsoNormal" style=3D""><span style=3D"font-size=
: 10pt; font-family: &quot;Courier New&quot;;">Dear Xenomai Team,</span></p=
><p class=3D"MsoNormal" style=3D""><br><span style=3D"font-size: 10pt; font=
-family: &quot;Courier New&quot;;"></span></p>
<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">below is the simple program i want to run on =
xenomai ported pandaboard.The make file iam using is as follows . what exac=
tly i have to do <br>
</span></p><p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt=
; font-family: &quot;Courier New&quot;;">to compile and link this example t=
o run on the arm based target board with this make file.<br></span></p><p c=
lass=3D"MsoNormal" style=3D"">
<br><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;;">=
</span></p><p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt=
; font-family: &quot;Courier New&quot;;"><br></span></p><p class=3D"MsoNorm=
al" style=3D"">
<span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;;"><br>=
</span></p><p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt=
; font-family: &quot;Courier New&quot;;"><br></span></p><p class=3D"MsoNorm=
al" style=3D"">
<span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;;"><br>=
</span></p><p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt=
; font-family: &quot;Courier New&quot;;">#include &lt;<span class=3D"SpellE=
">stdio.h</span>&gt;</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">#include &lt;<span class=3D"SpellE">signal.h<=
/span>&gt;</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">#include &lt;<span class=3D"SpellE">unistd.h<=
/span>&gt;</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">#include &lt;sys/<span class=3D"SpellE">mman.=
h</span>&gt;</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">#include &lt;native/<span class=3D"SpellE">ta=
sk.h</span>&gt;</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">#include &lt;native/<span class=3D"SpellE">ti=
mer.h</span>&gt;</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">#<span class=3D"GramE">include<span style=3D"=
">=A0 </span>&lt;</span><span class=3D"SpellE">rtdk.h</span>&gt;</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">RT_TASK <span class=3D"SpellE">demo_task</spa=
n>;</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span class=3D"GramE"><span style=3D"font=
-size: 10pt; font-family: &quot;Courier New&quot;;">void</span></span><span=
 style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;;"> demo(voi=
d *<span class=3D"SpellE">arg</span>)</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">{</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>RT_TASK *<span cl=
ass=3D"SpellE">curtask</span>;</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>RT_TASK_</span><s=
pan style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;;">INFO</=
span><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;;"=
> <span class=3D"SpellE">curtaskinfo</span>;</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>// hello world</s=
pan></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE">rt_<span class=3D"GramE">printf</span></span><span class=3D"GramE">(<=
/span>&quot;Hello World!\n&quot;);</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>// inquire curren=
t task</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE"><span class=3D"GramE">curtask</span></span><span class=3D"GramE">=3D<=
/span><span class=3D"SpellE">rt_task_self</span>();</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE">rt_task_<span class=3D"GramE">inquire</span></span><span class=3D"Gra=
mE">(</span><span class=3D"SpellE">curtask,&amp;curtaskinfo</span>);</span>=
</p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>// print task nam=
e</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE">rt_<span class=3D"GramE">printf</span></span><span class=3D"GramE">(<=
/span>&quot;Task name : %s \n&quot;, <span class=3D"SpellE"><a href=3D"http=
://curtaskinfo.name">curtaskinfo.name</a></span>);</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">}</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span class=3D"SpellE"><span class=3D"Gra=
mE"><span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;;">=
int</span></span></span><span style=3D"font-size: 10pt; font-family: &quot;=
Courier New&quot;;"> main(<span class=3D"SpellE">int</span>
<span class=3D"SpellE">argc</span>, char* <span class=3D"SpellE">argv</span=
>[])</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">{</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Gr=
amE">char<span style=3D"">=A0 </span><span class=3D"SpellE">str</span></spa=
n>[10] ;</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>// <span class=3D=
"GramE">Perform</span> auto-init
of <span class=3D"SpellE">rt_print</span> buffers if the task doesn&#39;t d=
o so</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE">rt_print_auto_<span class=3D"GramE">init</span></span><span class=3D"=
GramE">(</span>1);</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>// Lock <span cla=
ss=3D"GramE">memory :</span>
avoid memory swapping for this program</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE"><span class=3D"GramE">mlockall</span></span><span class=3D"GramE">(</=
span></span><span style=3D"font-size: 10pt; font-family: &quot;Courier New&=
quot;;">MCL</span><span style=3D"font-size: 10pt; font-family: &quot;Courie=
r New&quot;;">_CURRENT|</span><span style=3D"font-size: 10pt; font-family: =
&quot;Courier New&quot;;">MCL</span><span style=3D"font-size: 10pt; font-fa=
mily: &quot;Courier New&quot;;">_FUTURE);</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE">rt_<span class=3D"GramE">printf</span></span><span class=3D"GramE">(<=
/span>&quot;start task\n&quot;);</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>/*</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>* Arguments: &=
amp;task,</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>*<span style=
=3D"">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
</span><span class=3D"GramE">name</span>,</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>*<span style=
=3D"">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
</span>stack size (0=3Ddefault),</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>*<span style=
=3D"">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
</span><span class=3D"GramE">priority</span>,</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>*<span style=
=3D"">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
</span><span class=3D"GramE">mode</span> (</span><span style=3D"font-size: =
10pt; font-family: &quot;Courier New&quot;;">FPU</span><span style=3D"font-=
size: 10pt; font-family: &quot;Courier New&quot;;">, start suspended, ...)<=
/span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>*/</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE"><span class=3D"GramE">sprintf</span></span><span class=3D"GramE">(</s=
pan><span class=3D"SpellE">str,&quot;hello</span>&quot;);</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE">rt_task_<span class=3D"GramE">create</span></span><span class=3D"Gram=
E">(</span>&amp;<span class=3D"SpellE">demo_task</span>, <span class=3D"Spe=
llE">str</span>, 0, 50, 0);</span></p>


<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;">=A0</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span>/*</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>* Arguments: &=
amp;task,</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>*<span style=
=3D"">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
</span><span class=3D"GramE">task</span> function,</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>*<span style=
=3D"">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0
</span><span class=3D"GramE">function</span> argument</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0=A0 </span>*/</span></p>

<p class=3D"MsoNormal" style=3D""><span style=3D"font-size: 10pt; font-fami=
ly: &quot;Courier New&quot;;"><span style=3D"">=A0 </span><span class=3D"Sp=
ellE">rt_task_<span class=3D"GramE">start</span></span><span class=3D"GramE=
">(</span>&amp;<span class=3D"SpellE">demo_task</span>, &amp;demo, 0);</spa=
n></p>


<span style=3D"font-size: 10pt; font-family: &quot;Courier New&quot;;">}<br=
><br>Make file.<br><br></span><pre>###### CONFIGURATION ######<br><br>### L=
ist of applications to be build<br>APPLICATIONS =3D ex01<br><br>### Note: t=
o override the search path for the xeno-config script, use &quot;make XENO=
=3D...&quot;<br>
<br><br>### List of modules to be build<br>MODULES =3D<br><br>### Note: to =
override the kernel source path, use &quot;make KSRC=3D...&quot;<br><br><br=
><br>###### USER SPACE BUILD (no change required normally) ######<br>ifeq (=
$(KERNELRELEASE),)<br>
ifneq ($(APPLICATIONS),)<br><br>### Default Xenomai installation path<br>XE=
NO ?=3D /usr/xenomai<br><br>XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin=
:$(PATH) which xeno-config 2&gt;/dev/null)<br><br>### Sanity check<br>ifeq =
($(XENOCONFIG),)<br>
all::<br>	@echo &quot;&gt;&gt;&gt; Invoke make like this: \&quot;make XENO=
=3D/path/to/xeno-config\&quot; &lt;&lt;&lt;&quot;<br>	@echo<br>endif<br><br=
><br>CC=3D$(shell $(XENOCONFIG) --cc)<br><br>CFLAGS=3D$(shell $(XENOCONFIG)=
 --xeno-cflags) $(MY_CFLAGS)<br>
<br>LDFLAGS=3D$(shell $(XENOCONFIG) --xeno-ldflags) $(MY_LDFLAGS) -lnative<=
br><br># This includes the library path of given Xenomai into the binary to=
 make live<br># easier for beginners if Xenomai&#39;s libs are not in any d=
efault search path.<br>
LDFLAGS+=3D-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)<br><br>=
LDFLAGS+=3D -lrtdk<br><br>all:: $(APPLICATIONS)<br><br>clean::<br>	$(RM) $(=
APPLICATIONS) *.o<br><br>endif<br>endif<br><br><br><br>###### SPECIAL TARGE=
T RULES ######<br>
rtprint: rtprint.c<br>	$(CC) $(CFLAGS) $? $(LDFLAGS) -lrtdk -o $@<br><br><b=
r><br>###### KERNEL MODULE BUILD (no change required normally) ######<br>if=
neq ($(MODULES),)<br><br>### Default to sources of currently running kernel=
<br>
KSRC ?=3D /lib/modules/$(shell uname -r)/build<br><br>OBJS     :=3D ${patsu=
bst %, %.o, $(MODULES)}<br>CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}<br>=
PWD      :=3D $(shell if [ &quot;$$PWD&quot; !=3D &quot;&quot; ]; then echo=
 $$PWD; else pwd; fi)<br>
<br>### Kernel 2.6<br>ifeq ($(findstring 2.6,$(KSRC)),2.6)<br><br>obj-m    =
    :=3D $(OBJS)<br>EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/i=
nclude/xenomai/posix $(ADD_CFLAGS)<br><br>all::<br>	$(MAKE) -C $(KSRC) SUBD=
IRS=3D$(PWD) modules<br>
<br>### Kernel 2.4<br>else<br><br>ARCH    ?=3D $(shell uname -i)<br>INCLUDE=
 :=3D -I$(KSRC)/include/xenomai -I$(KSRC)/include/xenomai/compat -I$(KSRC)/=
include/xenomai/posix<br>CFLAGS  +=3D $(shell $(MAKE) -s -C $(KSRC) CC=3D$(=
CC) ARCH=3D$(ARCH) SUBDIRS=3D$(PWD) modules) $(INCLUDE)<br>
<br>all:: $(OBJS)<br><br>endif<br><br>## Target for capturing 2.4 module CF=
LAGS<br>modules:<br>	@echo &quot;$(CFLAGS)&quot;<br><br>clean::<br>	$(RM) $=
(CLEANMOD) *.o *.ko *.mod.c Module*.symvers<br>	$(RM) -R .tmp*<br><br>endif=
<br>
</pre><br clear=3D"all"><br>-- <br><br>Suresh balijepalli<br>Rosenehim,Bave=
ria.<br>
</div>

--20cf3071cd7e74af5a04a95a7c34--

