Date: Thu, 28 Apr 2011 11:26:27 +0200 (CEST)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <3161507.241303982782859.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <27947354.221303982673109.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_21_30682745.1303982782859"
Subject: Re: [Xenomai-help] rt_task_join() call hangs in shared lib
 destructor
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

------=_Part_21_30682745.1303982782859
Content-Type: multipart/alternative; 
	boundary="----=_Part_22_20399973.1303982782859"

------=_Part_22_20399973.1303982782859
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



> It looks like a typical pthread_join deadlock. The thread you are 
> joining is locked on a pthread mutex, that some other thread (I would 
> say, the one calling pthread_join) has. It can not work. You should not 
> call pthread_join while holding a mutex. 

Yes, it looks like this, but I don't use any mutex in my task. It looks like dlclose() locks a mutex used also by pthread_join() (that was called into shared object destructor), and here is deadlock. But executing realtime task as normal thread does not raise this issue. 

Another strange behaviour: if task was not created with rt_task_create()-rt_task_start(), but becomes real time from a thread with rt_task_shadow(), it works properly. 

Summarizing: 
- create task with rt_task_create()-rt_task_start() and join it in shared object destructor with rt_task_join() -> deadlock 
- create a thread with pthread_create(), make it real-time with rt_task_shadow() and join it in destructor with rt_task_join() -> works fine 
- create a thread with pthread_create(), join it in destructor with pthread_join() -> works fine 

Same behaviors on kernel 2.6.37 with Xenomai 2.5.6 Ipipe 2.9-00 . 

> If this is not the issue, would you please take the time to post a 
> self-contained test case which I can run to reproduce the issue? 

Was attached on my first mail, I re-attach it to this mail. I also added 2nd and 3rd case explained above: you can select each case with three #defines into TestMod.c. 

Many thanks, regards. 


------=_Part_22_20399973.1303982782859
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
><style>p { margin: 0; }</style><div style=3D"font-family: Times New Roman;=
 font-size: 12pt; color: rgb(0, 0, 0);"><style>p { margin: 0; }</style><div=
 style=3D"font-family: Times New Roman; font-size: 12pt; color: rgb(0, 0, 0=
);">&gt; It looks like a typical pthread_join deadlock. The thread you are<=
br>&gt; joining is locked on a pthread mutex, that some other thread (I wou=
ld<br>&gt; say, the one calling pthread_join) has. It can not work. You sho=
uld not<br>&gt; call pthread_join while holding a mutex.<br><br>Yes, it loo=
ks like this, but I don't use any mutex in my task. It looks like dlclose()=
 locks a mutex used also by pthread_join() (that was called into shared obj=
ect destructor), and here is deadlock. But executing realtime task as norma=
l thread does not raise this issue.<br><br>Another strange behaviour: if ta=
sk was not created with rt_task_create()-rt_task_start(), but becomes real =
time from a thread with rt_task_shadow(), it works properly.<br><br>Summari=
zing:<br>- create task with rt_task_create()-rt_task_start() and join it in=
 shared object destructor with rt_task_join() -&gt; deadlock<br>- create a =
thread with pthread_create(), make it real-time with rt_task_shadow() and j=
oin it in destructor with rt_task_join() -&gt; works fine<br>- create a thr=
ead with pthread_create(), join it in destructor with pthread_join() -&gt;
works fine<br><br>Same behaviors on kernel 2.6.37 with Xenomai 2.5.6 Ipipe =
2.9-00.<br><br>&gt; If this is not the issue, would you please take the tim=
e to post a<br>&gt; self-contained test case which I can run to reproduce t=
he issue?<br><br>Was attached on my first mail, I re-attach it to this mail=
. I also added 2nd and 3rd case explained above: you can select each case w=
ith three #defines into TestMod.c.<br><br>Many thanks, regards.<br><br></di=
v></div></div></body></html>
------=_Part_22_20399973.1303982782859--

------=_Part_21_30682745.1303982782859
Content-Type: application/x-zip-compressed; name=sample.zip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=sample.zip

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
------=_Part_21_30682745.1303982782859--

