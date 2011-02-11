Date: Fri, 11 Feb 2011 09:10:49 +0100 (CET)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <15658959.21297411846156.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <8701358.01297411757328.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1_14608998.1297411846156"
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

------=_Part_1_14608998.1297411846156
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

> Well, looking at the code, this should not happen. The question is: how 
> do you ensure, in the code that calls rt_task_join, that the thread 
> being created had the time to call rt_task_shadow? In other words, are 
> you sure that you are not passing rt_task_join an uninitialized RT_TASK? 

> So, as usual, we are missing a simple standalone test showing the issue 
> you have. 

There was a subtle bug that realizes exactly what you explained, thank you! 
Question is: after a successful rt_task_shadow() call done by a pthread, we can forget that this rt-task 
was created as pthread and then we must handle it with rt_task_* procedures, is it right? 
In other words, does pthread become a RT_TASK at all, as if it was created with rt_task_create()? 

Thanks again, Gilles. 

------=_Part_1_14608998.1297411846156
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
>&gt; Well, looking at the code, this should not happen. The question is: h=
ow<br>&gt; do you ensure, in the code that calls rt_task_join, that the thr=
ead<br>&gt; being created had the time to call rt_task_shadow? In other wor=
ds, are<br>&gt; you sure that you are not passing rt_task_join an uninitial=
ized RT_TASK?<br><br>&gt; So, as usual, we are missing a simple standalone =
test showing the issue<br>&gt; you have.<br><br>There was a subtle bug that=
 realizes exactly what you explained, thank you!<br>Question is: after a su=
ccessful rt_task_shadow() call done by a pthread, we can forget that this r=
t-task<br>was created as pthread and then we must handle it with rt_task_* =
procedures, is it right?<br>In other words, does pthread become a RT_TASK a=
t all, as if it was created with rt_task_create()?<br><br>Thanks again, Gil=
les.<br></div></body></html>
------=_Part_1_14608998.1297411846156--

