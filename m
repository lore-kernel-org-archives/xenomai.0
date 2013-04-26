References: <1366732845.34430.YahooMailNeo@web161405.mail.bf1.yahoo.com>
	<5176B0E3.3030009@xenomai.org>
	<1366738934.20080.YahooMailNeo@web161406.mail.bf1.yahoo.com>
	<517A53E7.2030304@xenomai.org>
Message-ID: <1366989234.58956.YahooMailNeo@web161403.mail.bf1.yahoo.com>
Date: Fri, 26 Apr 2013 08:13:54 -0700 (PDT)
From: Tom Z <tomz30@yahoo.com>
In-Reply-To: <517A53E7.2030304@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] rt_task_wait_period returns -11 (-EAGAIN)
Reply-To: Tom Z <tomz30@yahoo.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

After a code review, I think I now know what is going on there. My program =
contains two parts, a user-space rt_task, and a kernel-space task. While th=
e user-space task is waiting for its next release point (rt_task_wait_perio=
d), the kernel task calls rt_task_suspend and rt_task_resume to suspend and=
 resume that user-space task occasionally, which should not be done.=A0 I d=
on't know whether  rt_task_suspend or rt_task_resume causes the user-space =
rt_task_wait_period() to return prematurely, but it seems that where the ca=
use is. And after I fixed this bug, the problem was gone.=0A=0AThanks a lot=
!=0A=0A=0A=0A=0A________________________________=0A From: Philippe Gerum <r=
pm@xenomai.org>=0ATo: Tom Z <tomz30@yahoo.com> =0ACc: "xenomai@xenomai.org"=
 <xenomai@xenomai.org> =0ASent: Friday, 26 April 2013 5:16 AM=0ASubject: Re=
: [Xenomai] rt_task_wait_period returns -11 (-EAGAIN)=0A =0A=0AOn 04/23/201=
3 07:42 PM, Tom Z wrote:=0A> Hi Philippe,=0A>=0A> Thanks for answering my p=
revious question. However, I encountered=0A> another one regarding rt_task_=
wait_period(). NowI fixed a problematic=0A> parameter in rt_task_set_period=
ic(), and add the checking of the return=0A> values of rt_task_wait_period(=
) and rt_task_set_periodic(). I use=0A> rt_task_set_periodic()to set a peri=
od of 500 ms for a rt_task, and call=0A> rt_task_wait_period() later. It se=
ems that sometimes=0A> rt_task_wait_period()works good, but sometimes it ju=
st returns 0=0A> immediately. Here is what my code looks like:=0A>=0A> unsi=
gned long overrun;=0A> RTIME release_time;=0A>=0A> if (0 !=3D rt_task_set_p=
eriodic(NULL, TM_NOW, 500000000){=0A>=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rt_pri=
ntf("Error\n");=0A> }=0A> ....=0A> while (1){=0A> release_time =3D rt_timer=
_read();=0A> //Store release_time in an array for offline analysis=0A> //So=
me computation taking about 100 ms=0A> if (0 !=3D rt_task_wait_period(&over=
run)){=0A>=A0 =A0 =A0 =A0 =A0 =A0 =A0  rt_printf("Error\n");=0A>=A0 =A0 =A0=
 =A0 }=0A> }=0A>=0A>=0A> I noticed that, during the program's execution, no=
 "Error" was printed,=0A> but some consecutive values of release_time is ab=
out 100 ms which is the=0A> computation time and far less than the period 5=
00 ms.=0A>=0A> This problem seems weird to me. Did I possibly overlook some=
thing?=0A>=0A=0AWhat does "some consecutive values" mean in this report, wh=
at about the =0Aother values? Also, how do you observe this behavior, by lo=
oking at the =0Apace of rt_printf's output?=0A=0AIf so, I would suggest to =
log all release times and wait_period() return =0Acodes in an array, perfor=
ming the sampling loop silently. Then check the =0Aarray for spurious sampl=
es, i.e. error returns or weird intervals =0Abetween samples.=0A=0A-- =0APh=
ilippe.
