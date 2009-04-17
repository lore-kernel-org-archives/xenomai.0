Message-ID: <178051.15015.qm@domain.hid>
Date: Thu, 16 Apr 2009 21:12:33 -0700 (PDT)
From: luan dinh <dinhluanbmt@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1244569274-1239941553=:15015"
Subject: [Xenomai-help] xenomai - realtime task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--0-1244569274-1239941553=:15015
Content-Type: text/plain; charset=us-ascii

hi all.
i write a real-time task by using Native API such as :rt_task_create(), rt_task_start(rttask_demo,..)...

void rttask_demo(void *arg)
{
.../* posix API*/
}
In rttask_demo body code i use standard POSIX API such as : socket(), send(), recev() to connect to Network base on original Network driver.
in this case, does my rttask_demo execute as hard-realtime ?
I'm a newbabie in Xenomai
thanks for any advise.
Luan Dinh




      
--0-1244569274-1239941553=:15015
Content-Type: text/html; charset=us-ascii

<table cellspacing="0" cellpadding="0" border="0" ><tr><td valign="top" style="font: inherit;">hi all.<br>i write a real-time task by using Native API such as :rt_task_create(), rt_task_start(rttask_demo,..)...<br><br>void rttask_demo(void *arg)<br>{<br>.../* posix API*/<br>}<br>In rttask_demo body code i use standard POSIX API such as : socket(), send(), recev() to connect to Network base on original Network driver.<br>in this case, does my rttask_demo execute as hard-realtime ?<br>I'm a newbabie in Xenomai<br>thanks for any advise.<br>Luan Dinh<br><br></td></tr></table><br>



      
--0-1244569274-1239941553=:15015--

