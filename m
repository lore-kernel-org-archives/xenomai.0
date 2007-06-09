Message-ID: <1807.194.254.210.7.1181405163.squirrel@domain.hid>
In-Reply-To: <46697391.4080006@domain.hid>
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid> 
	<4668440F.7020706@domain.hid>
	<1753.194.254.210.7.1181246882.squirrel@domain.hid>
	<46697391.4080006@domain.hid>
Date: Sat, 9 Jun 2007 18:06:03 +0200 (CEST)
From: desvages@domain.hid
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] real time task disapears... memory problem ?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

>
> From my kernel console after running your program for a few seconds:
>
> Xenomai: watchdog triggered -- killing runaway thread 'MyAlarmServer'
>
> Previously, "rt_alarm_wait" was printed on the console, thus gsl_qp()
> likely entered some infinite loop. You have the watchdog enabled as
> well, so you should see the same effect, right?
>
> Jan

In my console, I only see the "rt_alarm_wait". Is there something to
activate to enable xenomai errors messages ?

As this gsl_qp() function takes about 6/7 secondes to solve my quadratic
problem, the watchdog could effectively be the thing that goes wrong...

To be sure to understand how works the watchdog in xenomai:
- Is it a limit on the execution time (so time effectively used by the ta=
sk)
- or is it a limit on the response time (the time between the beginning
and the end of the task, even if it is preempted) ?

Because, if it is the first case, maybe that putting the gsl_qp() functio=
n
in primary mode increases the execution time measured by xenomai, and thi=
s
activate the watchdog ? whereas in secondary mode, time is not counted by
xenomai watchdog ?

I will try to increase the watchdog time to see if this is only a matter
of a task taking to much time.


Thanks a lot for your help !

Arnaud DESVAGES


