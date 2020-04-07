Subject: =?utf-8?q?Re=3A_rt=5Ftask=5Funblock=28=29_POSIX_alternative?=
Date: Tue, 07 Apr 2020 17:18:16 +0200
From: =?utf-8?q?Petr_=c4=8cervenka?= <grugh@centrum.cz>
References: <20200407154117.5D7D71C2@centrum.cz>
 <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
In-Reply-To: <b9ce43ab-526d-71b8-c761-150dc7c1fd3f@siemens.com>
MIME-Version: 1.0
Message-Id: <20200407171816.E0B3979D@centrum.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?utf-8?q?Jan_Kiszka?= <jan.kiszka@siemens.com>, Xenomai <xenomai@xenomai.org>

Hello Jan.
And if I don't want to totally remove the thread? Only to interrupt the wai=
ting and react according to new events (like reconfiguring something or sta=
rting to wait on different resource).
Is there some pthread_create... or sched_... parameter or flag, that the ta=
sk's system call can be interruptible?
And how to use the signals to interrupt it? Call of kill(task_pid, SIGINT) =
didn't helped.
Petr
=C2=A0
______________________________________________________________
> From "Jan Kiszka" <jan.kiszka@siemens.com>
>
On 07.04.20 15:41, Petr =C4=8Cervenka via Xenomai wrote:
 > Hello everyone.
 > I there a rt_task_unblock() Xenomai POSIX skin alternative?
 > I created an example of periodic POSIX task, similar to the latency exam=
ple but with very long period. When I receive a INT signal I set the end fl=
ag and I would like to unblock a task that waits on read(timerfd). But all =
my attempts led to standard wait timeout or worse.
=20
 Try pthread_cancel(). If you need to run some cleanup code in the target=
=20
 thread, use pthread_cleanup_push. None of that would be with real-time=20
 qualities, though. But I assume that the cleanup is not a time-critical=20
 path, is it?
=20
 Sending a Linux signal would be another way to interrupt the target task.
=20
 Jan
=20
 --=20
 Siemens AG, Corporate Technology, CT RDA IOT SES-DE
 Corporate Competence Center Embedded Linux

