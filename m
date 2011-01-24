Date: Mon, 24 Jan 2011 15:05:10 +0100 (CET)
From: Michel Rinaldi <automation.03@domain.hid>
Message-ID: <28136729.01295877908562.JavaMail.SYSTEM@PC-MRINALDI>
In-Reply-To: <4D3B2C93.70005@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_0_25175878.1295877908515"
Subject: Re: [Xenomai-help] Problems with rt_task_create and rt_task_join
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

------=_Part_0_25175878.1295877908515
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


> A reason for the service being so slow the first time it is called may 
> be the on-demand libraries loading. But for this to take a long time, 
> the native skin library would have to be stored on a really slow storage 
> device, or compressed and the processor you are using being a really 
> slow one. Anyway, you do not tell us on what architecture you get this 
> issue? What processor are you using? Where is the library stored? 
> 
> -- 
> Gilles. 

Hi to all, and thank you for your support. 

First of all, I'm running Xenomai on an Intel Celeron M 600MHz CPU with 512 MB RAM. 
This embedded PC has its storage unit onto a 2GB compact flash, connected to motherboard via ATA interface. 
Xenomai libraries are into default /usr/xenomai path, and seems not compressed. 
Linux distro is Ubuntu 10.04. Attached to this message there's my vanilla kernel configuration. 

I tried to check all Xenomai calls, they return no errors. 
rt_intr_wait() call returns -EIDRM only when interrupt object was deleted, no errors otherwise. 

I checked /proc/<pid>/maps to see if libraries are loaded correctly, and all seems to be OK. 

To deeply explain my software, some Xenomai syscalls are done into shared objects thata are loaded dinamically at runtime with dlopen()-dlclose() calls. Particularly, I launch my application, and at a certain time I dinamically load into my app an external piece of software contained into a shared object. 
This piece of software creates a rt task with rt_task_shadow() and contains a function that creates an IRQ handler: to do this, latter function calls rt_intr_create(), rt_task_create() and rt_task_start(). 
Next, I attach to my app another shared object that also creates a rt task with rt_task_shadow(). 
Then, if I call my function that creates IRQ handler into first loaded object (where function to create IRQ was contained), execution time is quick. 
Instead, if I call this function from latter shared object loaded, execution was horribly long (at least 500ms). 
These behaviours are independent from the fact that it is or not the first rt_task_create() into application. 
Could be this an issue related to dynamic loading? 

Another strange behaviour that I observed is that if I create IRQ handling thread not as joinable, if my call sequence is: 

rt_intr_delete(&myIntrHandler); 
rt_task_delete(&myIntrTask); 

I still see task into /proc/xenomai/sched (with X state), and rt_printf() strings subsequent to rt_task_delete() that are into same function don't appear. 
It seems to be that rt_task_delete() call destroys calling task instead target task. 

Instead, If sequence call is: 

rt_intr_delete(&myIntrHandler); 
rt_task_sleep(1000000000); 
rt_task_delete(&myIntrTask); 

I don't see at all task into /proc/xenomai/sched, and rt_printf() strings subsequent to rt_task_delete() was printed normally. 
Note that these calls are done when an object was dinamically unloaded with dlclose(). 

One more question, on rt_task_join(): manual says that the joined task must have been created by the same process that wants to join it: into this assertion, process means "a task" (then, a PID) or "a process composed by tasks"? I think the former. 
And if the process that calls rt_task_join() is not the same, could this cause the function doesn't returns? 

Finally, if this can help, I also observed these messages into dmesg: 
Clocksource tsc unstable (delta = 2636104979 ns) 
Switching to clocksource pit 
They appears when rt_task_create() is slow. 

Thank you in advance for your precious help. 
Regards 
Mauro 


------=_Part_0_25175878.1295877908515
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
><br>&gt; A reason for the service being so slow the first time it is calle=
d may<br>&gt; be the on-demand libraries loading. But for this to take a lo=
ng time,<br>&gt; the native skin library would have to be stored on a reall=
y slow storage<br>&gt; device, or compressed and the processor you are usin=
g being a really<br>&gt; slow one. Anyway, you do not tell us on what archi=
tecture you get this<br>&gt; issue? What processor are you using? Where is =
the library stored?<br>&gt;<br>&gt; -- <br>&gt;&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; Gilles.<br><br>Hi to al=
l, and thank you for your support.<br><br>First of all, I'm running Xenomai=
 on an Intel Celeron M 600MHz CPU with 512 MB RAM.<br>This embedded PC has =
its storage unit onto a 2GB compact flash, connected to motherboard via ATA=
 interface.<br>Xenomai libraries are into default /usr/xenomai path, and se=
ems not compressed.<br>Linux distro is Ubuntu 10.04. Attached to this messa=
ge there's my vanilla kernel configuration.<br><br>I tried to check all Xen=
omai calls, they return no errors.<br>rt_intr_wait() call returns -EIDRM on=
ly when interrupt object was deleted, no errors otherwise.<br><br>I checked=
 /proc/&lt;pid&gt;/maps to see if libraries are loaded correctly, and all s=
eems to be OK.<br><br>To deeply explain my software, some Xenomai syscalls =
are done into shared objects thata are loaded dinamically at runtime with d=
lopen()-dlclose() calls. Particularly, I launch my application, and at a ce=
rtain time I dinamically load into my app an external piece of software con=
tained into a shared object.<br>This piece of software creates a rt task wi=
th rt_task_shadow() and contains a function that creates an IRQ handler: to=
 do this, latter function calls rt_intr_create(), rt_task_create() and rt_t=
ask_start().<br>Next, I attach to my app another shared object that also cr=
eates a rt task with rt_task_shadow().<br>Then, if I call my function that =
creates IRQ handler into first loaded object (where function to create IRQ =
was contained), execution time is quick.<br>Instead, if I call this functio=
n from latter shared object loaded, execution was horribly long (at least 5=
00ms).<br>These behaviours are independent from the fact that it is or not =
the first rt_task_create() into application. <br>Could be this an issue rel=
ated to dynamic loading?<br><br>Another strange behaviour that I observed i=
s that if I create IRQ handling thread not as joinable, if my call sequence=
 is:<br><br>rt_intr_delete(&amp;myIntrHandler);<br>rt_task_delete(&amp;myIn=
trTask);<br><br>I still see task into /proc/xenomai/sched (with X state), a=
nd rt_printf() strings subsequent to rt_task_delete() that are into same fu=
nction don't appear.<br>It seems to be that rt_task_delete() call destroys =
calling task instead target task.<br><br>Instead, If sequence call is:<br><=
br>rt_intr_delete(&amp;myIntrHandler);<br>rt_task_sleep(1000000000);<br>rt_=
task_delete(&amp;myIntrTask);<br><br>I don't see at all task into /proc/xen=
omai/sched, and rt_printf() strings subsequent to rt_task_delete() was prin=
ted normally.<br>Note that these calls are done when an object was dinamica=
lly unloaded with dlclose().<br><br>One more question, on rt_task_join(): m=
anual says that the joined task must have been created by the same process =
that wants to join it: into this assertion, process means "a task" (then, a=
 PID) or "a process composed by tasks"? I think the former.<br>And if the p=
rocess that calls rt_task_join() is not the same, could this cause the func=
tion doesn't returns?<br><br>Finally, if this can help, I also observed the=
se messages into dmesg:<br>Clocksource tsc unstable (delta =3D 2636104979 n=
s)<br>Switching to clocksource pit<br>They appears when rt_task_create() is=
 slow.<br><br>Thank you in advance for your precious help.<br>Regards<br>Ma=
uro<br><br></div></body></html>
------=_Part_0_25175878.1295877908515--

