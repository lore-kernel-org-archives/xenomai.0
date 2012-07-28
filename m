Message-ID: <1343510686.76906.YahooMailNeo@web193904.mail.sg3.yahoo.com>
Date: Sun, 29 Jul 2012 05:24:46 +0800 (SGT)
From: Uttamkumar Sinojia <uttamkumarsinojia@yahoo.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Jitter-test
Reply-To: Uttamkumar Sinojia <uttamkumarsinojia@yahoo.in>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0A=0A> wake-up time of more than one task is same, in such case which t=
ask=0A> will wake-up first can not be predicted. But as per the output (sho=
wn=0A> below), the task with higher priority=A0 is woken-up first----WHY=0A=
> SO??????=0A=0A=0A=0ASorry, the statement is like this...=0A=0AHere as all=
 the task are having same priority. So when expected wake-up time of more t=
han one task is same, in such case which task will wake-up first can not be=
 predicted. But as per the output, the task with higher period=A0is woken-u=
p first----WHY SO?????? =0A=0ALet me tell more...=0AHere (as per the code) =
all task are having same priority(5).=0ABut configured periodic in such a w=
ay that all will wake-up at the same time(say t1).(ret =3D rt_task_set_peri=
odic(NULL, task_pstart_time, PERIOD_n);)=0APERIOD_n =A0task1->1ms, task2->2=
ms, task3->3ms, task4->4ms, task5->5ms.=0A=0ASo,=A0=0Awith respect to t1 af=
ter 1ms of time my first task (task1) will wake-up.=0A=0AAnd again with res=
pect to t1 after 2ms of time there will be two task going to wake-up(task1-=
1ms, task2-2ms). So in this case (as priority of both the task are same), w=
hich task will wake-up first should be non-deterministic. But i am getting=
=A0deterministic=A0behavior. Task with higher period (Here task2) is woken-=
up first than after task1 is woken-up ???=0A=0AIn short i want to tell that=
,=A0=0AI have given same priority to all the task, but output it is behavin=
g like=0A=A0task5 is having highest priority=0A=A0task4's priority is lower=
 than task5 but higher than task3=0A=0A=A0task3's priority is lower than ta=
sk4 but higher than task2=A0=0A=0A=A0task2's priority is lower than task3 b=
ut higher than task1=A0=0A=0A=A0task1 is having lowest priority=A0=0A=0A???=
???????
