MIME-Version: 1.0
Date: Wed, 20 Oct 2010 22:28:54 +0200
Message-ID: <AANLkTimpBp3+w3thbLwCSiTz--h7HBZx+ZLtV4vhbemo@domain.hid>
From: ronny meeus <ronny.meeus@domain.hid>
Content-Type: multipart/alternative; boundary=000325574bbe18956904931242aa
Subject: [Xenomai-help] psos+ Skin: argument passing to task body sometimes
	failing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

--000325574bbe18956904931242aa
Content-Type: text/plain; charset=ISO-8859-1

Hello

it is me again.

This is the configuration I'm using: Target based on QEMU, Xenomai 2.5.4 and
the PSOS skin.
[    0.623238] Xenomai: hal/i386 started.
[    0.633758] Xenomai: scheduling class idle registered.
[    0.636172] Xenomai: scheduling class rt registered.
[    0.693178] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.
[    0.723234] Xenomai: starting native API services.
[    0.728107] Xenomai: starting pSOS+ services.

I sometimes observe issues in passing task arguments to the taskbody of the
pSOS task.
Observations:
1 During debugging I observe in 50% of the cases that all arguments of some
task are 0 (all 4). There is no issue with this task if the debugger is not
used.
2 During a task creation (in some scenarios) I see in 100% of the cases that
all arguments are 0 while the parameters are fine for other application
scenarios where the same code is used to create the task itself.

Conclusion: strange behavior is seen (looks like a race condition ...).

I did already some research in the code and on the web and came across
following thread:
http://www.mail-archive.com/xenomai@xenomai.org

This explains the mechanism and also talks about a problem that has been
resolved in this area.
I think there is still a gap somewhere.

This is how our code looks like (I removed the error checking for ease of
reading):

taskbody:
void  TaskApp::appTaskEntry(TaskApp *task)
{
   task->appTaskCode();
}

start_function:
unsigned long targs[4] = {this,0,0,0};
t_create(appTaskName_m,arg1_m,2048,0,0,&appTaskId_m);
t_start(appTaskId_m,tMode_m,(void (*)())appTaskEntry,targs);

As you can see the task arguments array is created on the stack of the
calling task.
Like I stated before, for some scenarios, this code is working fine, but for
other scenarios, it crashed while dereferencing the task pointer in the
"appTaskEntry" function.

For testing purposes I replaced the above code by:
unsigned long *targs = (unsigned long*)malloc(16);
targs[0] = (unsigned long)this;
targs[1] = targs[2] = targs[3] = 0;
t_create(appTaskName_m,arg1_m,2048,0,0,&appTaskId_m);
t_start(appTaskId_m,tMode_m,appTaskEntry,targs);

In this code I allocate the task array on the heap and never destroy it (I
know I have a memory leak).
After this change the code is working well and I never see an issue.

I already tried to create a simple example to narrow down the bad scenario
but I failed to reproduce it in a small testbuild.

Any suggestions are welcome.
Many thanks.

Best regards,
Ronny

--000325574bbe18956904931242aa
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>it is me again.<br><br>This is the configuration I&#39;m using=
: Target based on QEMU, Xenomai 2.5.4 and the PSOS skin.<br>[=A0=A0=A0 0.62=
3238] Xenomai: hal/i386 started.<br>[=A0=A0=A0 0.633758] Xenomai: schedulin=
g class idle registered.<br>
[=A0=A0=A0 0.636172] Xenomai: scheduling class rt registered.<br>
[=A0=A0=A0 0.693178] Xenomai: real-time nucleus v2.5.4 (Sleep Walk) loaded.=
<br>[=A0=A0=A0 0.723234] Xenomai: starting native API services.<br>[=A0=A0=
=A0 0.728107] Xenomai: starting pSOS+ services.<br><br>I sometimes observe =
issues in passing task arguments to the taskbody of the pSOS task.<br>
Observations:<br>1 During debugging I observe in 50% of the cases that all =
arguments of some task are 0 (all 4). There is no issue with this task if t=
he debugger is not used.<br>2 During a task creation (in some scenarios) I =
see in 100% of the cases that all arguments are 0 while the parameters are =
fine for other application scenarios where the same code is used to create =
the task itself.<br>
<br>Conclusion: strange behavior is seen (looks like a race condition ...).=
<br><br>I did already some research in the code and on the web and came acr=
oss following thread:<br><a href=3D"http://www.mail-archive.com/xenomai-cor=
e@domain.hid">http://www.mail-archive.com/xenomai@xenomai.org=
sg04470.html</a><br>
<br>This explains the mechanism and also talks about a problem that has bee=
n resolved in this area.<br>I think there is still a gap somewhere.<br><br>=
This is how our code looks like (I removed the error checking for ease of r=
eading):<br>
<br>taskbody:<br>
void=A0 TaskApp::appTaskEntry(TaskApp *task)<br>
{<br>
=A0=A0 task-&gt;appTaskCode();<br>
}<br><br>start_function:<br> unsigned long targs[4] =3D {this,0,0,0};<br>

t_create(appTaskName_m,arg1_m,2048,0,0,&amp;appTaskId_m);<br>
t_start(appTaskId_m,tMode_m,(void (*)())appTaskEntry,targs);<br>
<br>As you can see the task arguments array is created on the stack of the =
calling task.<br>Like I stated before, for some scenarios, this code is wor=
king fine, but for other scenarios, it crashed while dereferencing the task=
 pointer in the &quot;appTaskEntry&quot; function.<br>
<br>For testing purposes I replaced the above code by:<br>unsigned long *ta=
rgs =3D (unsigned long*)malloc(16);<br>

targs[0] =3D (unsigned long)this;<br>

targs[1] =3D targs[2] =3D targs[3] =3D 0;<br>

t_create(appTaskName_m,arg1_m,2048,0,0,&amp;appTaskId_m);<br>
t_start(appTaskId_m,tMode_m,appTaskEntry,targs);<br>
<br>In this code I allocate the task array on the heap and never destroy it=
 (I know I have a memory leak).<br>After this change the code is working we=
ll and I never see an issue.<br><br>I already tried to create a simple exam=
ple to narrow down the bad scenario but I failed to reproduce it in a small=
 testbuild.<br>
<br>Any suggestions are welcome.<br>Many thanks.<br><br>Best regards,<br>Ro=
nny<br>

--000325574bbe18956904931242aa--

